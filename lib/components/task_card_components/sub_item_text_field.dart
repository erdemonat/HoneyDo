import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';

class SubItemTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSubmitted;
  final String hintext;

  const SubItemTextField({
    super.key,
    required this.controller,
    required this.onSubmitted,
    required this.hintext,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Stack(
        children: [
          TextField(
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
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 16.0,
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 0,
            child: Dash(
              dashBorderRadius: 5,
              dashThickness: 5,
              dashLength: 5,
              dashGap: 5,
              direction: Axis.horizontal,
              length: 75,
              dashColor: Theme.of(context).colorScheme.tertiary.withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }
}
