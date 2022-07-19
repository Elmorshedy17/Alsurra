import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final String label, hint;
  const InputText({Key? key, required this.label, required this.hint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 25.0),
      child: TextFormField(
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey[200]!, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey[200]!, width: 2),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey[200]!, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey[200]!, width: 2),
          ),
          label: Text(
            label,
            style: const TextStyle(
              color: Colors.black87,
              height: 1.3,
            ),
          ),
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.grey,
            height: 1.3,
          ),
        ),
      ),
    );
  }
}
