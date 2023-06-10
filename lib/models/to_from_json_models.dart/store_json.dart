class StoreJson {
  final int id;
  final String name;
  final String phoneNumber;

  StoreJson({
    required this.id,
    required this.name,
    required this.phoneNumber,
  });

  factory StoreJson.fromJson(Map<String, dynamic> json) {
    return StoreJson(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
    );
  }
}
