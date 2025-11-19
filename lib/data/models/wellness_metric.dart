class WellnessMetric {
  const WellnessMetric({
    required this.id,
    required this.label,
    required this.value,
    required this.unit,
    required this.trend,
    required this.description,
  });

  final String id;
  final String label;
  final double value;
  final String unit;
  final double trend;
  final String description;
}
