// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:shop_app/models/address.dart';

import '../models/account.dart';

class Customer {
  int? id;
  String? name;
  String? phoneNumber;
  Address? address;
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
      'name': name,
      'phoneNumber': phoneNumber,
      'address': address?.toMap(),
      'gender': gender,
      'account': account?.toMap(),
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'] != 0 ? map['id'] : 0,
      name: map['name'] != null ? map['name'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      address: map['address'] != null
          ? Address.fromMap(map['address'] as Map<String, dynamic>)
          : null,
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
