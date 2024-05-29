// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class BillPlansScreen extends StatefulWidget {
   late Map<String, dynamic> argus;
  BillPlansScreen({super.key, required this.argus});

  @override
  State<BillPlansScreen> createState() => _BillPlansScreenState();
}

class _BillPlansScreenState extends State<BillPlansScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(
                context,
                '/recurring-transaction');
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: const Text(
          'Plans',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.05,
            vertical: screenSize.height * 0.02),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(255, 203, 202, 202),
                  blurRadius: 6.0,
                  offset: Offset(0.0, 0.1))
            ]),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
                context,
                '/recurring-transaction');
          },
          child: const ListTile(
            title: Text('CustomerNaame'),
            subtitle: Text('Transacction'),
            trailing:
                Icon(Icons.arrow_forward_ios, color: Colors.black, size: 15),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 31, 1, 102),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
        onPressed: () {
          Navigator.pushNamed(
              context,
              '/recurring-new-bill-plan');
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
