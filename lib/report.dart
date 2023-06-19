import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PaginationExample extends StatefulWidget {
  @override
  _PaginationExampleState createState() => _PaginationExampleState();
}

class _PaginationExampleState extends State<PaginationExample> {
  final int pageSize = 10; // Number of items to load per page
  int currentPage = 1; // Current page number
  late Stream<QuerySnapshot> dataStream; // Stream to fetch data

  @override
  void initState() {
    super.initState();
    // Load initial data for the first page
    dataStream = loadPage(currentPage);
  }

  Stream<QuerySnapshot> loadPage(int page) {
    // Fetch data from Firestore using pagination
    var collectionRef = FirebaseFirestore.instance.collection('leads');
    var query = collectionRef.orderBy('first_name').limit(pageSize);

    if (page > 1) {
      // Skip items based on the previous page's last item
      query = query.startAfterDocument(lastDocument);
    }

    return query.snapshots().map((snapshot) {
      // Update the last document for the next page
      if (snapshot.docs.isNotEmpty) {
        lastDocument = snapshot.docs.last;
      }
      return snapshot;
    });
  }

  late DocumentSnapshot lastDocument;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagination Example'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: dataStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Extract the documents from the snapshot
            var documents = snapshot.data!.docs;

            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                var document = documents[index];
                // Display your data here
                return ListTile(
                  title: Text(document['first_name']),
                  subtitle: Text(document['first_name']),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          // Show a loading indicator while data is being fetched
          return Center(child: CircularProgressIndicator());
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage - 1,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_back),
            label: 'Previous',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_forward),
            label: 'Next',
          ),
        ],
        onTap: (index) {
          setState(() {
            if (index == 0 && currentPage > 1) {
              // Go to the previous page
              currentPage--;
            } else if (index == 1) {
              // Go to the next page
              currentPage++;
            }
            // Load data for the new page
            dataStream = loadPage(currentPage);
          });
        },
      ),
    );
  }
}
