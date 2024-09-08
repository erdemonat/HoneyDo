import 'package:flutter/material.dart';

class HoneydoBanner extends StatelessWidget {
  const HoneydoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Center(
          child: Padding(
            padding: EdgeInsets.only(left: 15),
            child: Icon(
              Icons.donut_small_sharp,
              size: 18,
            ),
          ),
        ),
        const SizedBox(width: 6),
        Center(
          child: RichText(
            text: const TextSpan(
              text: 'Honey',
              style: TextStyle(fontWeight: FontWeight.w400),
              children: <TextSpan>[
                TextSpan(
                  text: 'Do',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
