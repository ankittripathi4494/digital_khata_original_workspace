import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PaytmMerchantScreen extends StatefulWidget {
  const PaytmMerchantScreen({super.key});

  @override
  State<PaytmMerchantScreen> createState() => _PaytmMerchantScreenState();
}

class _PaytmMerchantScreenState extends State<PaytmMerchantScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/payment-configuration',
                  arguments: {
                    "isNetbanking": '',
                    "isDeleted": 'true',
                  });
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: const Text(
          'Payment Providers',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                var meekahataUrl = "https://www.meekhata.in/";

                var url = Uri.parse(meekahataUrl);

                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
              icon: const Icon(
                Icons.help_outline_sharp,
                color: Colors.white,
              ))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.05,
            vertical: screenSize.height * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Merchant Id',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: screenSize.height * 0.01,
            ),
            TextFormField(
              keyboardType: TextInputType.name,
              cursorColor: const Color.fromARGB(255, 0, 31, 103),
              style: const TextStyle(color: Color.fromARGB(255, 0, 31, 103)),
              decoration: InputDecoration(
                  hintText: 'Merchant Id',
                  hintStyle: const TextStyle(fontSize: 13),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 0, 31, 103)),
                      borderRadius: BorderRadius.circular(10.0)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 0, 31, 103)),
                      borderRadius: BorderRadius.circular(10.0)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 0, 31, 103)),
                      borderRadius: BorderRadius.circular(10.0))),
            ),
            SizedBox(
              height: screenSize.height * 0.05,
            ),
            const Text(
              'Merchant key',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: screenSize.height * 0.01,
            ),
            TextFormField(
              keyboardType: TextInputType.name,
              cursorColor: const Color.fromARGB(255, 0, 31, 103),
              style: const TextStyle(color: Color.fromARGB(255, 0, 31, 103)),
              decoration: InputDecoration(
                  hintText: 'Merchant Key',
                  hintStyle: const TextStyle(fontSize: 13),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 0, 31, 103)),
                      borderRadius: BorderRadius.circular(10.0)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 0, 31, 103)),
                      borderRadius: BorderRadius.circular(10.0)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 0, 31, 103)),
                      borderRadius: BorderRadius.circular(10.0))),
            ),
            SizedBox(
              height: screenSize.height * 0.05,
            ),
            const Text(
              'Website',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: screenSize.height * 0.01,
            ),
            TextFormField(
              keyboardType: TextInputType.name,
              cursorColor: const Color.fromARGB(255, 0, 31, 103),
              style: const TextStyle(color: Color.fromARGB(255, 0, 31, 103)),
              decoration: InputDecoration(
                  hintText: 'Website',
                  hintStyle: const TextStyle(fontSize: 13),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 0, 31, 103)),
                      borderRadius: BorderRadius.circular(10.0)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 0, 31, 103)),
                      borderRadius: BorderRadius.circular(10.0)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 0, 31, 103)),
                      borderRadius: BorderRadius.circular(10.0))),
            ),
          ],
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              behavior: SnackBarBehavior.floating,
              content: Text(
                "Invalid Details, please check the details and try again!",
                style: TextStyle(color: Colors.white),
              )));
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => PaymentConfigurationScreen(
          //             isDeleted: '', isNetbanking: '')));
        },
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.06,
          ),
          padding: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.4,
              vertical: screenSize.height * 0.02),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 31, 1, 102),
              borderRadius: BorderRadius.circular(10.0)),
          child: const Text(
            'Save',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
      ),
    );
  }
}
