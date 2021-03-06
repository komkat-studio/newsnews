import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsnews/src/core/theme/palette.dart';

class CustomCategoryChoiceChip extends StatelessWidget {
  const CustomCategoryChoiceChip({
    Key? key,
    required this.category,
    required this.choiceStatus,
    this.onSelectCategoryFunction,
    this.sideBorderIsPrimaryColor = true,
  }) : super(key: key);

  final String category;
  final bool choiceStatus;
  final ValueChanged<bool>? onSelectCategoryFunction;
  final bool sideBorderIsPrimaryColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: ChoiceChip(
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          side: sideBorderIsPrimaryColor
              ? BorderSide(color: Palette.primaryColor, width: 1.4)
              : BorderSide(
                  color: choiceStatus
                      ? Palette.primaryColor
                      : Palette.descriptionColor,
                  width: 1.4,
                ),
        ),
        label: Text(category),
        labelStyle: TextStyle(
          color: choiceStatus ? Colors.white : Colors.black,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
        labelPadding: EdgeInsets.symmetric(horizontal: 10.w),
        selected: choiceStatus,
        onSelected: onSelectCategoryFunction,
        selectedColor: Palette.primaryColor,
        backgroundColor: Colors.blue.shade50.withOpacity(0.1),
      ),
    );
  }
}
