// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import '../models/account.dart';

class Customer {
  String? id;
  String? name;
  String? phoneNumber;
  String? address;
  String? gender;
  Account? account;

  Customer(
      {this.id,
      this.name,
      this.phoneNumber,
      this.address,
      this.gender,
      this.account});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'address': address,
      'gender': gender,
      'account': account?.toMap(),
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'] as String,
      name: map['name'] != null ? map['name'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      account: map['account'] != null
          ? Account.fromMap(map['account'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Customer.fromJson(String source) =>
      Customer.fromMap(json.decode(source) as Map<String, dynamic>);
}
