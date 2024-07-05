// import 'package:flutter/material.dart';
// import 'package:infra/helper/helpers.dart';
// import 'package:infra/main.dart';
// import 'package:provider/provider.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:infra/services/auth_service.dart';

// class VerificationScreen extends StatefulWidget {
//   @override
//   _VerificationScreenState createState() => _VerificationScreenState();
// }

// class _VerificationScreenState extends State<VerificationScreen> {
//   final TextEditingController codeController = TextEditingController();

//   void verifyCode(BuildContext context) async {
//     // Show loader
//     showDialog(
//         context: context,
//         builder: (context) => const Center(
//               child: CircularProgressIndicator(),
//             ));

//     try {
//       await Provider.of<AuthService>(context, listen: false)
//           .verifyCode(codeController.text);
//       Navigator.pop(context);
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (context) => HomeScreen()));
//     } on FirebaseAuthException catch (e) {
//       Navigator.pop(context);
//       displayMessageToUser(e.code, context);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Enter Verification Code'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Enter the code sent to your phone',
//               style: TextStyle(fontSize: 20),
//             ),
//             TextField(
//               controller: codeController,
//               decoration: InputDecoration(labelText: 'Verification Code'),
//             ),
//             SizedBox(height: 20),
//             Center(
//               child: ElevatedButton(
//                 onPressed: () {
//                   verifyCode(context);
//                 },
//                 child: Text('Verify'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
