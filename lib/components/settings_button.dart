import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  final void Function()? onTap;
  const SettingsButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 46,
        height: 29,
        color: Colors.transparent,
        margin: const EdgeInsets.only(left: 10),
        //padding: EdgeInsets.all(10),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Icon(
            Icons.settings,
            size: 18,
            color: Colors.grey.shade300,
          ),
        ),
      ),
    );
  }
}
