import 'package:flutter_config/flutter_config.dart';

class Connection {
  static final baseUrl = "http://" + FlutterConfig.get('IP') + ":8000";
}
