import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../Constance/common_constance.dart';

///custom TextFormField
class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.formFieldController,
    required this.hintTextValue,
    this.inputType = TextInputType.text,
    required this.validatorFunc,
    this.suffixIcon = false,
  });
  final TextEditingController formFieldController;
  final String hintTextValue;
  final TextInputType inputType;
  final String? Function(dynamic value) validatorFunc;
  final bool suffixIcon;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 60,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(80),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade400,
                  blurRadius: 6,
                  spreadRadius: 0.5),
            ],
          ),
        ),
        SizedBox(
          height: 80,
          child: TextFormField(
            controller: widget.formFieldController,
            keyboardType: widget.inputType,
            obscureText: widget.suffixIcon ? obscureText : false,
            decoration: InputDecoration(
              suffix: widget.suffixIcon
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      child: obscureText
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility))
                  : null,
              filled: true,
              contentPadding: const EdgeInsets.only(
                  left: 20, top: 20, bottom: 20, right: 20),
              fillColor: Colors.white,
              hintText: widget.hintTextValue,
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(80),
                  ),
                  borderSide: BorderSide.none),
            ),
            validator: widget.validatorFunc,
          ),
        ),
      ],
    );
  }
}

///custom Button
class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    this.buttonHeight = 50,
    this.buttonWidth = double.infinity,
    this.borderRadius = 10,
    this.btnColor = CommonConstance.background,
    required this.btnText,
    this.textColor = Colors.white,
    this.fontSize = 20,
    required this.btnClick,
  });

  final double buttonHeight, buttonWidth, borderRadius, fontSize;
  final int btnColor;
  final String btnText;
  final Color textColor;
  final Function btnClick;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.btnClick();
      },
      child: Container(
        // padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 40),
        height: widget.buttonHeight,
        width: widget.buttonWidth,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Color(widget.btnColor),
            borderRadius: BorderRadius.circular(widget.borderRadius)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.btnText,
              style: TextStyle(
                  color: widget.textColor,
                  fontSize: widget.fontSize,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }
}

///Pin Input Field Decoration
InputDecoration userPinInputBox() {
  return InputDecoration(
    filled: true,
    fillColor: Colors.white,
    contentPadding:
        const EdgeInsets.fromLTRB(5.0 * 2, 5.0 * 2, 5.0 * 2, 5.0 * 2),
    enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 2, color: Color(CommonConstance.background)),
        borderRadius: BorderRadius.circular(4)),
    focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          width: 2,
          color: Color(CommonConstance.background),
        ),
        borderRadius: BorderRadius.circular(4)),
    border: OutlineInputBorder(
        borderSide: const BorderSide(width: 2, color: Colors.black),
        borderRadius: BorderRadius.circular(4)),
  );
}

showSnackBarNew(BuildContext context, String message) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
  ));
}

/// print log data
showLog(String message) {
  if (kDebugMode) {
    print(message);
  }
}

/// show SnackBar
customShowSnackBar(BuildContext context, {String message = ""}) {
  ScaffoldMessenger.of(context).showSnackBar(showSnackBar(message));
}

showSnackBar(String contentTitle) {
  return SnackBar(
    content: Text(contentTitle),
  );
}
