import 'package:internet_connection_checker/internet_connection_checker.dart';

Future<bool> internetConnection() async {
  bool internetConnection = await InternetConnectionChecker().hasConnection;
  if (internetConnection != true) {
    return false;
  } else {
    return true;
  }
}
