import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.title,
    required this.onPressed,
  });
  final String title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)),
            backgroundColor: Colors.green[200],
            foregroundColor: Colors.black,
          textStyle: Theme.of(context).textTheme.bodyLarge
        ),
        child: const Text('Sign In')
    );

  }
}
