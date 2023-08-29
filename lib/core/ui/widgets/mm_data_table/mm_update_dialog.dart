import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mealmate_dashboard/core/extensions/widget_extensions.dart';
import 'package:mealmate_dashboard/core/ui/theme/text_styles.dart';
import 'package:mealmate_dashboard/core/ui/widgets/main_button.dart';

Future<dynamic> showMMUpdateDialog({required BuildContext context,
  required String title,
  required Widget updateFieldsWidget
}) async {

  showDialog(context: context, builder: (context) {
   return MMUpdateDialog(
     title: title,
     addFieldsWidget: updateFieldsWidget,
   );
  },);


  return 1;
}

class MMUpdateDialog extends StatefulWidget {
  final String title;

  final Widget addFieldsWidget;
  const MMUpdateDialog({Key? key,required this.title,required this.addFieldsWidget}) : super(key: key);

  @override
  State<MMUpdateDialog> createState() => _MMUpdateDialogState();
}

class _MMUpdateDialogState extends State<MMUpdateDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width*0.75,
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(onPressed: (){
                        Navigator.of(context).pop();
                      },
                          icon: Icon(Icons.close,color: Colors.red,))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.title,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.styleWeight700(
                          fontSize: 24,
                          color: Colors.white
                        ),
                      )
                    ],
                  ),
                ],
              ),

              SizedBox(
                height: 34,
              ),


                widget.addFieldsWidget


            ],
          ),
        ),
      ),
    );
  }
}

Widget mmUpdateDialogFooter({required BuildContext context,required Function onUpdate}){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      MainButton(
          text: "Cancel".tr(),
          icon: const Icon(Icons.cancel,
            color: Colors.white,
          ),
          color: Colors.grey, onPressed: (){
        Navigator.of(context).pop();
      }).expand(),

      const SizedBox(width: 16,),

      MainButton(text: "Update".tr(),
          icon: const Icon(Icons.edit,
            color: Colors.white,
          ),
          color: Colors.cyan, onPressed: (){
            onUpdate();
          }).expand(),
    ],
  );

}