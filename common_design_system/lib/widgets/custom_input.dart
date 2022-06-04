import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String label;
  final String hintText;
  final Function(String) onChanged;

  const CustomInput({ 
    Key? key,
    this.label = '',
    this.hintText = '',
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(    
        labelText: label,
        hintText: hintText, 
        contentPadding: const EdgeInsets.all(8),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.pink, width: 2)
        )
      ),
    );
  }
}