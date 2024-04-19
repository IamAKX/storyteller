import 'package:flutter/material.dart';

class ButtonProgressIndicator extends StatelessWidget {
  const ButtonProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 20,
      height: 20,
      child: const CircularProgressIndicator(
        color: Colors.white,
        strokeWidth: 1,
      ),
    );
  }
}
