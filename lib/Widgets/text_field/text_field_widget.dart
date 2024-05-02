// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../../Constants/Colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.lableStyle,
    this.hintText,
    this.obscureText,
    this.validator,
    this.controller,
    this.keyboardType,
    this.inputFormater,
    this.title,
    this.inputFormatters,
    this.onFieldSubmitted,
    this.readOnly,
    this.onSaved,
    this.label,
    this.autofocus,
    this.fontWeight,
    this.onChanged,
    this.FocusNode,
    this.onTap,
    this.maxLines,
    this.from,
  }) : super(key: key);
  final labelText;
  final prefixIcon;
  final suffixIcon;
  final lableStyle;
  final maxLines;
  final hintText;
  final FocusNode;

  final obscureText;
  final controller;

  final validator;
  final keyboardType;
  final inputFormater;
  final onChanged;
  final title;
  final inputFormatters;
  final onFieldSubmitted;
  final readOnly;
  final onSaved;

  final label;
  final autofocus;
  final fontWeight;
  final onTap;
  final from;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      controller: controller,
      onChanged: onChanged,
      cursorWidth: 1.0,
      focusNode: FocusNode,
      readOnly: readOnly ?? false,
      onFieldSubmitted: onFieldSubmitted,
      onSaved: onSaved,
      minLines: 1,
      maxLines: 1,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: white,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,

        labelStyle: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: from == "FF" || from == "search"
              ? black.withOpacity(0.6)
              : secondaryTextColor,
        ),
        hintText: hintText,

        hintStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: white,
        ),
        contentPadding: EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),

        floatingLabelBehavior: FloatingLabelBehavior.auto,
        isDense: false,

        // border: OutlineInputBorder(),
      ),
    );
  }
}
