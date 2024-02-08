// ignore_for_file: prefer_constructors_over_static_methods

enum FlavorType { free, paid }

class FlavorValues {
  const FlavorValues({this.titleApp = 'Story App Dicoding Free'});

  final String titleApp;
}

class FlavorConfig {
  FlavorConfig({
    this.flavor = FlavorType.free,
    this.values = const FlavorValues(),
  }) {
    _instance = this;
  }

  static FlavorConfig? _instance;
  final FlavorType flavor;
  final FlavorValues values;

  static FlavorConfig get instance => _instance ?? FlavorConfig();
}
