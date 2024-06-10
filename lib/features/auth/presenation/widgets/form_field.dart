import 'package:flutter/material.dart';

class MyFormField extends StatelessWidget {
  final double radius;
  final String? title;
  final bool? readOnly;
  final String hint;
  final int? maxLines;
  final TextStyle? hintStyle;
  final TextInputType type;
  final VoidCallback? suffixIconPressed;
  final IconData? suffixIcon;
  final Widget? widget;
  final TextEditingController? controller;
  final dynamic validation;
  final bool isPassword;

  const MyFormField(
      {super.key,
        this.isPassword = false,
        this.radius = 15,
        required this.type,
        required this.hint,
        required this.maxLines,
        this.suffixIcon,
        this.readOnly=false,
        this.suffixIconPressed,
        this.widget,
        this.controller,
        this.hintStyle,
        this.title="",
        this.validation});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Colors.grey[100],
          ),
          child: TextFormField(
            readOnly: readOnly!,
            obscureText: isPassword,
            controller: controller,
            keyboardType: type,
            maxLines: maxLines,
            // Allow for dynamic expansion
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: hintStyle,
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(

                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(6),
              ),
              suffixIcon: suffixIcon != null
                  ? IconButton(
                onPressed: () {
                  suffixIconPressed!();
                },
                icon: Icon(
                  suffixIcon,
                  color: Colors.blue,
                ),
              )
                  : null,
            ),
            validator: validation,
          ),
        ),
      ],
    );
  }
}