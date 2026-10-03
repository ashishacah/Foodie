import 'package:flutter/material.dart';

class FieldDesign extends StatelessWidget {
  final TextEditingController conname;
  final String hint;

  const FieldDesign({super.key, required this.conname, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 200,
        child: TextField(
          controller: conname,
          obscureText: hint.toLowerCase() == 'password',
 
          decoration: InputDecoration(
            hint: Text(hint),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
    );
  }
}
