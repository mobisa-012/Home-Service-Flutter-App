import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:homeservice_app_ui/core/const/color.dart';

class TaskyButton extends StatelessWidget {
  final String title;
  final bool isEnabled;
  final Function() onTap;
  const TaskyButton(
      {Key? key,
      required this.title,
      required this.isEnabled,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: isEnabled ? AppColors.textColor : AppColors.disabledButtonColor,
        borderRadius: BorderRadius.circular(100)
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: onTap,
          child: Center(
            child: Text(title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),),
          ),
        ),
      ),
    );
  }
}
