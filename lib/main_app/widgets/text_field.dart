import 'package:flutter/material.dart';
import 'package:flutter_app/main_app/resources/app_const.dart';
import 'package:flutter_app/main_app/resources/size_config.dart';
import 'package:flutter_app/main_app/util/validator.dart';
import 'package:get/get.dart';

class RoundedTextField extends StatelessWidget {
  final GetSizeConfig sizeConfig = Get.find();
  final String labelText;
  final IconData icon;
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool obscureText;
  final FormFieldValidator<String> validator;
  final String hintText;
  final String errorText;
  final TextInputType keyboardType;
  final int maxLines;
  final int minLines;
  final EdgeInsetsGeometry contentPadding;
  final bool autoFocus;
  final bool enabled;
  final AutovalidateMode autoValidateMode;
  final bool readOnly;
  final bool isRequired;
  final TextInputAction textInputAction;
  final ValueChanged<String> onFieldSubmitted;
  final Widget prefix;
  final Function onChanged;
  final int maxLength;
  final GestureTapCallback onTap;
  final Key textFieldKey;
  RoundedTextField({
    @required this.labelText,
    @required this.icon,
    @required this.controller,
    @required this.focusNode,
    this.obscureText = false,
    this.validator,
    this.prefix,
    this.onTap,
    this.isRequired = false,
    this.enabled = true,
    this.errorText,
    this.hintText,
    this.autoFocus = false,
    this.autoValidateMode,
    this.contentPadding,
    this.keyboardType,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.onChanged,
    this.onFieldSubmitted,
    this.readOnly = false,
    this.textFieldKey,
    this.textInputAction,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeConfig.getSize(60),
      width: sizeConfig.width * 800,
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        focusNode: focusNode,
        onTap: onTap,
        readOnly: readOnly,
        enabled: enabled,
        maxLength: maxLength,
        minLines: minLines,
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        autofocus: autoFocus,
        //maxLines: maxLines,
        autovalidateMode: autoValidateMode,
        keyboardType: keyboardType,
        validator:
        validator ?? (isRequired ? Validator().nullFieldValidate : null),
        textInputAction: textInputAction,

        style: TextStyle(
            color: Color(0xff4D4F56)
        ),
        decoration: InputDecoration(
          labelText: labelText + ' (required)',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? AppConst.green : AppConst.darkGrey
          ),
          prefixIcon: Icon(
            icon,
            color: focusNode.hasFocus ? AppConst.green : AppConst.darkGrey,
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(111),
              borderSide: BorderSide(
                  color: AppConst.green
              )
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(111)
          ),
        ),
      ),
    );
  }
}