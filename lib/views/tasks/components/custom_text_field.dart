import 'package:flutter/material.dart';
import 'package:todo_app/utils/app_colors.dart';
import 'package:todo_app/utils/app_str.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.isForDescription});

  final bool isForDescription;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,

      // add note and add description inputs
      child: ListTile(
        title: TextFormField(
          maxLines: 1,
          decoration: InputDecoration(
            hintText: isForDescription ? AppStr.addNote : AppStr.addTaskString,
            hintStyle: TextStyle(color: Colors.grey),
            prefixIcon: Icon(
              isForDescription ? Icons.bookmark_border : Icons.notes_rounded,
              color: Colors.grey,
            ),
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
