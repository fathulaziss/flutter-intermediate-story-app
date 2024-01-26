import 'dart:async';

import 'package:flutter/material.dart';

class PageProvider extends ChangeNotifier {
  late Completer<String> _completer;

  Future<String> waitForResult() async {
    _completer = Completer<String>();
    return _completer.future;
  }

  void returnData(String value) {
    _completer.complete(value);
  }
}
