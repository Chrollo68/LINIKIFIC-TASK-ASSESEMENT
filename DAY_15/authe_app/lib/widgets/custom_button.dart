import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;

  final VoidCallback onPressed;

  final bool isLoading;

  final double width;

  final double height;

  final Color color;

  const CustomButton({
    super.key,

    required this.text,

    required this.onPressed,

    this.isLoading = false,

    this.width = double.infinity,

    this.height = 50,

    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,

      height: height,

      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),

        onPressed: isLoading ? null : onPressed,

        child: isLoading
            ? const SizedBox(
                height: 22,

                width: 22,

                child: CircularProgressIndicator(
                  strokeWidth: 2,

                  color: Colors.white,
                ),
              )
            : Text(
                text,

                style: const TextStyle(
                  fontSize: 16,

                  fontWeight: FontWeight.bold,

                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
