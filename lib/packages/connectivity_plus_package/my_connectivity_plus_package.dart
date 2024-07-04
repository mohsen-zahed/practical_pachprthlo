import 'package:connectivity_plus/connectivity_plus.dart';

class MyConnectivityPlusPackage {
  static MyConnectivityPlusPackage? _instance;
  MyConnectivityPlusPackage._();
  static MyConnectivityPlusPackage get instance {
    _instance ??= MyConnectivityPlusPackage._();
    return _instance!;
  }

  Future<bool> checkInternetConnection() async {
    try {
      final List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();
      print('net res: $connectivityResult');
      if (connectivityResult[0] == ConnectivityResult.mobile ||
          connectivityResult[0] == ConnectivityResult.wifi ||
          connectivityResult[0] == ConnectivityResult.vpn) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
