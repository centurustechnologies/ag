import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:responsive_builder/responsive_builder.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:lottie/lottie.dart';
import 'package:universal_html/html.dart';

class Leads extends StatefulWidget {
  final String ids;
  const Leads({
    super.key,
    required this.ids,
  });

  @override
  State<Leads> createState() => _LeadsState();
}

class _LeadsState extends State<Leads> {
  List category = [
    'Applicant Mobile no.',
    'date of birth',
    'Mother name',
    'Email',
    'pan Number',
    'Existing Card Bank',
    'Existing Card Limit',
    'Current Adress',
    'LandMark',
    'company name',
    'Official adress',
    'Net Monthly Income',
    'ITR Slip',
    'Pin Code'
  ];
  final CollectionReference Payments =
      FirebaseFirestore.instance.collection('leads');

  TextEditingController updatecontroller = TextEditingController();

  Future updateStatus(String id) async {
    FirebaseFirestore.instance
        .collection('leads')
        .doc(id)
        .update({'application_status': updatecontroller.text});
  }

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //checkLogin();
    getadmindata();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: mobileview(context),
      tablet: mobileview(context),
      desktop: desktopView(context),
    );
  }

  dialog(BuildContext context, id) {
    var width = MediaQuery.of(context).size.width;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 250,
                  width: 300,
                  child: Lottie.asset('assets/sucess.json',
                      fit: BoxFit.cover, repeat: true),
                ),
                const SizedBox(
                  height: 48,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 50,
                    width: width / 5.5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: const Color.fromARGB(255, 102, 100, 100)
                                  .withOpacity(0.4),
                              spreadRadius: 1,
                              blurRadius: 1)
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, bottom: 2),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        //inputFormatters: [LowerCaseTextFormatter()],
                        textCapitalization: TextCapitalization.words,
                        controller: updatecontroller,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter present status here',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  width: 250,
                  child: Text(
                    'Click ok button to change status of Applicant',
                    style: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 94, 94, 94),
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 250,
                  child: MaterialButton(
                    onPressed: () {
                      updateStatus(id);
                      Navigator.pop(context);
                      //dialog1(context);
                    },
                    color: const Color.fromARGB(255, 4, 53, 94),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 7, horizontal: 80),
                      child: Text(
                        'ok',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  desktopView(BuildContext context) {
    bool customTileExpanded = true;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.all(15),
      child: SizedBox(
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0),
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width,
                color: const Color.fromARGB(255, 5, 66, 116),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: SizedBox(
                        width: width / 12,
                        child: const Center(
                          child: Text(
                            'Applied Bank',
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
                        'Status',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      width: width / 12,
                      child: const Text(
                        'Applicant',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      width: width / 12,
                      child: const Text(
                        'Agent',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      width: width / 9,
                      child: const Text(
                        'Applied Card',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.start,
                      ),
                    ),
                   
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height / 20,
            ),
            SizedBox(
              height: height / 1.2,
              child: StreamBuilder(
                  stream: location == 'ludhiana'
                      ? Payments.snapshots()
                      : Payments.where('location', isEqualTo: location)
                          .snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      return ResponsiveGridList(
                          horizontalGridSpacing:
                              16, // Horizontal space between grid items
                          //horizontalGridSpacing: 16, // Vertical space between grid items
                          horizontalGridMargin:
                              0, // Horizontal space around the grid

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
                                trailing: SizedBox(
                                  height: 1,
                                  width: 1,
                                ),
                                title: Padding(
                                  padding: const EdgeInsets.only(left: 35),
                                  child: Container(
                                    width: width,
                                    //color: Colors.amber,
                                    //height: height / 21,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      //crossAxisAlignment: CrossAxisAlignment.,
                                      children: [
                                        SizedBox(
                                          width: 100,
                                          child: Text(
                                            documentSnapshot['Bank_name'],
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 120,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 9, vertical: 3),
                                            child: Text(
                                              documentSnapshot[
                                                  'application_status'],
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  color: documentSnapshot[
                                                              'application_status'] ==
                                                          'sucess'
                                                      ? const Color.fromARGB(
                                                          255, 83, 237, 89)
                                                      : Colors.orange),
                                              textAlign: TextAlign.start,
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
                                                textAlign: TextAlign.start,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 120,
                                          child: Text(
                                            documentSnapshot['token'],
                                            style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 120,
                                          child: Row(
                                            children: [
                                              Text(
                                                documentSnapshot['card_type'],
                                                style: const TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.black),
                                                textAlign: TextAlign.end,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                //subtitle: Text('Trailing expansion arrow icon'),
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      //add();
                                      dialog(context, documentSnapshot.id);
                                    },
                                    child: Container(
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
                                              5, // The maximum items to show in a single row. Can be useful on large screens
                                          listViewBuilderOptions:
                                              ListViewBuilderOptions(), // Options that are getting passed to the ListView.builder() function
                                          children: List.generate(14, (index) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 8),
                                                  child: Text(
                                                    category[index],
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.black
                                                            .withOpacity(0.8)),
                                                  ),
                                                ),
                                                Container(
                                                  height: 40,
                                                  width: width / 7,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
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
                                                    padding:
                                                        const EdgeInsets.only(
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
                                                                      : index ==
                                                                              4
                                                                          ? documentSnapshot[
                                                                              'national_id']
                                                                          : index == 5
                                                                              ? documentSnapshot['existing_card_bank_name']
                                                                              : index == 6
                                                                                  ? documentSnapshot['existing_card_limit']
                                                                                  : index == 7
                                                                                      ? documentSnapshot['current_adress']
                                                                                      : index == 8
                                                                                          ? documentSnapshot['landmark']
                                                                                          : index == 9
                                                                                              ? documentSnapshot['companyname']
                                                                                              : index == 10
                                                                                                  ? documentSnapshot['work_place']
                                                                                                  : index == 11
                                                                                                      ? documentSnapshot['gross_monthly_icome']
                                                                                                      : index == 12
                                                                                                          ? documentSnapshot['yearly_return_details']
                                                                                                          : documentSnapshot['pin_code'],
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.black
                                                              .withOpacity(
                                                                  0.7)),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          })),
                                    ),
                                  )
                                ],
                              );
                            }
                            return const CircularProgressIndicator();
                          }) // The list of widgets in the list
                          );
                    }
                    return const Center(child: CircularProgressIndicator());
                  }),
            ),
          ],
        ),
      ),
    );
  }

  mobileview(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: SizedBox(
        width: width,
        height: height,
        child: StreamBuilder(
            stream: Payments.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                return ResponsiveGridList(
                    horizontalGridSpacing:
                        16, // Horizontal space between grid items
                    //horizontalGridSpacing: 16, // Vertical space between grid items
                    horizontalGridMargin:
                        15, // Horizontal space around the grid
                    verticalGridMargin: 5,
                    minItemWidth:
                        300, // The minimum item width (can be smaller, if the layout constraints are smaller)
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
                      return InkWell(
                        onTap: () {
                          dialog(context, documentSnapshot.id);
                        },
                        child: Container(
                          height: height / 1.7,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.5), //New
                                    blurRadius: 3.0,
                                    spreadRadius: 1)
                              ],
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Name',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.6)),
                                    ),
                                    Text(
                                      'Email',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.6)),
                                    ),
                                    Text(
                                      'Phone Number',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.6)),
                                    ),
                                    Text(
                                      'Current adress',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.6)),
                                    ),
                                    Text(
                                      'DOB',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.6)),
                                    ),
                                    Text(
                                      'Mother Name',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.6)),
                                    ),
                                    Text(
                                      'Pan Number',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.6)),
                                    ),
                                    Text(
                                      'City Name',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.6)),
                                    ),
                                    Text(
                                      'State Name',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.6)),
                                    ),
                                    Text(
                                      'Occupation',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.6)),
                                    ),
                                    Text(
                                      'Company Name',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.6)),
                                    ),
                                    Text(
                                      'Designation',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.6)),
                                    ),
                                    Text(
                                      'Adress',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.6)),
                                    ),
                                    Text(
                                      'Monthly Income',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.6)),
                                    ),
                                    Text(
                                      'Gross Yearly Income',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.6)),
                                    ),
                                    Text(
                                      'Existing Card  bank name',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.6)),
                                    ),
                                    Text(
                                      'Card Limit',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.6)),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ': ${documentSnapshot['first_name']}',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.8)),
                                    ),
                                    Text(
                                      ': ${documentSnapshot['email']}',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.8)),
                                    ),
                                    Text(
                                      ': ${documentSnapshot['mobile_number']}',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.8)),
                                    ),
                                    Text(
                                      ': ${documentSnapshot['current_adress']}',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.8)),
                                    ),
                                    Text(
                                      ': ${documentSnapshot['Date_of_birth']}',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.8)),
                                    ),
                                    Text(
                                      ': ${documentSnapshot['mother_name']}',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.8)),
                                    ),
                                    Text(
                                      ': ${documentSnapshot['national_id']}',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.8)),
                                    ),
                                    Text(
                                      ': ${documentSnapshot['first_name']}',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.8)),
                                    ),
                                    Text(
                                      ': ${documentSnapshot['state']}',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.8)),
                                    ),
                                    Text(
                                      ': ${documentSnapshot['first_name']}',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.8)),
                                    ),
                                    Text(
                                      ': ${documentSnapshot['companyname']}',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.8)),
                                    ),
                                    Text(
                                      ': ${documentSnapshot['Designation']}',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.8)),
                                    ),
                                    Text(
                                      ': ${documentSnapshot['work_place']}',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.8)),
                                    ),
                                    Text(
                                      ': ${documentSnapshot['gross_monthly_icome']}',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.8)),
                                    ),
                                    Text(
                                      ': ${documentSnapshot['first_name']}',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.8)),
                                    ),
                                    Text(
                                      ': ${documentSnapshot['existing_card_bank_name']}',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.8)),
                                    ),
                                    Text(
                                      ': ${documentSnapshot['existing_card_limit']}',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.8)),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }));
              }
              return const Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}
