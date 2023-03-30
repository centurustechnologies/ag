import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/placeholder.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:percent_indicator/percent_indicator.dart';

class AgentsLead extends StatefulWidget {
  final String password;
  //final String cardtype;

  const AgentsLead({
    super.key,
    required this.password,
  });

  @override
  State<AgentsLead> createState() => _AgentsLeadState();
}

class _AgentsLeadState extends State<AgentsLead> {
  List category = [
    'Applicant Mobile no.',
    'date of birth',
    'Mother name',
    'Email',
    'Bank name',
    'Card Type',
    'Current Adress',
    'LandMark',
    'company name',
    'Net Monthly Income',
    'ITR Slip',
    'Salary slip'
  ];
  final CollectionReference Payments =
      FirebaseFirestore.instance.collection('leads');

  @override
  Widget build(BuildContext context) {
    bool customTileExpanded = true;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.all(15),
      child: SizedBox(
        //width: width / 1.5,
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 39,
              width: width / 1.1,
              color: const Color.fromARGB(255, 4, 63, 111),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 13,
                  ),
                  Text(
                    'Invoice',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withOpacity(0.6)),
                  ),
                  SizedBox(
                    width: width / 14,
                  ),
                  Text(
                    'Status',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withOpacity(0.6)),
                  ),
                  SizedBox(
                    width: width / 10,
                  ),
                  Text(
                    'Applicant',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withOpacity(0.6)),
                  ),
                  SizedBox(
                    width: width / 10,
                  ),
                  Text(
                    'UserName',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withOpacity(0.6)),
                  ),
                  SizedBox(
                    width: width / 9,
                  ),
                  Text(
                    'Progress',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withOpacity(0.6)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height / 20,
            ),
            SizedBox(
              height: height / 1.2,
              child: StreamBuilder(
                  stream: Payments.where('token', isEqualTo: widget.password)
                      .snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    return ResponsiveGridList(
                        horizontalGridSpacing:
                            16, // Horizontal space between grid items
                        //horizontalGridSpacing: 16, // Vertical space between grid items
                        horizontalGridMargin:
                            50, // Horizontal space around the grid

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
                          if (streamSnapshot.hasData) {
                            return ExpansionTile(
                              trailing: const Icon(
                                Icons.more_vert,
                                color: Colors.grey,
                              ),
                              title: SizedBox(
                                width: width / 1.2,
                                //height: height / 21,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  //crossAxisAlignment: CrossAxisAlignment.,
                                  children: [
                                    const Text(
                                      'INV-306',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: documentSnapshot[
                                                    'application_status'] ==
                                                'Sucess'
                                            ? Colors.green.withOpacity(0.1)
                                            : Colors.orange.withOpacity(0.1),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 9, vertical: 3),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              documentSnapshot[
                                                  'application_status'],
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                  color: documentSnapshot[
                                                              'application_status'] ==
                                                          'Sucess'
                                                      ? Color.fromARGB(
                                                          255, 83, 237, 89)
                                                      : Colors.orange),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 120,
                                      child: Row(
                                        children: [
                                          Text(
                                            documentSnapshot['first_name'],
                                            style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          documentSnapshot['token'],
                                          style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    LinearPercentIndicator(
                                      width: width / 10,
                                      animation: true,
                                      lineHeight: 13.0,
                                      //fillColor: Colors.transparent,
                                      barRadius: const Radius.circular(20),
                                      animationDuration: 2500,

                                      percent: 0.4,
                                      // center: const Text(
                                      //   "80.0%",
                                      //   style: TextStyle(fontSize: 11),
                                      // ),
                                      // ignore: deprecated_member_use
                                      linearStrokeCap: LinearStrokeCap.roundAll,
                                      progressColor:
                                          const Color.fromARGB(255, 4, 63, 111),
                                    ),
                                    Text(
                                      '40%',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.9)),
                                    ),
                                  ],
                                ),
                              ),
                              //subtitle: Text('Trailing expansion arrow icon'),
                              children: <Widget>[
                                Container(
                                  height: height / 2.4,
                                  width: double.infinity,
                                  color: Colors.blue.withOpacity(0.1),
                                  child: ResponsiveGridList(
                                      horizontalGridSpacing:
                                          16, // Horizontal space between grid items
                                      //horizontalGridSpacing: 16, // Vertical space between grid items
                                      horizontalGridMargin:
                                          20, // Horizontal space around the grid
                                      verticalGridMargin: 10,
                                      minItemWidth:
                                          200, // The minimum item width (can be smaller, if the layout constraints are smaller)
                                      minItemsPerRow:
                                          1, // The minimum items to show in a single row. Takes precedence over minItemWidth
                                      maxItemsPerRow:
                                          4, // The maximum items to show in a single row. Can be useful on large screens
                                      listViewBuilderOptions:
                                          ListViewBuilderOptions(), // Options that are getting passed to the ListView.builder() function
                                      children: List.generate(12, (index) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8),
                                              child: Text(
                                                category[index],
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.black
                                                        .withOpacity(0.8)),
                                              ),
                                            ),
                                            Container(
                                              height: 40,
                                              width: width / 7,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(
                                                              0.7), //New
                                                      blurRadius: 1.0,
                                                      spreadRadius: 0.5)
                                                ],
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 12, top: 10),
                                                child: Text(
                                                  index == 0
                                                      ? documentSnapshot[
                                                          'mobile_number']
                                                      : index == 1
                                                          ? documentSnapshot[
                                                              'Date_of_birth']
                                                          : index == 2
                                                              ? documentSnapshot[
                                                                  'mother_name']
                                                              : index == 3
                                                                  ? documentSnapshot[
                                                                      'email']
                                                                  : index == 4
                                                                      ? documentSnapshot[
                                                                          'Bank_name']
                                                                      : index ==
                                                                              5
                                                                          ? documentSnapshot[
                                                                              'card_type']
                                                                          : index == 6
                                                                              ? documentSnapshot['current_adress']
                                                                              : index == 7
                                                                                  ? documentSnapshot['landmark']
                                                                                  : index == 8
                                                                                      ? documentSnapshot['companyname']
                                                                                      : index == 9
                                                                                          ? documentSnapshot['gross_monthly_icome']
                                                                                          : index == 10
                                                                                              ? documentSnapshot['yearly_return_details']
                                                                                              : documentSnapshot['state'],
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black
                                                          .withOpacity(0.7)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      })),
                                )
                              ],
                            );
                          }
                          return const CircularProgressIndicator();
                        }) // The list of widgets in the list
                        );
                  }),
            ),
          ],
        ),
      ),
    ));
  }
}
