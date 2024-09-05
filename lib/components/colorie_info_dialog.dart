import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ColorieInfoDialog extends StatefulWidget {
  const ColorieInfoDialog({super.key});

  @override
  _ColorieInfoDialogState createState() => _ColorieInfoDialogState();
}

class _ColorieInfoDialogState extends State<ColorieInfoDialog> {
  String apiKey = "";
  String generatedText = "Loading...";

  @override
  void initState() {
    super.initState();
  }

  Future<void> _generateContent() async {
    final model = GenerativeModel(model: "gemini-1.5-pro", apiKey: apiKey);
    final prompt = 'Herhangi bir promt';
    print(prompt);
    final response = await model.generateContent([
      Content.text(prompt),
    ]);

    print(response.text.toString());

    setState(() {
      generatedText = response.text.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [Text(generatedText)],
    );
  }
}
