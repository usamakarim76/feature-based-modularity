import 'package:clean_architecture/core/constants/app_colors.dart';
import 'package:clean_architecture/core/extensions/responsive_extensions.dart';
import 'package:clean_architecture/core/extensions/textstyle_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onTap;
  final VoidCallback? suffixOnTap;
  final IconData? suffixIcon;

  const CustomAppBarWidget({
    super.key,
    required this.title,
    this.onTap,
    this.suffixOnTap,
    this.suffixIcon,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed:
                  onTap ??
                  () {
                    context.pop();
                  },
              icon: Icon(Icons.arrow_back_ios_new_rounded, size: 22),
            ),
            20.wt,
            Text(
              title,
              style: context.titleMedium?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 20.sp,
              ),
            ),
          ],
        ),
        if (suffixIcon != null)
          IconButton(
            onPressed: suffixOnTap,
            icon: Icon(suffixIcon, size: 36, color: AppColors.black),
          ),
      ],
    );
  }
}
