import 'package:flutter/material.dart';

class Fields extends StatelessWidget {
  final TextEditingController FieldsController;
  final String label;
  final String value;
  
  const Fields({
    super.key,
    required this.FieldsController,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: FieldsController, // Menghubungkan controller
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.email,
          size: 20,
        ),
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.black,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color:  Colors.grey,
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color:  Colors.grey,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}

