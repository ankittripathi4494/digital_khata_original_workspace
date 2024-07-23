// ignore_for_file: must_be_immutable, unused_import

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ServiceScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  ServiceScreen({super.key, required this.argus});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/invoice');
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: const Text(
          'Service',
          style: TextStyle(color: Colors.white),
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
      body: Container(
        margin: EdgeInsets.symmetric(
            vertical: screenSize.height * 0.01,
            horizontal: screenSize.width * 0.02),
        padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.01),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                  color: Color.fromARGB(255, 203, 202, 202),
                  blurRadius: 6.0,
                  offset: Offset(0.0, 0.1))
            ],
            borderRadius: BorderRadius.circular(10.0)),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/service-details', arguments: {
              "tax": '',
              "percent": 'false',
              "ruppees": 'false',
            });
          },
          child: ListTile(
            leading: Container(
              // margin: EdgeInsets.symmetric(
              //     vertical: screenSize.height * 0.001,
              //     horizontal: screenSize.width * 0.01),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(10.0)),
              child: const Text(
                'SN',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            title: const Text(
              'Service Name',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: const Text(
              '2 Prices',
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
          backgroundColor: const Color.fromARGB(255, 31, 1, 102),
          onPressed: () {},
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 28,
          )),
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
