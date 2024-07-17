// import 'dart:async';

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// part 'internet_state.dart';

// class InternetCubit extends Cubit<InternetStatus> {
//   InternetCubit() : super(const InternetStatus(ConnectivityStatus.disconnected));

//   void checkConnectivity() async {
//     var connectivityResult = await Connectivity().checkConnectivity();
//     _updateConnectivityStatus(connectivityResult[0]);
//   }

//   void _updateConnectivityStatus(ConnectivityResult result) {
//     if (result == ConnectivityResult.none) {
//       emit(const InternetStatus(ConnectivityStatus.disconnected));
//     } else {
//       emit(const InternetStatus(ConnectivityStatus.connected));
//     }
//   }

//   late StreamSubscription<List<ConnectivityResult>> _subscription;

//   void trackConnectivityChange() {
//     _subscription = Connectivity().onConnectivityChanged.listen((result) {
//       _updateConnectivityStatus(result[0]);
//     });
//   }

//   void dispose() {
//     _subscription.cancel();
//   }
// }
