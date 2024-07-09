import 'package:flutter/material.dart';
import 'package:practical_pachprthlo/config/constants/colors.dart';

class CustomTryAgainButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;

  const CustomTryAgainButton({
    super.key,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: Text(
        buttonText,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kWhiteColor),
      ),
    );
  }
}
