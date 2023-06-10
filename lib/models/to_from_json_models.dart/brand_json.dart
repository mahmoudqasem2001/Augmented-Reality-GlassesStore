class BrandJson {
  final int id;
  final String name;
  final String countryOfOrigin;

  BrandJson({
    required this.id,
    required this.name,
    required this.countryOfOrigin,
  });

  factory BrandJson.fromJson(Map<String, dynamic> json) {
    return BrandJson(
      id: json['id'],
      name: json['name'],
      countryOfOrigin: json['countryOfOrigin'],
    );
  }
}
