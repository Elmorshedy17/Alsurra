import 'package:flutter/material.dart';

enum ObscureText {
  show,
  hide,
}

class InputPassword extends StatelessWidget {
  final String label, hint;
  InputPassword({Key? key, required this.label, required this.hint})
      : super(key: key);

  final ValueNotifier<ObscureText> _obscureNotifier =
      ValueNotifier<ObscureText>(ObscureText.hide);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ObscureText>(
        valueListenable: _obscureNotifier,
        builder: (context, val, _) {
          return Container(
            margin: const EdgeInsets.only(top: 25.0),
            child: TextFormField(
              obscureText: val == ObscureText.hide,
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
                suffixIcon: IconButton(
                  onPressed: () {
                    if (val == ObscureText.hide) {
                      _obscureNotifier.value = ObscureText.show;
                    } else {
                      _obscureNotifier.value = ObscureText.hide;
                    }
                  },
                  icon: Icon(
                    val == ObscureText.hide
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          );
        });
  }
}
