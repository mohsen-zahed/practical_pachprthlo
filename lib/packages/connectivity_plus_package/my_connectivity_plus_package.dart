// import 'dart:async';

// import 'package:connectivity_plus/connectivity_plus.dart';

// class MyConnectivityPlusPackage {
//   static MyConnectivityPlusPackage? _instance;
//   MyConnectivityPlusPackage._();
//   static MyConnectivityPlusPackage get instance {
//     _instance ??= MyConnectivityPlusPackage._();
//     return _instance!;
//   }

//   Future<bool> checkInternetConnection() async {
//     try {
//       final List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();
//       return _updateConnectivityStatus(connectivityResult[0]);
//     } catch (e) {
//       return false;
//     }
//   }

//   bool _updateConnectivityStatus(ConnectivityResult result) {
//     if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi || result == ConnectivityResult.vpn) {
//       trackConnectivityChanges();
//       return true;
//     } else {
//       return false;
//     }
//   }

//   // ignore: unused_field
//   late StreamSubscription<List<ConnectivityResult?>> _subscription;

//   void trackConnectivityChanges() {
//     _subscription = Connectivity().onConnectivityChanged.listen((event) {
//       _updateConnectivityStatus(event[0]);
//     });
//   }
// }
