// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:utils/logging.dart';
//
// import 'login_view.dart';
//
// class LandingPage extends StatelessWidget {
//   static final log = logger(LandingPage);
//   const LandingPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         log.d('Connection State: ${snapshot.connectionState}');
//         if (snapshot.connectionState == ConnectionState.active) {
//           log.d('User: ${snapshot.data}');
//           User? user = snapshot.data;
//           if (user == null) {
//             log.d('User needs to login');
//             return MaterialApp(
//               home: LoginView(),
//             );
//           }
//           return LoginView();
//           // return const WixAdminApp();
//         } else {
//           log.d('Waiting for login or logout event');
//           return const MaterialApp(
//             home: Scaffold(
//               body: Center(
//                 child: CircularProgressIndicator(),
//               ),
//             ),
//           );
//         }
//       },
//     );
//   }
// }
