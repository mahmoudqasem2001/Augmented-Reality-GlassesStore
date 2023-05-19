import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class Brand {
  int? id;
  String? name;
  String? countryOfOrigin;
  Brand({
    this.id,
    this.name,
    this.countryOfOrigin,
  });


  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'countryOfOrigin': countryOfOrigin,
    };
  }

  factory Brand.fromMap(Map<String, dynamic> map) {
    return Brand(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      countryOfOrigin: map['countryOfOrigin'] != null ? map['countryOfOrigin'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Brand.fromJson(String source) => Brand.fromMap(json.decode(source) as Map<String, dynamic>);
}
