
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';


class Report extends StatelessWidget {
  const Report({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: SizedBox(
          height: height,
          width: width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 21),
                child: SizedBox(
                  height: 170,
                  child: ResponsiveGridList(
                      horizontalGridSpacing: 16,
                      horizontalGridMargin: 20,
                      minItemWidth: 270,
                      minItemsPerRow: 1,
                      maxItemsPerRow: 10,
                      listViewBuilderOptions: ListViewBuilderOptions(
                          scrollDirection: Axis.horizontal),
                      children: List.generate(
                        4,
                        (index) => InkWell(
                          onTap: () {
                           
                          },
                          child: Container(
                            height: height / 5.5,
                            width: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(11),
                                color: index == 0
                                    ? const Color.fromARGB(255, 237, 125, 117)
                                    : index == 1
                                        ? const Color.fromARGB(
                                            255, 97, 154, 201)
                                        : index == 2
                                            ? const Color.fromARGB(
                                                255, 110, 226, 206)
                                            : const Color.fromARGB(
                                                255, 198, 101, 215)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        index == 0
                                            ? 'Companies we deal'
                                            : index == 1
                                                ? 'Add new Company'
                                                : index == 2
                                                    ? 'Add new Pincodes'
                                                    : 'Our Pincodes',
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.7),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Text(
                                        '12,00',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 32,
                                      ),
                                      Text(
                                        'Increased by 60%',
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.7),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      Icon(
                                        index == 0
                                            ? Icons.people
                                            : index == 1
                                                ? Icons.currency_exchange
                                                : index == 2
                                                    ? Icons.ring_volume
                                                    : Icons.place,
                                        color: Colors.white,
                                        size: 33,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )),
                ),
              ),
              Spacer(),
              MediaQuery.of(context).size.width < 1000
                  ? SingleChildScrollView(
                      child: SizedBox(
                        height: height - 250,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 50),
                              child: Container(
                                height: height - 400,
                                width: width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: const Color.fromARGB(
                                                  255, 102, 100, 100)
                                              .withOpacity(0.2),
                                          spreadRadius: 1,
                                          blurRadius: 1)
                                    ]),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 21, top: 11),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 11, vertical: 6),
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 4, 63, 111),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: const Text(
                                          'Our Companies',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: height - 285,
                                      child: ResponsiveGridList(
                                          horizontalGridSpacing: 0,
                                          horizontalGridMargin: 0,
                                          //verticalGridSpacing: 11,
                                          verticalGridMargin: 11,
                                          minItemWidth: 270,
                                          minItemsPerRow: 1,
                                          maxItemsPerRow: 1,
                                          listViewBuilderOptions:
                                              ListViewBuilderOptions(
                                                  scrollDirection:
                                                      Axis.vertical),
                                          children: List.generate(
                                            11,
                                            (index) => Container(
                                              height: 42,
                                              width: width,
                                              color:
                                                  Colors.blue.withOpacity(0.1),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Sun Pharmaceuticals',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Text(
                                                      'Preet nagar,Ludhiana',
                                                      style: TextStyle(
                                                          color: Colors.black
                                                              .withOpacity(0.6),
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    const SizedBox(
                                                      height: 32,
                                                    ),
                                                    Text(
                                                      'punjab',
                                                      style: TextStyle(
                                                          color: Colors.black
                                                              .withOpacity(0.6),
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: height - 400,
                              width: width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: const Color.fromARGB(
                                                255, 102, 100, 100)
                                            .withOpacity(0.2),
                                        spreadRadius: 1,
                                        blurRadius: 1)
                                  ]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 21, top: 11),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 11, vertical: 6),
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 4, 63, 111),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: const Text(
                                        'Areawise Pincodes',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height - 285,
                                    child: ResponsiveGridList(
                                        horizontalGridSpacing: 16,
                                        horizontalGridMargin: 20,
                                        //verticalGridSpacing: 11,
                                        verticalGridMargin: 11,
                                        minItemWidth: 270,
                                        minItemsPerRow: 1,
                                        maxItemsPerRow: 1,
                                        listViewBuilderOptions:
                                            ListViewBuilderOptions(
                                                scrollDirection: Axis.vertical),
                                        children: List.generate(
                                          11,
                                          (index) => Container(
                                            height: 42,
                                            width: width / 2.6,
                                            color: Colors.blue.withOpacity(0.1),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Baba deep nagar',
                                                    style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(0.6),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(
                                                    'Ludhiana',
                                                    style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(0.6),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  const SizedBox(
                                                    height: 32,
                                                  ),
                                                  Text(
                                                    '141006',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: height - 240,
                          width: width / 2.4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color:
                                        const Color.fromARGB(255, 102, 100, 100)
                                            .withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 1)
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 21, top: 11),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 11, vertical: 6),
                                  decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(255, 4, 63, 111),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: const Text(
                                    'Our Companies',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height - 285,
                                child: ResponsiveGridList(
                                    horizontalGridSpacing: 16,
                                    horizontalGridMargin: 20,
                                    //verticalGridSpacing: 11,
                                    verticalGridMargin: 11,
                                    minItemWidth: 270,
                                    minItemsPerRow: 1,
                                    maxItemsPerRow: 1,
                                    listViewBuilderOptions:
                                        ListViewBuilderOptions(
                                            scrollDirection: Axis.vertical),
                                    children: List.generate(
                                      11,
                                      (index) => Container(
                                        height: 42,
                                        width: width / 2.6,
                                        color: Colors.blue.withOpacity(0.1),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Sun Pharmaceuticals',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Text(
                                                'Preet nagar,Ludhiana',
                                                style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(0.6),
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              const SizedBox(
                                                height: 32,
                                              ),
                                              Text(
                                                'punjab',
                                                style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(0.6),
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: height - 240,
                          width: width / 2.4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color:
                                        const Color.fromARGB(255, 102, 100, 100)
                                            .withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 1)
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 21, top: 11),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 11, vertical: 6),
                                  decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(255, 4, 63, 111),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: const Text(
                                    'Areawise Pincodes',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height - 285,
                                child: ResponsiveGridList(
                                    horizontalGridSpacing: 16,
                                    horizontalGridMargin: 20,
                                    //verticalGridSpacing: 11,
                                    verticalGridMargin: 11,
                                    minItemWidth: 270,
                                    minItemsPerRow: 1,
                                    maxItemsPerRow: 1,
                                    listViewBuilderOptions:
                                        ListViewBuilderOptions(
                                            scrollDirection: Axis.vertical),
                                    children: List.generate(
                                      11,
                                      (index) => Container(
                                        height: 42,
                                        width: width / 2.6,
                                        color: Colors.blue.withOpacity(0.1),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Baba deep nagar',
                                                style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(0.6),
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Text(
                                                'Ludhiana',
                                                style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(0.6),
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              const SizedBox(
                                                height: 32,
                                              ),
                                              Text(
                                                '141006',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
