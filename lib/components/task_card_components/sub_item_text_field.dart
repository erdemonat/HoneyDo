import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';

class SubItemTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSubmitted;
  final FocusNode? focusNode;
  final String hintext;
  final double paddingHorizontal;
  final double dotLenght;

  const SubItemTextField({
    super.key,
    required this.controller,
    required this.onSubmitted,
    required this.hintext,
    required this.paddingHorizontal,
    required this.dotLenght,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: paddingHorizontal),
      child: Stack(
        children: [
          TextField(
            focusNode: focusNode,
            autofocus: true,
            controller: controller,
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                onSubmitted(value);
              }
            },
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.add,
                size: 18,
              ),
              hintText: hintext,
              hintStyle: TextStyle(
                color: Theme.of(context).colorScheme.tertiary.withOpacity(0.6),
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
              dashThickness: 3,
              dashLength: 3,
              dashGap: 4,
              direction: Axis.horizontal,
              length: dotLenght,
              dashColor: Theme.of(context).colorScheme.tertiary.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}
