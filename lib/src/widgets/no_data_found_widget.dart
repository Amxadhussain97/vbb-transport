import 'package:flutter/material.dart';

class NoDataFoundWidget extends StatelessWidget {
  final String text;

  const NoDataFoundWidget({
    Key? key,
    required this.text,
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
        Text(
          text,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}