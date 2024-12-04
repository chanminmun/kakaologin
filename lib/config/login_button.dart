import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String imagePath;
  final VoidCallback onPressed;

  const LoginButton({
    Key? key,
    required this.imagePath,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Image.asset(
        imagePath,
        width: 200,
        height: 50,
      ),
    );
  }
}
