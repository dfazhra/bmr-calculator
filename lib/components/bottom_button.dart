
import 'package:flutter/material.dart';
import '../constants.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({
    super.key,
    required this.buttonTitle,
    required this.onTap,
  });

  final String buttonTitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 10.0),
        height: bottomContainerHeight,
        decoration: const BoxDecoration(
          color: bottomContainerColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(14.0)),
        ),
        child: Center(
          child: Text(
            buttonTitle,
            style: buttonTextStyle.copyWith(
              color: const Color(0xFF0B0D23),
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
