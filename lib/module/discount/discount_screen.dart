// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class DiscountScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  DiscountScreen({super.key, required this.argus});

  @override
  State<DiscountScreen> createState() => _DiscountScreenState();
}

class _DiscountScreenState extends State<DiscountScreen> {
  String? percent;
  String? rupees;
  bool ispercent = true;
  @override
  void initState() {
    setState(() {
      ispercent = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/product-detail');
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: const Text(
          'Discount',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 23),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  query: '',
                  delegate: SearchBarDelegate(),
                );
              },
              icon: const Icon(
                Icons.search,
                color: Colors.white,
                size: 25,
              ))
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
                vertical: screenSize.height * 0.01,
                horizontal: screenSize.width * 0.03),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromARGB(255, 203, 202, 202),
                      blurRadius: 6.0,
                      offset: Offset(0.0, 0.1))
                ],
                color: Colors.white),
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: screenSize.width * 0.02),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/service-details', arguments: {
                    "percent": '',
                    "ruppees": 'true',
                    "tax": '',
                  });
                },
                child: ListTile(
                  minLeadingWidth: screenSize.width * 0.01,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: screenSize.height * 0.01),
                  leading: Container(
                    decoration: BoxDecoration(
                        color: Colors.red[100],
                        borderRadius: BorderRadius.circular(10.0)),
                    child: const Padding(
                      padding: EdgeInsets.all(18.0),
                      child: Text(
                        '\u{20B9}',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ),
                  title: const Text(
                    'VsvsVv',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  trailing: const Text(
                    '\u{20B9} ${75}',
                    style: TextStyle(
                        color: Color.fromARGB(255, 31, 1, 102), fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/service-details', arguments: {
                "percent": 'true',
                "ruppees": '',
                "tax": '',
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(
                  vertical: screenSize.height * 0.01,
                  horizontal: screenSize.width * 0.03),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(255, 203, 202, 202),
                        blurRadius: 6.0,
                        offset: Offset(0.0, 0.1))
                  ],
                  color: Colors.white),
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: screenSize.width * 0.02),
                child: ListTile(
                    minLeadingWidth: screenSize.width * 0.01,
                    contentPadding: EdgeInsets.symmetric(
                        vertical: screenSize.height * 0.01),
                    leading: Container(
                      decoration: BoxDecoration(
                          color: Colors.red[100],
                          borderRadius: BorderRadius.circular(10.0)),
                      child: const Padding(
                        padding: EdgeInsets.all(18.0),
                        child: Text(
                          '%',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    title:
                        //  (widget.percent == 'true')
                        //     ?
                        const Text(
                      'Cshik',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    // :
                    //  const Text(
                    //     'svvs',
                    //     style: TextStyle(
                    //       color: Colors.black,
                    //       fontSize: 20,
                    //       fontWeight: FontWeight.w400,
                    //     ),
                    //   ),
                    trailing:
                        // (widget.percent == 'true')
                        //     ? const Text(
                        //         '28.00%',
                        //         style: TextStyle(
                        //             color: Color.fromARGB(255, 31, 1, 102),
                        //             fontSize: 20),
                        //       )
                        // :
                        const Text(
                      '\u{20B9} ${75.6}',
                      style: TextStyle(
                          color: Color.fromARGB(255, 31, 1, 102), fontSize: 20),
                    )),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 31, 1, 102),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
        onPressed: () {
          showModalBottomSheet<void>(
            backgroundColor: Colors.white,
            scrollControlDisabledMaxHeightRatio: 0.55,
            showDragHandle: true,
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                width: screenSize.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'Add New Discount',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.05,
                          vertical: screenSize.height * 0.03),
                      child: const Text(
                        'Discount Name',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: screenSize.height * 0.03,
                    // ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * 0.05,
                      ),
                      child: TextFormField(
                        // autofocus: true,
                        enabled: true,
                        enableInteractiveSelection: true,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 31, 1, 102),
                        ),
                        decoration: InputDecoration(
                          hintText: 'Discount Name',
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(color: Colors.grey)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 31, 1, 102),
                              )),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(color: Colors.grey)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.03,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.05),
                      child: const Text(
                        'Discount Value',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * 0.05,
                      ),
                      child: TextFormField(
                        // autofocus: true,
                        enabled: true,
                        enableInteractiveSelection: true,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 31, 1, 102),
                        ),

                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: screenSize.height * 0.01,
                              horizontal: screenSize.width * 0.03),
                          hintText: '%',
                          hintStyle: const TextStyle(color: Colors.grey),
                          suffixIcon: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenSize.width * 0.025,
                                      vertical: screenSize.height * 0.012),
                                  decoration: const BoxDecoration(
                                    color: Colors.grey,
                                  ),
                                  // height: screenSize.height,
                                  // width: screenSize.width,
                                  child: const Icon(
                                    Icons.currency_rupee_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenSize.width * 0.025,
                                      vertical: screenSize.height * 0.012),
                                  decoration: const BoxDecoration(
                                    color: Colors.blue,
                                  ),
                                  // height: screenSize.height,
                                  // width: screenSize.width,
                                  child: const Icon(
                                    Icons.percent,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(color: Colors.grey)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 31, 1, 102),
                              )),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(color: Colors.grey)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.05,
                    ),
                    Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenSize.width * 0.4,
                            vertical: screenSize.height * 0.016),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 31, 1, 102),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: const Text(
                          'SAVE',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 50,
        ),
      ),
    );
  }
}

class SearchBarDelegate extends SearchDelegate {
  final TextEditingController searchController;

  SearchBarDelegate() : searchController = TextEditingController();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(
          Icons.clear,
          color: Colors.white,
        ),
        onPressed: () {
          searchController.clear();

          query = 'Search';
        },
      ),
    ];
  }

// actionsIconTheme: theme.actionIconTheme.copyWith()
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return theme.copyWith(
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
      primaryColor: Colors.white,
      appBarTheme: theme.appBarTheme.copyWith(
          color: Colors.blue,
          elevation: 5,
          titleTextStyle: const TextStyle(color: Colors.white)),
      textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.white, selectionColor: Colors.white),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
      ),
      // textTheme: theme.textTheme
      //     .copyWith(bodyLarge: const TextStyle(color: Colors.white)
      // )
    );
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.white,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
