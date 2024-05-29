// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ChooseLanguageScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  ChooseLanguageScreen({super.key, required this.argus});

  @override
  State<ChooseLanguageScreen> createState() => _ChooseLanguageScreenState();
}

class _ChooseLanguageScreenState extends State<ChooseLanguageScreen> {
  bool? isSelected;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: screenSize.height * 0.01,
          backgroundColor: Colors.blue,
          leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.language,
                    size: 30,
                    color: Color.fromARGB(255, 31, 1, 102),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Select Language',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenSize.height * 0.06,
              ),
              SizedBox(
                // height: screenSize.height * 0.8,
                // width: screenSize.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.count(
                    shrinkWrap: true,
                    childAspectRatio: (1 / .6),
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2, // Changed from 2 to 1
                    crossAxisSpacing: screenSize.width * 0.01,
                    mainAxisSpacing: screenSize.height * 0.006,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            isSelected = true;
                          });
                        },
                        child: Card(
                          color: Colors.red[50],
                          surfaceTintColor:
                              const Color.fromARGB(255, 31, 1, 102),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 10.0),
                                child: Text(
                                  'English',
                                  style: TextStyle(
                                    color: Colors.red[300],
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  (isSelected == true)
                                      ? Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                          size: screenSize.height * 0.04,
                                        )
                                      : const Icon(null),
                                  Image.asset(
                                    "resources/images/english_lang-removebg-preview.png",
                                    height: screenSize.height * 0.07,
                                    width: screenSize.width * 0.15,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        // onTap: () {
                        //   isSelected = false;
                        // },
                        child: Card(
                          color: const Color.fromARGB(255, 237, 215, 240),
                          surfaceTintColor:
                              const Color.fromARGB(255, 237, 215, 240),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 10.0),
                                child: Text(
                                  'Hindi',
                                  style: TextStyle(
                                    color: Colors.red[300],
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  (isSelected == false)
                                      ? Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                          size: screenSize.height * 0.04,
                                        )
                                      : const Icon(null),
                                  Image.asset(
                                    "resources/images/hindi_lang-removebg-preview.png",
                                    height: screenSize.height * 0.07,
                                    width: screenSize.width * 0.15,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        // onTap: () {
                        //   isSelected = true;
                        // },
                        child: Card(
                          color: Colors.blue[100],
                          surfaceTintColor: Colors.blue[100],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 10.0),
                                child: Text(
                                  'Telugu',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  (isSelected == false)
                                      ? Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                          size: screenSize.height * 0.04,
                                        )
                                      : const Icon(null),
                                  Image.asset(
                                    "resources/images/telugu_lang-removebg-preview.png",
                                    height: screenSize.height * 0.07,
                                    width: screenSize.width * 0.15,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        // onTap: () {
                        //   isSelected = true;
                        // },
                        child: Card(
                          color: Colors.yellow[50],
                          surfaceTintColor: Colors.yellow[50],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 10.0),
                                child: Text(
                                  'Marathi',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 246, 173, 2),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  (isSelected == false)
                                      ? Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                          size: screenSize.height * 0.04,
                                        )
                                      : const Icon(null),
                                  Image.asset(
                                    "resources/images/marathi_lang-removebg-preview.png",
                                    height: screenSize.height * 0.07,
                                    width: screenSize.width * 0.15,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        // onTap: () {
                        //   isSelected = true;
                        // },
                        child: Card(
                          color: Colors.red[50],
                          surfaceTintColor: Colors.red[50],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 10.0),
                                child: Text(
                                  'Kannada',
                                  style: TextStyle(
                                    color: Colors.red[300],
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  (isSelected == false)
                                      ? Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                          size: screenSize.height * 0.04,
                                        )
                                      : const Icon(null),
                                  Image.asset(
                                    "resources/images/kannada-removebg-preview.png",
                                    height: screenSize.height * 0.07,
                                    width: screenSize.width * 0.15,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        // onTap: () {
                        //   isSelected = true;
                        // },
                        child: Card(
                          color: Colors.brown[50],
                          surfaceTintColor: Colors.red[50],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 10.0),
                                child: Text(
                                  'Tamil',
                                  style: TextStyle(
                                    color: Colors.brown[300],
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  (isSelected == false)
                                      ? Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                          size: screenSize.height * 0.04,
                                        )
                                      : const Icon(null),
                                  Image.asset(
                                    "resources/images/tamil_lang-removebg-preview.png",
                                    height: screenSize.height * 0.07,
                                    width: screenSize.width * 0.15,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      // Add more containers here if needed
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 190.0,
              ),
              InkWell(
                onTap: () {
                 Navigator.pushNamed(context, '/accounts');
                },
                child: Container(
                  width: screenSize.width,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 31, 1, 102),
                      borderRadius: BorderRadius.circular(30.0)),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 30.0,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  child: const Center(
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
