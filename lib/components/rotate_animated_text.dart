import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class CustomRotateAnimatedText extends AnimatedText {
  final double? transitionHeight;
  final AlignmentGeometry alignment;
  final TextDirection textDirection;

  CustomRotateAnimatedText(
    String text, {
    TextAlign textAlign = TextAlign.start,
    TextStyle? textStyle,
    Duration duration = const Duration(milliseconds: 10000), // Toplam animasyon süresi
    this.transitionHeight,
    this.alignment = Alignment.center,
    this.textDirection = TextDirection.ltr,
  }) : super(
          text: text,
          textAlign: textAlign,
          textStyle: textStyle,
          duration: duration,
        );

  late Animation<double> _fadeIn, _fadeOut;
  late Animation<Alignment> _slideIn, _slideOut;

  @override
  void initAnimation(AnimationController controller) {
    _fadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.1, curve: Curves.easeOut), // İlk 1 saniyede fade in
      ),
    );

    _slideIn = AlignmentTween(
      begin: Alignment.topCenter,
      end: Alignment.center,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.1, curve: Curves.easeOut), // İlk 1 saniyede yukarıdan ortaya
      ),
    );

    _fadeOut = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.8, 0.9, curve: Curves.easeIn), // Son 1 saniyede fade out
      ),
    );

    _slideOut = AlignmentTween(
      begin: Alignment.center,
      end: Alignment.bottomCenter,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.8, 0.9, curve: Curves.easeIn), // Son 1 saniyede aşağıya kayma
      ),
    );
  }

  @override
  Widget animatedBuilder(BuildContext context, Widget? child) {
    return Opacity(
      opacity: _fadeIn.value != 1.0 ? _fadeIn.value : _fadeOut.value,
      child: AlignTransition(
        alignment: _slideIn.value.y != 0.0 ? _slideIn : _slideOut,
        child: textWidget(text),
      ),
    );
  }
}
