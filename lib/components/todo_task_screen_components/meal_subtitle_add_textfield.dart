import 'package:flutter/material.dart';

class MealSubTitleAddTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSubmitted;
  final String hintext;

  const MealSubTitleAddTextField({
    super.key,
    required this.controller,
    required this.onSubmitted,
    required this.hintext,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
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
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.tertiary.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 16.0,
          ),
        ),
      ),
    );
  }
}
