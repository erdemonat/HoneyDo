import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DigitTextField extends StatelessWidget {
  final String labelText;
  final int userInput;
  final ValueChanged<String> onChanged;

  const DigitTextField({
    super.key,
    required this.labelText,
    required this.userInput,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller =
        TextEditingController(text: userInput.toString());

    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            counterText: '',
            labelText: labelText,
          ),
          maxLength: 3,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ],
          onChanged: onChanged,
        ),
      ),
    );
  }
}
