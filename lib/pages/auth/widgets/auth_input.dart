import 'package:flutter/material.dart';

/// Colors
import '../../../colors/app_colors.dart';

/// Responsive
import '../../../utils/responsive.dart';

class AuthInput extends StatelessWidget {
  final String label;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final bool obscureText;

  const AuthInput({
    Key? key,
    required this.label,
    required this.textInputAction,
    required this.controller,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(Responsive.isMobile(context) ? 10 : 20),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: Responsive.isMobile(context) ? 20 : 40,
      ),
      child: TextFormField(
        style: TextStyle(
          fontFamily: 'MyriadProRegular',
          fontSize: Responsive.isMobile(context) ? 15 : 32,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: Responsive.isMobile(context) ? 16 : 16 * 1.5,
            vertical: Responsive.isMobile(context) ? 18 : 18 * 1.5,
          ),
          hintText: label,
          filled: true,
          fillColor: const Color(0xFFF2F2F2),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent, width: 2),
            borderRadius: BorderRadius.all(
              Radius.circular(Responsive.isMobile(context) ? 16 : 32),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(Responsive.isMobile(context) ? 16 : 32),
            ),
            borderSide: const BorderSide(color: primaryColor, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(Responsive.isMobile(context) ? 16 : 32),
            ),
            borderSide: const BorderSide(color: Colors.redAccent, width: 2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(Responsive.isMobile(context) ? 16 : 32),
            ),
            borderSide: const BorderSide(color: Colors.redAccent, width: 2),
          ),
        ),
        textInputAction: textInputAction,
        cursorColor: primaryColor,
        controller: controller,
        obscureText: obscureText,
        validator: (val) {
          if (val!.isEmpty) {
            return '$label không được bỏ trống';
          }
          return null;
        },
      ),
    );
  }
}
