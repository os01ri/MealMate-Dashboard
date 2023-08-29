import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mealmate_dashboard/core/constants/constants.dart';

class SimpleLabelTextField extends StatefulWidget {
  final TextEditingController? textEditingController;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final bool? isMultiLine;
  final Color? borderColor;
  final Function(String)? onChange;
  final String? labelText;
  final TextStyle? labelStyle;
  final Color? labelTextColor;
  final TextInputType? textInputType;
  final bool? isPassword;
  final VoidCallback? onFinish;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final String? hintText;
  final Color? foucsBorderColor;
  final double? borderRadiusValue;
  final bool? enableValue;
  final FontWeight? selectedTextWeight;
  final Color? backgroundColor;

  SimpleLabelTextField(
      {Key? key,
      this.borderColor,
        this.hintText,

        this.backgroundColor,
        this.labelStyle,
      this.textEditingController,
      this.textInputType,
      this.inputFormatters,
      this.labelText,
        this.labelTextColor,
        this.foucsBorderColor,
        this.borderRadiusValue,
        this.enableValue,
        this.selectedTextWeight,
      this.isPassword = false,
      this.onFinish,
      this.onChange,
      this.focusNode,
      this.textInputAction,
      this.validator,
      this.isMultiLine = false})
      : super(key: key);

  SimpleLabelTextFieldState createState() => SimpleLabelTextFieldState();
}

class SimpleLabelTextFieldState extends State<SimpleLabelTextField> {
  String? errorText;
  bool view = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
      color: widget.backgroundColor?? Colors.transparent,

      borderRadius: BorderRadius.all(Radius.circular(widget.borderRadiusValue?? 6))),
        child: Theme(
          data: Theme.of(context).copyWith(
              inputDecorationTheme: InputDecorationTheme(
                floatingLabelStyle:
                TextStyle(color: widget.labelTextColor?? primaryColor,
                fontWeight: FontWeight.w400,
                  fontSize: 22
                ),
                labelStyle:
                TextStyle(color: widget.labelTextColor?? primaryColor,
                fontWeight: FontWeight.w400),

                enabledBorder:  OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1,
                        color: widget.borderColor?? Color(0xFFE5F1FD)
                    )
                ),
                errorBorder:  OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1,
                        color: Colors.red
                    )
                ),
                focusedErrorBorder:  OutlineInputBorder(
                  borderSide: BorderSide(
                  width: 1,
                  color: Colors.red
              )
          ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1,
                        color: widget.foucsBorderColor?? primaryColor
                    )
                ),
                //rama added disabledBorder
                disabledBorder:  OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1,
                        color: widget.borderColor?? Color(0xFFE5F1FD)
                    )
                ),
              )),
          child: TextFormField(
            style: TextStyle(fontWeight: widget.selectedTextWeight),
            enabled: widget.enableValue?? true,
            textAlignVertical: TextAlignVertical.center,
            controller: widget.textEditingController,
            minLines: widget.isMultiLine! ? 6 : 1,
            onChanged: widget.onChange,
            focusNode: widget.focusNode,
            onEditingComplete: widget.onFinish,
            textInputAction: widget.textInputAction,
            obscureText: view ? false : widget.isPassword!,
            maxLines: widget.isMultiLine! ? 20 : 1,
            keyboardType: widget.textInputType,
            validator: (value) {
              if (widget.validator != null) {
                errorText = widget.validator!(value??"");
                setState(() {});
                return errorText;
              }
              return null;
            },
            inputFormatters: widget.inputFormatters,
            decoration: InputDecoration(
                filled: true,

                fillColor: Colors.white.withOpacity(0.2),
              hintText: widget.hintText,
                suffixIcon: widget.isPassword!
                    ? IconButton(
                        icon: Icon(view
                            ? Icons.remove_red_eye
                            : Icons.remove_red_eye_outlined),
                        onPressed: () {
                          setState(() {
                            view = !view;
                          });
                        },
                      )
                    : null,
                labelText: widget.labelText,
                errorStyle: TextStyle(color: Colors.red,
                  fontWeight: FontWeight.w700
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,vertical: 16
                )

            ),
          ),
        ),
      );
  }
}

Color labelTextFieldColor = Color(0xFF888888);

