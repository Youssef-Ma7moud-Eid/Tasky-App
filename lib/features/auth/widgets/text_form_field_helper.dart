import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_styles.dart';

class TextFormFieldHelper extends StatefulWidget {
  final TextEditingController? controller;
  final bool isPassword;
  final String? hint, obscuringCharacter;
  final bool enabled;
  final int? maxLines, minLines, maxLength;
  final String? Function(String?)? onValidate;
  final void Function(String?)? onChanged, onFieldSubmitted, onSaved;
  final void Function()? onEditingComplete, onTap;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixWidget, prefixIcon, prefix;
  final IconData? icon;
  final TextInputAction? action;
  final FocusNode? focusNode;

  final BorderRadius? borderRadius;
  final bool? isMobile;

  const TextFormFieldHelper({
    super.key,
    this.controller,
    this.isPassword = false,
    this.hint,
    this.enabled = true,
    this.obscuringCharacter,
    this.onValidate,
    this.onChanged,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.onSaved,
    this.onTap,
    this.maxLines = 1,
    this.minLines = 1,
    this.maxLength,
    this.keyboardType,
    this.inputFormatters,
    this.suffixWidget,
    this.icon,
    this.prefixIcon,
    this.prefix,
    this.action,
    this.focusNode,
    this.borderRadius,
    this.isMobile,
  });

  @override
  State<TextFormFieldHelper> createState() => _TextFormFieldHelperState();
}

class _TextFormFieldHelperState extends State<TextFormFieldHelper> {
  late bool obscureText;
  TextDirection _textDirection = TextDirection.rtl;

  @override
  void initState() {
    super.initState();
    obscureText = widget.isPassword;
  }

  void _toggleObscureText() {
    setState(() => obscureText = !obscureText);
  }

  void _updateTextDirection(String text) {
    if (text.isEmpty) return;
    final isArabic = RegExp(r'^[\u0600-\u06FF]').hasMatch(text);
    setState(() {
      _textDirection = isArabic ? TextDirection.rtl : TextDirection.ltr;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      controller: widget.controller,
      validator: widget.onValidate,
      onChanged: (text) {
        widget.onChanged?.call(text);
        _updateTextDirection(text);
      },
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: widget.onFieldSubmitted,
      onSaved: widget.onSaved,
      onTap: widget.onTap,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      obscureText: obscureText,
      obscuringCharacter: widget.obscuringCharacter ?? '*',

      keyboardType: widget.keyboardType,
      // inputFormatters: widget.inputFormatters,
      enabled: widget.enabled,
      textInputAction: widget.action ?? TextInputAction.next,
      focusNode: widget.focusNode,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: AppStyles.latoRegular14,

      textAlign: widget.isMobile != null ? TextAlign.left : TextAlign.start,

      textDirection: widget.isMobile != null
          ? TextDirection.ltr
          : _textDirection,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: widget.hint,
        hintStyle: AppStyles.latoRegular16.copyWith(
          color: AppColors.subTitleColor,
        ),
        errorMaxLines: 4,
        errorStyle: const TextStyle(color: Colors.red),
        prefixIcon: widget.prefixIcon,
        prefix: widget.prefix,
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: _toggleObscureText,
                child: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                  size: 27,
                ),
              )
            : widget.suffixWidget,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 13,
          vertical: 15,
        ),
        border: outlineInputBorder(color: AppColors.subTitleColor, width: 1),
        enabledBorder: outlineInputBorder(color: Colors.grey, width: 1),
        focusedBorder: outlineInputBorder(color: Colors.grey, width: 1),
        errorBorder: outlineInputBorder(color: Colors.red, width: 1),
        focusedErrorBorder: outlineInputBorder(color: Colors.red, width: 1),
      ),
    );
  }

  OutlineInputBorder outlineInputBorder({
    required Color color,
    required double width,
  }) {
    return OutlineInputBorder(
      borderRadius: widget.borderRadius ?? BorderRadius.circular(10),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
