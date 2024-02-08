import 'package:flutter/material.dart';
import 'package:flutter_intermediate_story_app/common/url_strategy.dart';
import 'package:flutter_intermediate_story_app/my_app.dart';
import 'package:flutter_intermediate_story_app/services/flavor_config.dart';

void main() {
  FlavorConfig(
    flavor: FlavorType.paid,
    values: const FlavorValues(titleApp: 'Story App Dicoding Paid'),
  );

  usePathUrlStrategy();
  runApp(const MyApp());
}
