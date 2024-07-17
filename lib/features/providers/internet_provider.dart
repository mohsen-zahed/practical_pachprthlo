import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class InternetProvider extends ChangeNotifier {
  bool isConnected;
  bool showInternetBanner;

  InternetProvider({this.isConnected = false, this.showInternetBanner = true});

  late StreamSubscription<List<ConnectivityResult>> _subscription;

  Future<void> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    await _updateConnectivityStatus(connectivityResult[0]);
    _subscription = Connectivity().onConnectivityChanged.listen((result) async {
      await _updateConnectivityStatus(result[0]);
      notifyListeners();
    });
  }

  Future<void> _updateConnectivityStatus(ConnectivityResult result) async {
    if (result == ConnectivityResult.none) {
      isConnected = false;
      showInternetBanner = true;
    } else {
      isConnected = true;
      _hideInternetBanner();
    }
    notifyListeners();
  }

  _hideInternetBanner() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        showInternetBanner = false;
        notifyListeners();
      },
    );
    showInternetBanner = true;
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
