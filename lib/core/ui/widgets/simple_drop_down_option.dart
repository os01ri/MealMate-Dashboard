import 'package:flutter/material.dart';
import 'package:mealmate_dashboard/core/constants/constants.dart';
import 'package:mealmate_dashboard/core/ui/theme/text_styles.dart';

class SimpleDropDownOption extends StatefulWidget {
  final List<String> itemsOptions;
  final String? selectedItem;
  final Function(String) onSelected;
  final bool? isCentered;
  final Color? borderColor;
  final String? title;
  final String? valueAddedToSelected;
  final TextStyle? selectedItemStyle;
  final Widget? icon;
  final String? hint;


  const SimpleDropDownOption({Key? key,this.hint,required this.itemsOptions,this.borderColor,this.icon ,this.selectedItemStyle,this.valueAddedToSelected,this.title,this.isCentered = false, this.selectedItem, required this.onSelected}) : super(key: key);
  @override
  _SimpleDropDownOptionState createState() => _SimpleDropDownOptionState();
}

class _SimpleDropDownOptionState extends State<SimpleDropDownOption> {
  late List<String> itemsOptions;
  String? selectedItem;
  String? errorText;


  @override
  void initState() {
    super.initState();

    itemsOptions =  widget.itemsOptions.toList();
    selectedItem = widget.selectedItem;

  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          inputDecorationTheme: InputDecorationTheme(
            floatingLabelStyle:
            const TextStyle(color: Colors.black),
            border:  const OutlineInputBorder(
                borderSide: BorderSide(
                    width: 7,
                    color: Colors.red
                )
            ),
            enabledBorder:  OutlineInputBorder(
                borderSide: BorderSide(
                    width: 1,
                    color: widget.borderColor??const Color(0xFFE5F1FD)
                )
            ),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                    width: 1,
                    color: bgColor
                )
            ),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 1,
                    color: widget.borderColor??const Color(0xFFE5F1FD)
                )
            ),

          )),
      child: Container(
        child: Stack(
          children: [

            TextFormField(
              enabled: false,
              controller: TextEditingController(text:
              " "
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    horizontal:  12,vertical: 8
                ),
                errorStyle: const TextStyle(color: Colors.red),

                border:  const OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1,
                        color: Color(0xFFE5F1FD)
                    )
                ),
                enabledBorder:  const OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1,
                        color: Color(0xFFE5F1FD)
                    )
                ),
                disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1,
                        color: Color(0xFFE5F1FD)
                    )
                ),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1,
                        color: primaryColor
                    )
                ),
                errorBorder:  const OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1,
                        color: Colors.red
                    )
                ),
                focusedErrorBorder:  const OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1,
                        color: Colors.red
                    )
                ),
                label: widget.title!=null?Text(widget.title!,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ):null,

              ),
              validator:  (v){

                print(widget.selectedItem);
                if(widget.selectedItem==null || widget.selectedItem=='') {
                  setState(() {
                    errorText = 'This field is required';
                  });
                  return widget.selectedItem == null
                      ? 'This field is required'
                      : "This field is required";
                }
                else {
                  setState(() {
                    errorText=null;
                  });
                  return null;
                }
              },

            ),

            DropdownButton(
              value: selectedItem,

              items:  itemsOptions.map((e) =>  DropdownMenuItem(
                child: Container(
                    alignment :widget.isCentered!? Alignment.center:Alignment.centerLeft,
                    child: Text(e,style: AppTextStyles.styleWeight400(
                        color: Colors.white
                    ),)),value: e,)).toList()
              ,
              selectedItemBuilder: (context){
                return itemsOptions.map((e) =>  Container(
                  alignment:widget.isCentered!? Alignment.center:Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        if(widget.icon!=null)
                          widget.icon!,

                        Text(e + "${widget.valueAddedToSelected!=null?" ${widget.valueAddedToSelected}":""}",maxLines:1,
                          style: widget.selectedItemStyle ?? AppTextStyles.styleWeight400(
                            color: Colors.white
                          ),
                         ),
                      ],
                    ),
                  ),
                )).toList();

              },
              onChanged: (value){
                print(value);
                widget.onSelected(value!);
                setState(() {
                  selectedItem = value;
                });
              },
              isExpanded: true,
              underline: const SizedBox(),
              hint: widget.hint==null?null:Container(
                alignment:widget.isCentered!? Alignment.center:Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      if(widget.icon!=null)
                        widget.icon!,

                      Text(widget.hint!,maxLines:1,
                        style: const TextStyle(
                            color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              icon: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Icon(Icons.keyboard_arrow_down,color: widget.valueAddedToSelected!=null?Colors.black:Colors.grey,),
              ),

            ),
          ],
        ),
      ),
    );
  }
}

