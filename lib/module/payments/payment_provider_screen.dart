// import 'package:flutter/material.dart';
// import 'package:meekhata_workspace/module/payments/payment_configuration_screen.dart';

// class PaymentProviderScreen extends StatefulWidget {
//   const PaymentProviderScreen({super.key});

//   @override
//   State<PaymentProviderScreen> createState() => _PaymentProviderScreenState();
// }

// class _PaymentProviderScreenState extends State<PaymentProviderScreen> {
 
//   Future<bool> showDeletePopup(context) async {
//     // exit from app
//     return await showDialog(
//         // barrierColor: Colors.white,
//         context: context,
//         builder: (BuildContext context) {
//           return PopScope(
//             canPop: false,
//             child: AlertDialog(
//               backgroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10)),
//               content:
//                   const Text('Are you sure want to delete this information?'),
//               actions: [
//                 TextButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: const Text(
//                       'No',
//                       style: TextStyle(
//                           fontSize: 20,
//                           color: Color.fromARGB(255, 0, 31, 103),
//                           fontWeight: FontWeight.w700),
//                     )),
//                 TextButton(
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) =>
//                                   const PaymentProviderScreen()));
//                     },
//                     child: const Text(
//                       'YES',
//                       style: TextStyle(
//                           fontSize: 20,
//                           color: Color.fromARGB(255, 0, 31, 103),
//                           fontWeight: FontWeight.w700),
//                     ))
//               ],
//             ),
//           );
//           // });
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         leading: IconButton(
//           icon: const Icon(
//             Icons.arrow_back,
//             color: Colors.white,
//           ),
//           onPressed: () {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => const PaymentConfigurationScreen()));
//           },
//         ),
//         title: const Text(
//           'Payment Providers',
//           style: TextStyle(color: Colors.white, fontSize: 23),
//         ),
//         actions: [
//           IconButton(
//               onPressed: () {
//                 showDeletePopup(context);
//               },
//               icon: const Icon(
//                 Icons.delete_outline_outlined,
//                 color: Colors.white,
//                 size: 30,
//               ))
//         ],
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(
//             horizontal: screenSize.width * 0.05,
//             vertical: screenSize.height * 0.05),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Enter UPI',
//               style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 17,
//                   fontWeight: FontWeight.w500),
//             ),
//             SizedBox(
//               height: screenSize.height * 0.01,
//             ),
//             TextFormField(
//               cursorColor: const Color.fromARGB(255, 0, 31, 103),
//               style: const TextStyle(color: Color.fromARGB(255, 0, 31, 103)),
//               decoration: InputDecoration(
//                 hintText: 'Enter UPI',
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: const BorderSide(
//                         color: Color.fromARGB(255, 0, 31, 103))),
//                 enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: const BorderSide(
//                         color: Color.fromARGB(255, 0, 31, 103))),
//                 focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: const BorderSide(
//                         color: Color.fromARGB(255, 0, 31, 103))),
//               ),
//             )
//           ],
//         ),
//       ),
//       floatingActionButton: Container(
//         height: screenSize.height * 0.06,
//         margin: EdgeInsets.symmetric(
//           horizontal: screenSize.width * 0.06,
//         ),
//         padding: EdgeInsets.symmetric(
//           vertical: screenSize.height * 0.01,
//         ),
//         decoration: const BoxDecoration(
//             color: Color.fromARGB(255, 0, 31, 103),
//             borderRadius: BorderRadius.all(Radius.circular(10.0))),
//         child: const Center(
//           child: Text(
//             'Save',
//             style: TextStyle(color: Colors.white, fontSize: 20),
//           ),
//         ),
//       ),
//     );
//   }
// }
