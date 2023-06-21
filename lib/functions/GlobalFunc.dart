import 'package:flutter/services.dart';

void closeApp() {
  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
}
