import 'package:flutter/material.dart';
import 'package:squeak/components/colors.dart';

class CustomTextField extends StatefulWidget {
  final String hinttext;
  
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool showSuffixIcon; 

  CustomTextField({
    required this.hinttext,
    
    
    required this.controller,
    required this.validator,
    this.showSuffixIcon = true,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.showSuffixIcon ? _isObscure : false,
      validator: widget.validator,
      
      
      textAlign: TextAlign.start,
      cursorColor: Colors.white,
      style: TextStyle(
        color: Colors.white,
        fontSize: 17,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        filled: true,
        fillColor: AppColors
            .textfieldcolor, // You can replace it with Customitems.textfieldcolor
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        hintText: widget.hinttext,
        focusColor: Colors.transparent,
        hintStyle: TextStyle(
          fontSize: 17,
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
        suffixIcon: widget.showSuffixIcon
            ? IconButton(
                icon: Icon(
                  _isObscure ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.whitecolor,
                ),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
              )
            : null,
            // Show suffix icon only if showSuffixIcon is true
      ),

    );
  }
}