import 'package:clean_architecture/core/constants/app_colors.dart';
import 'package:clean_architecture/core/extensions/responsive_extensions.dart';
import 'package:clean_architecture/core/extensions/textstyle_extension.dart';
import 'package:flutter/material.dart';

class CustomDropDownWidget<T> extends StatelessWidget {
  const CustomDropDownWidget({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.displayItem,
    required this.hint,
    this.isLoading = false,
    this.emptyText,
    this.dropDownColor,
    this.textColor,
    this.borderColor,
    this.iconColor,
    this.backgroundColor,
  });

  /// The currently selected value
  final T? value;

  /// The list of items to display
  final List<T> items;

  /// Callback when an item is selected
  final ValueChanged<T?> onChanged;

  /// A function to extract the display value from a model
  final String Function(T item) displayItem;

  // Hint text
  final String hint;

  // For loading
  final bool? isLoading;

  // if empty show text
  final String? emptyText;
  final Color? dropDownColor,
      textColor,
      borderColor,
      iconColor,
      backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.sw,
      height: 50.h,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.primary,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor ?? AppColors.white),
      ),
      child: isLoading!
          ? Padding(
              padding: EdgeInsets.only(right: 15.w),
              child: Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(),
                ),
              ),
            )
          : items.isNotEmpty
          ? DropdownButton<T>(
              value: value,
              underline: const SizedBox(),
              isExpanded: true,
              dropdownColor: dropDownColor ?? AppColors.primary,
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              borderRadius: BorderRadius.circular(10),
              style: context.bodySmall?.copyWith(
                color: textColor ?? AppColors.black,
                fontSize: 16.sp,
              ),
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: iconColor ?? AppColors.black,
              ),
              hint: Text(
                hint,
                style: context.bodySmall?.copyWith(
                  fontSize: 16.sp,
                  color: textColor ?? AppColors.black,
                ),
              ),
              onChanged: onChanged,
              items: items.map<DropdownMenuItem<T>>((T item) {
                return DropdownMenuItem<T>(
                  value: item,
                  child: Text(displayItem(item)),
                );
              }).toList(),
            )
          : Center(
              child: Text(
                emptyText ?? "No data available",
                style: context.bodySmall?.copyWith(
                  fontSize: 16.sp,
                  color: textColor ?? AppColors.black,
                ),
              ),
            ),
    );
  }
}
