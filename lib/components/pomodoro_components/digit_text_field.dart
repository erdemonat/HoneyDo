import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DigitTextField extends StatelessWidget {
  final String labelText;
  final int userInput;
  final ValueChanged<String> onChanged;
  final int maxValue;

  const DigitTextField({
    super.key,
    required this.labelText,
    required this.userInput,
    required this.onChanged,
    required this.maxValue,
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
              hoverColor: Theme.of(context).colorScheme.secondary,
              focusColor: Theme.of(context).colorScheme.tertiary,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: Theme.of(context)
                        .colorScheme
                        .secondary), // Normal border rengi
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.tertiary,
                    width: 2), // Tıklandığında border rengi
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.secondary,
                    width: 1), // Enabled border rengi
              ),
              labelText: labelText,
              counterText: '',
              floatingLabelStyle:
                  TextStyle(color: Theme.of(context).colorScheme.tertiary)),
          maxLength: 3,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
            _NumberRangeFormatter(min: 1, max: maxValue)
          ],
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _NumberRangeFormatter extends TextInputFormatter {
  final int min;
  final int max;

  _NumberRangeFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Giriş bir sayı mı kontrol et
    final int? value = int.tryParse(newValue.text);
    if (value == null) {
      return oldValue;
    }

    // Giriş 1 ile 12 arasında mı kontrol et
    if (value < min || value > max) {
      return oldValue;
    }

    return newValue;
  }
}
