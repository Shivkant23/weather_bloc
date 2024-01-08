class Location {
  const Location({
    this.id,
    this.name,
    required this.latitude,
    required this.longitude,
  });

  final int? id;
  final String? name;
  final double latitude;
  final double longitude;
}
