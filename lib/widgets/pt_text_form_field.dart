import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PtTextField extends StatelessWidget {
  final String? initialValue;
  final void Function(String)? onChanged;
  final String? hintText;
  final String labelText;
  final int maxLines;
  final int? errorMaxLines;
  final int? maxLength;
  final double? heightContainer;
  final double? widthContainer;
  final EdgeInsets? contentPadding;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;

  const PtTextField({
    Key? key,
    this.initialValue,
    this.onChanged,
    this.hintText,
    this.maxLines = 1,
    this.contentPadding,
    this.hintStyle,
    this.heightContainer = 64,
    this.widthContainer,
    this.controller,
    this.validator,
    this.inputFormatters,
    required this.labelText,
    this.errorStyle,
    this.errorMaxLines,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final content = TextFormField(
      controller: controller,
      validator: validator,
      initialValue: initialValue,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      style: theme.textTheme.bodyText2!.copyWith(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        height: 1.35,
        overflow: TextOverflow.ellipsis,
      ),
      cursorColor: Colors.black,
      onChanged: onChanged,
      maxLines: maxLines,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        errorMaxLines: errorMaxLines,
        hintText: hintText,
        label: Text(labelText),
        errorStyle: errorStyle,
        labelStyle: const TextStyle(color: Colors.black),
        focusColor: Colors.black,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        contentPadding:
            const EdgeInsets.only(left: 10, right: 11, top: 8, bottom: 8),
        isDense: false,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: Colors.black.withOpacity(.5),
            width: 1,
          ),
        ),
      ),
    );

    return SizedBox(
      height: heightContainer,
      width: widthContainer,
      child: content,
    );
  }
}
