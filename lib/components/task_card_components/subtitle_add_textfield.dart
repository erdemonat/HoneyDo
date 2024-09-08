import 'package:flutter/material.dart';

class SubTitleAddTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSubmitted;
  final String hintext;

  const SubTitleAddTextField({
    super.key,
    required this.controller,
    required this.onSubmitted,
    required this.hintext,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      side: BorderSide(
        color: Theme.of(context).colorScheme.tertiary.withOpacity(0.3),
        width: 1.5,
        strokeAlign: 1.5,
      ),
      controlAffinity: ListTileControlAffinity.leading,
      value: false,
      onChanged: (value) {},
      title: TextField(
        controller: controller,
        onSubmitted: (value) {
          if (value.isNotEmpty) {
            onSubmitted(value);
          }
        },
        decoration: InputDecoration(
          hintText: hintext,
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.tertiary.withOpacity(0.3),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
