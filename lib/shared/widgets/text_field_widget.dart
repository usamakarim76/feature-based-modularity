import 'package:clean_architecture/core/constants/app_colors.dart';
import 'package:clean_architecture/core/extensions/responsive_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFieldWidget extends StatelessWidget {
  const CustomTextFieldWidget({
    super.key,
    this.width,
    this.height,
    required this.controller,
    this.node,
    required this.title,
    this.textInputType,
    this.obscureText = false,
    this.sufffixOnTap,
    this.suffixIcon,
    this.onSubmitted,
    this.validator,
    this.maxLength,
    this.backgroundColor,
    this.borderColor,
    this.iconColor,
    this.textColor,
    this.isDescription = false,
    this.onChanged,
    this.isValidate = true,
    this.borderRadius,
    this.isOnlyNumber,
  });

  final double? width;
  final double? height;
  final TextEditingController controller;
  final FocusNode? node;
  final String title;
  final TextInputType? textInputType;
  final bool? obscureText;
  final VoidCallback? sufffixOnTap;
  final IconData? suffixIcon;
  final Function(String)? onSubmitted;
  final String? Function(String?)? validator;
  final int? maxLength;
  final Color? backgroundColor, borderColor, iconColor, textColor;
  final bool isDescription;
  final Function(String)? onChanged;
  final bool? isValidate;
  final double? borderRadius;
  final bool? isOnlyNumber;

  String? defaultValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Required';
    }
    if (title.toLowerCase().contains('email')) {
      if (!RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
      ).hasMatch(value)) {
        return 'Enter a valid email address';
      }
    } else if (title.toLowerCase().contains('password')) {
      if (value.length < 6) {
        return 'Password must be at least 6 characters long';
      }
    }
    return null;
  }

  String capitalizeFirst(String text) {
    if (text.isEmpty) return text;
    if (text.toLowerCase().contains('password') ||
        text.toLowerCase().contains('email')) {
      return text;
    }
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.transparent,
        borderRadius: BorderRadius.circular(borderRadius ?? 10),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: Offset(0, 10),
          ),
        ],
      ),
      height: height ?? (isDescription ? 210.h : null),
      width: width ?? context.sw,
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType ?? TextInputType.text,
        focusNode: node,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          // decorationThickness: 0,
          color: textColor ?? AppColors.black,
        ),
        validator: isValidate! ? validator ?? defaultValidator : null,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: obscureText ?? false,
        cursorColor: textColor ?? AppColors.black,
        maxLines: isDescription ? null : 1,
        minLines: isDescription ? 15 : 1,
        inputFormatters: [
          if (isOnlyNumber == true) FilteringTextInputFormatter.digitsOnly,
          if (maxLength != null) LengthLimitingTextInputFormatter(maxLength),
        ],
        decoration: InputDecoration(
          hintText: title,
          alignLabelWithHint: true,
          fillColor: backgroundColor ?? AppColors.white,
          filled: true,

          contentPadding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            top: 20.h,
            bottom: 20.h,
          ),
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 10),
            borderSide: BorderSide(
              color:
                  borderColor ?? AppColors.surfaceLight.withValues(alpha: 0.2),
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: borderColor ?? AppColors.primary,
              width: 1.0,
            ),
          ),
          // Border when there's an error
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.error),
          ),

          // Border when focused and there's an error
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.error, width: 1.0),
          ),
          isDense: true,
          suffixIcon: suffixIcon != null
              ? IconButton(
                  onPressed: sufffixOnTap,
                  icon: Icon(
                    suffixIcon,
                    color: iconColor ?? AppColors.black.withValues(alpha: 0.5),
                    size: 22,
                  ),
                )
              : null,

          hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: 16.sp,
            color: textColor ?? AppColors.black,
          ),
          errorStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: AppColors.error,
            fontSize: 11.sp, // Customize the font size as needed
          ),
        ),
        onTapOutside: (event) {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        onChanged: onChanged,
        onFieldSubmitted:
            onSubmitted ??
            (value) {
              FocusScope.of(context).requestFocus(FocusNode());
            },
      ),
    );
  }
}
