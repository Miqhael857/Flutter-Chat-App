import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildSearchField extends StatefulWidget {
  final TextEditingController controller;
  final Function isSearch;
  final Function onChanged;

  const BuildSearchField({
    Key? key,
    required this.controller,
    required this.isSearch,
    required this.onChanged,
  }) : super(key: key);

  @override
  _BuildSearchFieldState createState() => _BuildSearchFieldState();
}

class _BuildSearchFieldState extends State<BuildSearchField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      cursorColor: AppColors.blackTextStyle,
      autofocus: true,
      decoration: InputDecoration(
        hintText: "Search...",
        hintStyle: TextStyle(color: AppColors.blackTextStyle),
        prefixIcon: InkWell(
          onTap: () {
            widget.isSearch();
          },
          child: Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: Icon(
              Icons.arrow_back,
              size: 25.sp,
              color: AppColors.blackTextStyle,
            ),
          ),
        ),
      ),
      textInputAction: TextInputAction.search,
      style: TextStyle(
        fontSize: 20.sp,
        color: AppColors.blackTextStyle,
      ),
      onChanged: (value) {
        widget.onChanged(value);
      },
    );
  }
}

