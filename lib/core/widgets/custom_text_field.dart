import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    this.controller,
    this.isPassword = false,
    this.hintText,
    this.validator,
    this.onChanged,
    this.onEditingComplete,
    this.onTap,
    this.keyboardType,
    this.suffixWidget,
    this.prefixIcon,
    this.prefix,
    this.action,
    this.focusNode,
    this.borderRadius,
    this.enabled,
  });

  final TextEditingController? controller;
  final bool isPassword;
  final String? hintText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final void Function()? onTap;
  final TextInputType? keyboardType;
  final Widget? suffixWidget;
  final Widget? prefixIcon;
  final Widget? prefix;
  final TextInputAction? action;
  final FocusNode? focusNode;
  final BorderRadius? borderRadius;
  final bool? enabled;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool obscureText;

  @override
  void initState() {
    super.initState();
    obscureText = widget.isPassword;
  }

  void _toggleObscureText() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      onTap: widget.onTap,
      obscureText: obscureText,
      keyboardType: widget.keyboardType,
      textInputAction: widget.action ?? TextInputAction.next,
      focusNode: widget.focusNode,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.transparent,
        hintText: widget.hintText,
        hintStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        errorMaxLines: 4,
        errorStyle: const TextStyle(color: Colors.red),
        prefixIcon: widget.prefixIcon,
        prefix: widget.prefix,
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: _toggleObscureText,
                child: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  size: 27,
                ),
              )
            : widget.suffixWidget,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 13,
          vertical: 14,
        ),
        border: _outlineInputBorder(color: Colors.grey, width: 1),
        enabledBorder: _outlineInputBorder(color: Colors.grey, width: 1),
        focusedBorder: _outlineInputBorder(color: Colors.black, width: 1),
        errorBorder: _outlineInputBorder(color: Colors.red, width: 1),
        focusedErrorBorder: _outlineInputBorder(color: Colors.red, width: 1),
      ),
    );
  }

  OutlineInputBorder _outlineInputBorder({
    required Color color,
    required double width,
  }) {
    return OutlineInputBorder(
      borderRadius: widget.borderRadius ?? BorderRadius.circular(10),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
