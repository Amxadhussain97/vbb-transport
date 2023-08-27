import 'package:flutter/material.dart';

class ErrorMessageWidget extends StatelessWidget {
  final VoidCallback? onPressed;

  const ErrorMessageWidget({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.error_outline,
          color: Colors.red.shade300,
          size: 60,
        ),
        const SizedBox(height: 12),
        const Text("Something went wrong when fetching data"),
        TextButton(
          onPressed: onPressed,
          child: const Text("Try again"),
        ),
      ],
    );
  }
}