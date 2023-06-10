// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Address {
  int? id;
  String? country;
  String? city;
  String? street;
  String? zip;

  Address({this.id,this.country, this.city, this.street, this.zip});

  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'country': country,
      'city': city,
      'street': street,
      'zip': zip,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      id: map['id'] != null ? map['id'] as int : null,
      country: map['country'] != null ? map['country'] as String : null,
      city: map['city'] != null ? map['city'] as String : null,
      street: map['street'] != null ? map['street'] as String : null,
      zip: map['zip'] != null ? map['zip'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) => Address.fromMap(json.decode(source) as Map<String, dynamic>);
}
