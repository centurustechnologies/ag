import 'package:ag_financial_admin_pannel/addagent.dart';
import 'package:ag_financial_admin_pannel/agentleads.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:universal_html/html.dart';

class Agents extends StatefulWidget {
  final String ids;
  const Agents({
    super.key,
    required this.ids,
  });

  @override
  State<Agents> createState() => _AgentsState();
}

class _AgentsState extends State<Agents> {
  final CollectionReference chat =
      FirebaseFirestore.instance.collection('agents');

  String location = '';
  String name = '';
  Future getadmindata() async {
    await FirebaseFirestore.instance
        .collection('admins')
        .doc(widget.ids)
        .get()
        .then((value) {
      if (value.exists) {
        setState(() {
          location = value.get('Location');
          name = value.get('userid');
        });
      }
    });
  }

  bool newuser = false;
  bool agentlead = false;
  String token = '';
  bool agents = false;
  bool password = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getadmindata();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ScreenTypeLayout(
      mobile: mobileView(context),
      tablet: mobileView(context),
      desktop: desktopView(context),
    );
  }

  desktopView(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
        child: newuser
            ? AddUser()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        newuser = true;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 41, bottom: 12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 11, vertical: 6),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 92, 154, 205),
                            borderRadius: BorderRadius.circular(8)),
                        child: const Text(
                          'Add new agent',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      color: Color.fromARGB(255, 5, 66, 116),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: SizedBox(
                              width: width / 12,
                              child: Center(
                                child: const Text(
                                  'User Id',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width / 12,
                            child: const Text(
                              'User Name',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            width: width / 12,
                            child: const Text(
                              'Address',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            width: width / 12,
                            child: const Text(
                              'Mobile Number',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            width: width / 12,
                            child: const Text(
                              'Registration Date',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            width: width / 12,
                            child: const Text(
                              'Password',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height / 2,
                    width: MediaQuery.of(context).size.width,
                    child: StreamBuilder(
                        stream: location == 'ludhiana'
                            ? chat.snapshots()
                            : chat
                                .where('location', isEqualTo: location)
                                .snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                          if (streamSnapshot.hasData) {
                            return ResponsiveGridList(
                                horizontalGridSpacing:
                                    16, // Horizontal space between grid items

                                horizontalGridMargin:
                                    50, // Horizontal space around the grid
                                verticalGridMargin:
                                    20, // Vertical space around the grid
                                minItemWidth:
                                    300, // The minimum item width (can be smaller, if the layout constraints are smaller)
                                minItemsPerRow:
                                    1, // The minimum items to show in a single row. Takes precedence over minItemWidth
                                maxItemsPerRow:
                                    1, // The maximum items to show in a single row. Can be useful on large screens
                                listViewBuilderOptions:
                                    ListViewBuilderOptions(), // Options that are getting passed to the ListView.builder() function
                                children: List.generate(
                                    streamSnapshot.data!.docs.length, (index) {
                                  final DocumentSnapshot documentSnapshot =
                                      streamSnapshot.data!.docs[index];
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        token = documentSnapshot['password'];
                                        agentlead = true;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0),
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: const Color.fromARGB(
                                                          255, 102, 100, 100)
                                                      .withOpacity(0.2),
                                                  spreadRadius: 1,
                                                  blurRadius: 1)
                                            ]),

                                        //color: Colors.amber,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              //crossAxisAlignment: CrossAxisAlignment.,
                                              children: [
                                                SizedBox(
                                                  width: 100,
                                                  child: Text(
                                                    documentSnapshot['userid'],
                                                    style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(0.6),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 120,
                                                  child: Text(
                                                    documentSnapshot['name'],
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.black),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 120,
                                                  child: Text(
                                                    documentSnapshot['Area'],
                                                    style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(0.6),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 120,
                                                  child: Text(
                                                    documentSnapshot[
                                                        'mobile_number'],
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black
                                                            .withOpacity(0.6)),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 120,
                                                  child: Text(
                                                    documentSnapshot[
                                                        'register_date'],
                                                    style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(0.6),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                                password
                                                    ? InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            password = false;
                                                          });
                                                        },
                                                        child: SizedBox(
                                                          width: 100,
                                                          child: Text(
                                                            documentSnapshot[
                                                                'password'],
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.6),
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ),
                                                      )
                                                    : InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            password = true;
                                                          });
                                                        },
                                                        child: SizedBox(
                                                          width: 100,
                                                          child: Text(
                                                            '*******',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.9),
                                                                fontSize: 19,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ),
                                                      )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ); // The list of widgets in the list
                                }));
                          }
                          return const Center(
                              child: CircularProgressIndicator());
                        }),
                  )
                ],
              ));
  }

  mobileView(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddUser()),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 92, 154, 205),
                  borderRadius: BorderRadius.circular(8)),
              child: const Text(
                'Add new agent',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
        SizedBox(
          height: height - 160,
          width: MediaQuery.of(context).size.width,
          child: StreamBuilder(
              stream: chat.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return ResponsiveGridList(
                      horizontalGridSpacing:
                          16, // Horizontal space between grid items

                      horizontalGridMargin:
                          10, // Horizontal space around the grid
                      verticalGridMargin: 10, // Vertical space around the grid
                      minItemWidth:
                          400, // The minimum item width (can be smaller, if the layout constraints are smaller)
                      minItemsPerRow:
                          1, // The minimum items to show in a single row. Takes precedence over minItemWidth
                      maxItemsPerRow:
                          1, // The maximum items to show in a single row. Can be useful on large screens
                      listViewBuilderOptions:
                          ListViewBuilderOptions(), // Options that are getting passed to the ListView.builder() function
                      children: List.generate(streamSnapshot.data!.docs.length,
                          (index) {
                        final DocumentSnapshot documentSnapshot =
                            streamSnapshot.data!.docs[index];
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.5), //New
                                    blurRadius: 1,
                                    spreadRadius: 1)
                              ],
                              borderRadius: BorderRadius.circular(5)),
                          height: height / 4,
                          //color: Colors.amber,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.only(left: 0),
                                      child: Text(
                                        'User Id',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                    Text(
                                      'User Name',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      'Address',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      'Mobile Number',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      'Registration Date',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      'Password',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Column(
                                  //crossAxisAlignment: CrossAxisAlignment.,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      documentSnapshot['userid'],
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.5),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      documentSnapshot['name'],
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.5)),
                                    ),
                                    Text(
                                      documentSnapshot['Area'],
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.5),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      documentSnapshot['mobile_number'],
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.5)),
                                    ),
                                    Text(
                                      '11-08-2022',
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.5),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      documentSnapshot['password'],
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.5)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ); // The list of widgets in the list
                      }));
                }
                return Center(child: CircularProgressIndicator());
              }),
        )
      ],
    );
  }
}
