import 'package:flutter/material.dart';

class TitledContainer extends StatelessWidget {
  final String titleText;
  final double idden;
  final Widget child;
  final double borderCutWidth;
  const TitledContainer(
      {required this.titleText,
      required this.child,
      this.idden = 10,
      super.key,
      required this.borderCutWidth});

  @override
  Widget build(BuildContext context) {
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
              width: borderCutWidth,
              color: Theme.of(context).colorScheme.surface,
              child: Center(
                  child: Text(titleText, overflow: TextOverflow.ellipsis)),
            ),
          ),
        ),
      ],
    );
  }
}
