import 'package:flutter/material.dart';

class TitledContainer extends StatelessWidget {
  final String titleText;
  final double idden;
  final Widget child;
  const TitledContainer({required this.titleText, required this.child, this.idden = 10, super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.bodyMedium!;

    final double calculatedWidth = _calculateTextWidth(titleText, textStyle);

    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 12),
          padding: EdgeInsets.all(idden),
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.onSurface),
            borderRadius: BorderRadius.circular(idden * 0.6),
          ),
          child: child,
        ),
        Positioned(
          left: 10,
          right: 10,
          top: 0,
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: calculatedWidth + 16, // Add some padding around the text
              color: Theme.of(context).colorScheme.surface,
              child: Center(
                child: Text(titleText, overflow: TextOverflow.ellipsis),
              ),
            ),
          ),
        ),
      ],
    );
  }

  double _calculateTextWidth(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size.width;
  }
}
