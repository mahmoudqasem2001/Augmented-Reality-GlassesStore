import 'package:flutter/material.dart';

class FormError extends StatelessWidget {
  const FormError({Key? key, required this.errors}) : super(key: key);
  final List<String?> errors;
  @override
  Widget build(BuildContext context) {
    return Column(
        children: List.generate(
            errors.length, (index) => formErrorText(error: errors[index])));
  }

  Widget formErrorText({String? error}) {
    return Row(
      children: [
        Icon(Icons.error_outline_rounded , color: Colors.red[400],), 
        const SizedBox(width: 10,), 
        Text(error!),
      ],
    );
  }
}