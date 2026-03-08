// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, prefer_const_constructors

import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/constants.dart';

class TextFieldWidget extends StatefulWidget {
  var isPassword;
  var isSecure;
  var fontSize;
  var textColor;
  var fontFamily;
  var text;
  var hint;
  var maxLine;
  var maxLength;
  var inputType;
  var inputFormate;
  var suffixIcon;
  var errorText;
  var validator;
  var autofocus;
  var readOnly;
  var inputAction;
  var floating;
  Function? submit;
  TextEditingController mController;

  VoidCallback? onPressed;
  VoidCallback? onTap;

  TextFieldWidget(
      {Key? key,
      var this.fontSize = textSizeNormal,
      var this.textColor = textColorSecondary,
      var this.fontFamily = fontRegular,
      var this.isPassword = false,
      var this.hint = "",
      var this.isSecure = false,
      var this.text = "",
      required var this.mController,
      var this.maxLine = 1,
      this.maxLength,
      this.inputType,
      this.suffixIcon,
      this.errorText,
      this.validator,
      this.inputFormate,
      this.inputAction,
      this.submit,
      this.onTap,
      this.floating,
      var this.autofocus = false,
      var this.readOnly = false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TextFieldWidgetState();
  }
}

class TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: widget.autofocus,
      readOnly: widget.readOnly,
      controller: widget.mController,
      obscureText: widget.isPassword,
      maxLength: widget.maxLength,
      keyboardType: widget.inputType,
      inputFormatters: widget.inputFormate,
      validator: widget.validator,
      textInputAction: widget.inputAction,
      onTap: widget.onTap,
      //onFieldSubmitted: widget.submit,
      style: TextStyle(
          color: textColorPrimary,
          fontSize: textSizeLargeMedium,
          fontFamily: fontRegular),
      decoration: InputDecoration(
        floatingLabelBehavior: widget.floating,
        prefixText: widget.maxLength == 10 ? "+91" : "",
        errorText: widget.errorText,
        labelText: widget.text,
        labelStyle: TextStyle(color: primaryBlackColor),
        suffixIcon: widget.isSecure
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    widget.isPassword = !widget.isPassword;
                  });
                },
                child: Icon(
                  widget.isPassword ? Icons.visibility_off : Icons.visibility,
                  color: primaryBlackColor,
                ),
              )
            : null,
        contentPadding: EdgeInsets.fromLTRB(16, 10, 16, 10),
        hintText: widget.hint,
        hintStyle: TextStyle(color: textColorThird),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: viewColor, width: 0.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: viewColor, width: 0.0),
        ),
      ),
    );
  }

  State<StatefulWidget>? createState() {
    return null;
  }
}

TextFormField editTextStyle(var hintText, {isPassword = true}) {
  return TextFormField(
    style: TextStyle(fontSize: textSizeLargeMedium, fontFamily: fontRegular),
    obscureText: isPassword,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(16, 10, 16, 10),
      hintText: hintText,
      hintStyle: TextStyle(color: textColorThird),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: viewColor, width: 0.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: viewColor, width: 0.0),
      ),
    ),
  );
}
