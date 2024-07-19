// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OtherFeaturesScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  OtherFeaturesScreen({
    super.key,
    required this.argus,
  });

  @override
  State<OtherFeaturesScreen> createState() => _OtherFeaturesScreenState();
}

class _OtherFeaturesScreenState extends State<OtherFeaturesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Other Features',
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.grey[100]),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                      colors: [Colors.white, Colors.white])),
              child: ListTile(
                leading: const Icon(
                  FontAwesomeIcons.commentSms,
                  color: Color.fromARGB(255, 31, 1, 102),
                ),
                title: const Text(
                  "Bulk SMS Marketing",
                  style: TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 31, 1, 102),
                      fontWeight: FontWeight.w700),
                ),
                subtitle: const Text(
                  "Create your Promotions and publish to the groups",
                  style: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 31, 1, 102),
                      fontWeight: FontWeight.w400),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  weight: 20.0,
                  color: Color.fromARGB(255, 31, 1, 102),
                ),
                onTap: () {},
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                      colors: [Colors.white, Colors.white])),
              child: ListTile(
                leading: const Icon(
                  FontAwesomeIcons.fileInvoice,
                  color: Color.fromARGB(255, 31, 1, 102),
                ),
                title: const Text(
                  "Custom Field",
                  style: TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 31, 1, 102),
                      fontWeight: FontWeight.w700),
                ),
                subtitle: const Text(
                  "Add your own field against customer details. For example Loan Number, etc",
                  style: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 31, 1, 102),
                      fontWeight: FontWeight.w400),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  weight: 20.0,
                  color: Color.fromARGB(255, 31, 1, 102),
                ),
                onTap: () {},
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                      colors: [Colors.white, Colors.white])),
              child: ListTile(
                leading: const Icon(
                  FontAwesomeIcons.tags,
                  color: Color.fromARGB(255, 31, 1, 102),
                ),
                title: const Text(
                  "Label/Tags",
                  style: TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 31, 1, 102),
                      fontWeight: FontWeight.w700),
                ),
                subtitle: const Text(
                  "Use labels to organise your customers or khatas. Click on edit custom to label it",
                  style: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 31, 1, 102),
                      fontWeight: FontWeight.w400),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  weight: 20.0,
                  color: Color.fromARGB(255, 31, 1, 102),
                ),
                onTap: () {},
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                      colors: [Colors.white, Colors.white])),
              child: ListTile(
                leading: const Icon(
                  FontAwesomeIcons.mobileScreen,
                  color: Color.fromARGB(255, 31, 1, 102),
                ),
                title: const Text(
                  "Customize Home Card",
                  style: TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 31, 1, 102),
                      fontWeight: FontWeight.w700),
                ),
                subtitle: const Text(
                  "Arrange the order of optional fields to display in home screen customer card",
                  style: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 31, 1, 102),
                      fontWeight: FontWeight.w400),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  weight: 20.0,
                  color: Color.fromARGB(255, 31, 1, 102),
                ),
                onTap: () {},
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                      colors: [Colors.white, Colors.white])),
              child: ListTile(
                leading: const Icon(
                  FontAwesomeIcons.squareWhatsapp,
                  color: Color.fromARGB(255, 31, 1, 102),
                ),
                title: const Text(
                  "Edit Manual Whatsapp Template",
                  style: TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 31, 1, 102),
                      fontWeight: FontWeight.w700),
                ),
                subtitle: const Text(
                  "Connect with out support team for SMS customization and more details",
                  style: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 31, 1, 102),
                      fontWeight: FontWeight.w400),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  weight: 20.0,
                  color: Color.fromARGB(255, 31, 1, 102),
                ),
                onTap: () {},
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                      colors: [Colors.white, Colors.white])),
              child: ListTile(
                leading: const Icon(
                  FontAwesomeIcons.personMilitaryToPerson,
                  color: Color.fromARGB(255, 31, 1, 102),
                ),
                title: const Text(
                  "What do you call your customer",
                  style: TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 31, 1, 102),
                      fontWeight: FontWeight.w700),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  weight: 20.0,
                  color: Color.fromARGB(255, 31, 1, 102),
                ),
                onTap: () {},
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                      colors: [Colors.white, Colors.white])),
              child: ListTile(
                leading: const Icon(
                  FontAwesomeIcons.idCard,
                  color: Color.fromARGB(255, 31, 1, 102),
                ),
                title: const Text(
                  "Business Card",
                  style: TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 31, 1, 102),
                      fontWeight: FontWeight.w700),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  weight: 20.0,
                  color: Color.fromARGB(255, 31, 1, 102),
                ),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
