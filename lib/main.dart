import 'package:flutter/material.dart';
import 'package:flutter_intermediate_story_app/common/url_strategy.dart';
import 'package:flutter_intermediate_story_app/my_app.dart';

void main() {
  usePathUrlStrategy();
  runApp(const MyApp());
}
