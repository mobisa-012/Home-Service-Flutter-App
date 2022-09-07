import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homeservice_app_ui/core/const/color.dart';
import 'package:homeservice_app_ui/core/const/path_constants.dart';

class TaskyTextField extends StatefulWidget {
  final String title;
  final String placeholder;
  final String errorText;
  final bool isError;
  final bool obscureText;
  final TextEditingController controller;
  final VoidCallback onTextChanged;
  final TextInputAction textInputAction;
  final TextInputType? keyboardType;

  const TaskyTextField(
      {required this.controller,
      required this.errorText,
      this.obscureText = false,
      this.isError = false,
      required this.keyboardType,
      required this.onTextChanged,
      required this.placeholder,
      this.textInputAction = TextInputAction.done,
      required this.title,
      Key? key})
      : super(key: key);

  @override
  TaskyTextFieldState createState() => TaskyTextFieldState();
}

class TaskyTextFieldState extends State<TaskyTextField> {
  final focusNode = FocusNode();
  bool stateObscureText = false;
  bool stateIsError = false;

  @override
  void initState() {
    super.initState();

    focusNode.addListener(() {
      setState(() {
        if (focusNode.hasFocus) {
          stateIsError = false;
        }
      });
    });
    stateObscureText = widget.obscureText;
    stateIsError = widget.isError;
  }

  @override
  void didUpdateWidget(covariant TaskyTextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    stateObscureText = widget.obscureText;
    stateIsError = focusNode.hasFocus ? false : widget.isError;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _createHeader(),
          const SizedBox(
            height: 5,
          ),
          _createTextFieldStack(),
          if (stateIsError) ...[_createError()]
        ],
      ),
    );
  }

  Widget _createHeader() {
    return Text(
      widget.title,
      style: TextStyle(
          color: _getUserNameColor(),
          fontSize: 14,
          fontWeight: FontWeight.w500),
    );
  }

  Color _getUserNameColor() {
    if (focusNode.hasFocus) {
      return AppColors.displayNameTextColor;
    } else if (stateIsError) {
      return AppColors.errorColor;
    } else if (widget.controller.text.isNotEmpty) {
      return AppColors.textColor;
    }
    return AppColors.dotsColor;
  }

  Widget _createTextFieldStack() {
    return Stack(
      children: [
        _createTextField(),
        if (widget.obscureText) ...[
          Positioned(
            child: _createShowEye(),
            right: 0,
            left: 0,
            bottom: 0,
            top: 0,
          )
        ]
      ],
    );
  }

  Widget _createTextField() {
    return TextField(
      focusNode: focusNode,
      controller: widget.controller,
      obscureText: stateObscureText,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      style: TextStyle(color: AppColors.textColor, fontSize: 16),
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: stateIsError
                    ? AppColors.errorColor
                    : AppColors.textFieldColor.withOpacity(0.4),
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.textColor)),
          hintText: widget.placeholder,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
          filled: true,
          fillColor: AppColors.textFieldBackground),
      onChanged: (text) {
        setState(() {
          widget.onTextChanged();
        });
      },
    );
  }

  Widget _createShowEye() {
    return GestureDetector(
      onTap: () {
        setState(() {
          stateObscureText != stateObscureText;
        });
      },
      child: Image(
        image: AssetImage(PathConstants.eye),
        color: widget.controller.text.isNotEmpty
            ? AppColors.textColor
            : Colors.grey,
      ),
    );
  }

  Widget _createError() {
    return Container(
      padding: const EdgeInsets.only(top: 2),
      child: Text(
        widget.errorText,
        style: const TextStyle(
          fontSize: 14,
          color: AppColors.errorColor
        ),
      ),
    );
  }
}
