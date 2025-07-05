import 'package:flutter/material.dart';
import 'package:todo_app/utils/app_colors.dart';
import 'package:todo_app/utils/app_str.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.isForDescription = false,
  });

  final TextEditingController? controller;
  final bool isForDescription;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      child: ListTile(
        title: TextFormField(
          controller: controller,
          // maxLines: isForDescription ? 3 : 1,
          maxLines: 1,
          decoration: InputDecoration(
            hintText: isForDescription ? AppStr.addNote : AppStr.addTaskString,
            hintStyle: TextStyle(color: Colors.grey),
            prefixIcon: isForDescription
                ? Icon(Icons.bookmark_border, color: Colors.grey)
                : Icon(Icons.notes_rounded, color: Colors.grey),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryColor),
            ),
          ),
          onFieldSubmitted: (value) {},
          onChanged: (value) {},
        ),
      ),
    );
  }
}
