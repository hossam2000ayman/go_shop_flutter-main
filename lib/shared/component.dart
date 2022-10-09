import 'package:flutter/material.dart';


Widget defaultFormField({
  required context,
  TextEditingController? controller,
  dynamic label,
  IconData ? prefix,
  String ? initialValue,
  TextInputType ?keyboardType,
  Function(String)? onSubmit,
  onChange,
  onTap,
  required String? Function(String?) validate,
  bool isPassword = false,
  bool enabled = true,
  IconData ?suffix,
  suffixPressed,
  bool border = true,
  bool isContainer = false,
  Color? prefixColor,
  double radius = 0.0,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      textAlign: TextAlign.start,
      onFieldSubmitted: onSubmit,
      enabled: enabled,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      textCapitalization: TextCapitalization.words,
      textAlignVertical: TextAlignVertical.center,
      style:Theme.of(context).textTheme.bodyText1,
      initialValue:initialValue ,
      //textCapitalization: TextCapitalization.words,

      decoration: InputDecoration(
        prefixIcon: isContainer
            ? Container(
          height: 59.0,
          decoration: BoxDecoration(
            color: Colors.amber[700],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radius),
              bottomLeft: Radius.circular(radius),
            ),
          ),
          child: Icon(prefix,color: prefixColor,),
        )
            : Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          icon: Icon(
            suffix,
          ),
          onPressed: suffixPressed,
        )
            : null,
        border: border
            ? OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
        )
            : InputBorder.none,
        hintText: label,
      ),
    );

Widget defaultButton({
  required VoidCallback onTap,
  required String text,
  double? width = double.infinity,

}) => Container(
  height: 40,
  width: width,
  decoration: BoxDecoration(
    color: Colors.red,
  ),
  child: ElevatedButton(
    onPressed: onTap,
    child: Text(
      '$text',
      style: TextStyle(
        color: Colors.white,
        fontSize: 17,
      ),
    ),
  ),
);



