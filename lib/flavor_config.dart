enum FlavorType {
  free,
  paid,
}

class FlavorValues {
  final bool uploadWithLocationAvailable;
  final String titleApp;

  const FlavorValues({
    required this.uploadWithLocationAvailable,
    required this.titleApp,
  });
}

class FlavorConfig {
  final FlavorType flavor;
  final FlavorValues values;

  static FlavorConfig? _instance;

  FlavorConfig({
    required this.flavor,
    required this.values,
  }) {
    _instance = this;
  }

  static FlavorConfig get instance =>
      _instance ??
      FlavorConfig(
        flavor: FlavorType.free,
        values: const FlavorValues(
          uploadWithLocationAvailable: false,
          titleApp: 'DailyUs Free',
        ),
      );
}
