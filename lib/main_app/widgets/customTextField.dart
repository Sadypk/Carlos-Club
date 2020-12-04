import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final FormFieldValidator<String> validator;
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String errorText;
  final TextInputType keyboardType;
  final int maxLines;
  final int minLines;
  final EdgeInsetsGeometry contentPadding;
  final FocusNode focusNode;
  final bool autofocus;
  final bool enabled;
  final bool autovalidate;
  final bool readOnly;
  final bool isRequired;
  final TextInputAction textInputAction;
  final ValueChanged<String> onFieldSubmitted;
  final IconData prefix;
  final Function onChanged;
  final int maxLength;
  final GestureTapCallback onTap;
  final Key textFieldKey;
  final TextStyle labelStyle;
  final bool border;
  final bool obscureText;

  const CustomTextFormField({
    this.readOnly = false,
    this.obscureText = false,
    this.border = false,
    this.enabled = true,
    this.maxLength,
    this.validator,
    this.prefix,
    this.errorText,
    this.onChanged,
    this.textInputAction,
    this.autovalidate = false,
    this.controller,
    this.onFieldSubmitted,
    @required this.focusNode,
    this.isRequired = false,
    this.autofocus = false,
    @required this.labelText,
    this.hintText,
    this.minLines,
    this.onTap,
    this.keyboardType,
    this.contentPadding =
    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    this.maxLines = 1,
    this.textFieldKey,
    this.labelStyle
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    FocusScopeNode currentFocus = FocusScope.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
/*        if (labelText != null)
          Row(
            children: [
              Flexible(
                child: Text("  ${labelText ?? ""}",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              if (isRequired)
                Text(
                  " *",
                  style: TextStyle(color: Colors.red),
                )
            ],
          ),
        SizedBox(
          height: 5,
        ),*/
        Container(
          height: 60,
          width: width * .8,
          decoration: BoxDecoration(
            color: focusNode.hasFocus ? Colors.green.withOpacity(.3) : Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(1111),
            boxShadow: [
              BoxShadow(
                  color: Color(0xff000000).withOpacity(0.2), blurRadius: 20),
              BoxShadow(
                  color: Color(0xfffafafa).withOpacity(0.2), blurRadius: 20),
            ],
          ),
          child: TextField(
            obscureText: obscureText,
            controller: controller,
            focusNode: focusNode,
            key: textFieldKey,
            onTap: onTap,
            readOnly: readOnly,
            enabled: enabled,
            maxLength: maxLength,
            minLines: minLines,
            onChanged: onChanged,
            autofocus: autofocus,
            onSubmitted: onFieldSubmitted,
            maxLines: maxLines,
            // validator: validator ?? (isRequired ? Validator().nullFieldValidate : null),
            keyboardType: keyboardType,
            style: TextStyle(
                color: Color(0xff4D4F56)
            ),
            decoration: InputDecoration(
              labelText: labelText + '${isRequired && focusNode.hasFocus ? ' *' : ''}',
              labelStyle: TextStyle(
                  color: focusNode.hasFocus ? Colors.green : Colors.grey,
                  fontSize: 22
              ),
              prefixIcon: Icon(
                prefix,
                color: focusNode.hasFocus ? Colors.green : Colors.grey,
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(111),
                  borderSide: BorderSide(
                      color: Colors.green
                  )
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(111)
              ),
            ),
          ),
        ),
        /*Container(
          width: MediaQuery.of(context).size.width * .8,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(1111),
            boxShadow: [
              BoxShadow(
                  color: Color(0xff000000).withOpacity(0.2), blurRadius: 20),
              BoxShadow(
                  color: Color(0xfffafafa).withOpacity(0.2), blurRadius: 20),
            ],
          ),
          child: TextFormField(
            key: textFieldKey,
            onTap: onTap,
            readOnly: readOnly,
            enabled: enabled,
            maxLength: maxLength,
            minLines: minLines,
            onChanged: onChanged,
            onFieldSubmitted: onFieldSubmitted,
            autofocus: autofocus,
            focusNode: focusNode,
            maxLines: maxLines,
            autovalidate: autovalidate,
            keyboardType: keyboardType,
            // validator: validator ?? (isRequired ? Validator().nullFieldValidate : null),
            controller: controller,
            textInputAction: textInputAction,
            decoration: InputDecoration(
              prefix: prefix,
              errorText: errorText,
              errorMaxLines: width>350?2:3,
              hintText: hintText,
              labelText: labelText,
              labelStyle: labelStyle,
              contentPadding: contentPadding,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(111),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor
                )
               ),
              border: border ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(111)
              ) : InputBorder.none,
            ),
          ),
        ),*/
//        errorText != null ? Text('') : SizedBox(),
      ],
    );
  }
}
