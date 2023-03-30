import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:universal_html/html.dart';

import 'controller.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController areaController = TextEditingController();

  TextEditingController useridController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobilenumberController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController designationController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  String location='';

   Future getadmindata(String id) async {
    await FirebaseFirestore.instance
        .collection('admins')
        .doc(id)
        .get()
        .then((value) {
      if (value.exists) {
        setState(() {
          location = value.get('Location');
          //pass = value.get('password');
        });
        
      
        
      }
    });
  }

    String localtoken = '';
  checkLogin() {
    String? token = window.localStorage['userid'];

    if (token != null) {
      setState(() {
        localtoken = token;
      });
    } else {
      setState(() {
        localtoken = '';
      });
    }
    print(localtoken);
    //log('user number is splash $token');
  }




  Future<void> newAgent() async {
    await FirebaseFirestore.instance.collection('agents').doc(passwordController.text).set({
      'location':location,
      'userid': useridController.text,
      'password': passwordController.text,
      'name': firstnameController.text,
      'Area': areaController.text,
      'email': emailController.text,
      'mobile_number': mobilenumberController.text,
      'designation': designationController.text,
      'register_date': dateController.text,
    }).whenComplete(() {});
  }


   Future check() async {
                            final Query query = FirebaseFirestore.instance
                                .collection('agents')
                                .where('userid',
                                    isEqualTo: useridController.text);

                            query.get().then((querySnapshot) {
                              if (querySnapshot.size > 0) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text('This userid is already exist'),
                                    backgroundColor: Colors.red,
                                    behavior: SnackBarBehavior.floating,
                                    margin: const EdgeInsets.all(10),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                );
                              } else {
                              newAgent();
                              }
                            }).catchError((error) {
                              // Handle any errors
                            });
                          }


  @override
  void initState() {
    checkLogin();
    // TODO: implement initState
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: mobileView(context),
      tablet: mobileView(context),
      desktop: desktopView(context),
    );
  }

  desktopView(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        const SizedBox(
          width: 70,
        ),
        SizedBox(
          height: height,
          width: width / 1.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 43,
                  width: 700,
                  color: Colors.blue.withOpacity(0.1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        'Add New Agent',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height / 1.2,
                child: ResponsiveGridList(
                    horizontalGridSpacing: 16,
                    horizontalGridMargin: 20,
                    minItemWidth: 270,
                    minItemsPerRow: 1,
                    maxItemsPerRow: 1,
                    listViewBuilderOptions:
                        ListViewBuilderOptions(scrollDirection: Axis.vertical),
                    children: List.generate(
                      8,
                      (index) => SizedBox(
                        height: 70,
                        width: width / 2.5,
                        child: Row(children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          SizedBox(
                            width: 140,
                            child: Text(
                              index == 0
                                  ? 'Username'
                                  : index == 1
                                      ? 'Name'
                                      : index == 2
                                          ? 'Location'
                                          : index == 3
                                              ? 'Email'
                                              : index == 4
                                                  ? 'Mobile Number'
                                                  : index == 5
                                                      ? 'Register date'
                                                      : index == 6
                                                          ? 'Designation'
                                                          : 'Password',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.7),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: 60,
                              width: width / 3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: const Color.fromARGB(
                                                255, 102, 100, 100)
                                            .withOpacity(0.4),
                                        spreadRadius: 1,
                                        blurRadius: 1)
                                  ]),
                              child: Padding(
                                padding: EdgeInsets.only(left: 15, bottom: 6),
                                child: TextField(
                                  controller: index == 0
                                      ? useridController
                                      : index == 1
                                          ? firstnameController
                                          : index == 2
                                              ? areaController
                                              : index == 3
                                                  ? emailController
                                                  : index == 4
                                                      ? mobilenumberController
                                                      : index == 5
                                                          ? dateController
                                                          : index == 6
                                                              ? dateController
                                                              : passwordController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Enter username',
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 14),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    )),
              ),
            ],
          ),
        ),
        const Spacer(),
        Container(
          height: height,
          width: width / 3.6,
          color: Colors.blue.withOpacity(0.1),
          child: Column(
            children: [
              SizedBox(
                height: height / 2,
                child: ResponsiveGridList(
                    horizontalGridSpacing: 16,
                    horizontalGridMargin: 20,
                    minItemWidth: 270,
                    minItemsPerRow: 1,
                    maxItemsPerRow: 1,
                    listViewBuilderOptions:
                        ListViewBuilderOptions(scrollDirection: Axis.vertical),
                    children: List.generate(
                      4,
                      (index) => SizedBox(
                        height: 70,
                        width: width / 4.5,
                        child: Row(children: [
                          const Icon(
                            Icons.menu,
                            color: Colors.grey,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: 60,
                              width: width / 5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: const Color.fromARGB(
                                                255, 102, 100, 100)
                                            .withOpacity(0.4),
                                        spreadRadius: 1,
                                        blurRadius: 1)
                                  ]),
                              child: const Padding(
                                padding: EdgeInsets.only(left: 15, bottom: 6),
                                child: TextField(
                                  //controller: control,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Additional information',
                                    hintStyle: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    )),
              ),
              const Spacer(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 25),
                child: Container(
                  height: 48,
                  width: width / 4.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    gradient: const LinearGradient(
                        colors: [Colors.blue, Color.fromARGB(255, 8, 71, 123)],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight),
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      if (
                          useridController.text.isNotEmpty &&
                         areaController.text.isNotEmpty&&
                          passwordController.text.isNotEmpty) {
                           
                            getadmindata(localtoken);
                             check();
                      
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                const Text('Please fill all mandatory fields'),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                            margin: const EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        );
                      }
                     
                    },
                    //color: Colors.blue,
                    height: 38,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Add User',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        )
      ],
    );
  }

  dialog(BuildContext context) {
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
                const Text(
                  "You'r all set!",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  width: 250,
                  child: Text(
                    'Click ok button to add new agent',
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
                     
                    check();
                      Navigator.pop(context);
                     
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


  mobileView(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 3, 50, 88),
        leading: const BackButton(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 43,
              width: width,
              color: Colors.blue.withOpacity(0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    'Add New Agent',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: height / 1.4,
            child: ResponsiveGridList(
                horizontalGridSpacing: 16,
                horizontalGridMargin: 20,
                minItemWidth: 270,
                minItemsPerRow: 1,
                maxItemsPerRow: 1,
                listViewBuilderOptions:
                    ListViewBuilderOptions(scrollDirection: Axis.vertical),
                children: List.generate(
                  8,
                  (index) => SizedBox(
                    height: 85,
                    width: width / 2.5,
                    child: Column(children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          SizedBox(
                            width: 140,
                            child: Text(
                              index == 0
                                  ? 'Username'
                                  : index == 1
                                      ? 'Name'
                                      : index == 2
                                          ? 'Area'
                                          : index == 3
                                              ? 'Email'
                                              : index == 4
                                                  ? 'Mobile Number'
                                                  : index == 5
                                                      ? 'Register date'
                                                      : index == 6
                                                          ? 'Designation'
                                                          : 'Password',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.7),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 40,
                          width: width - 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color:
                                        const Color.fromARGB(255, 102, 100, 100)
                                            .withOpacity(0.4),
                                    spreadRadius: 1,
                                    blurRadius: 1)
                              ]),
                          child: Padding(
                            padding: EdgeInsets.only(left: 15, bottom: 11),
                            child: TextField(
                              controller: index == 0
                                  ? useridController
                                  : index == 1
                                      ? firstnameController
                                      : index == 2
                                          ? areaController
                                          : index == 3
                                              ? emailController
                                              : index == 4
                                                  ? mobilenumberController
                                                  : index == 5
                                                      ? dateController
                                                      : index == 6
                                                          ? dateController
                                                          : passwordController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter username',
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                )),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 25),
            child: Container(
              height: 48,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: const LinearGradient(
                    colors: [Colors.blue, Color.fromARGB(255, 8, 71, 123)],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight),
              ),
              child: MaterialButton(
                onPressed: () {
                  if (firstnameController.text.isNotEmpty &&
                      mobilenumberController.text.isNotEmpty &&
                      useridController.text.isNotEmpty &&
                      emailController.text.isNotEmpty &&
                      designationController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty) {
                    newAgent();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Please fill all mandatory fields'),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                        margin: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    );
                  }
                },
                //color: Colors.blue,
                height: 38,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Add User',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}