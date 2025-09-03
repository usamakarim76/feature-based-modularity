import 'package:clean_architecture/core/constants/app_colors.dart';
import 'package:clean_architecture/core/extensions/textstyle_extension.dart';
import 'package:flutter/material.dart';

class TextButtonWidget extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  final TextStyle? textTheme;
  final Color? color;
  const TextButtonWidget({
    super.key,
    required this.title,
    required this.onPress,
    this.textTheme,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPress,
      child: Text(
        title,
        style:
            textTheme ??
            context.titleMedium?.copyWith(color: color ?? AppColors.black),
      ),
    );
  }
}
