import 'package:flutter/material.dart';

import '../models/account.dart';

class Store with ChangeNotifier {
  final String? id;
  final String? name;
  final String? phoneNumber;
  final String? address;
  final Account? account;

  Store({this.id, this.name, this.phoneNumber, this.address, this.account});
}
