import 'package:flutter/material.dart';
import 'package:mealmate_dashboard/core/extensions/widget_extensions.dart';
import 'package:mealmate_dashboard/core/ui/theme/text_styles.dart';
import 'package:mealmate_dashboard/core/ui/widgets/main_button.dart';

Future<dynamic> showMMDeleteDialog({required BuildContext context,
  required String title,

  required Widget deleteFieldsWidget
}) async {

  showDialog(context: context, builder: (context) {
   return MMAddDialog(
     title: title,

     deleteFieldsWidget: deleteFieldsWidget,
   );
  },);


  return 1;
}

class MMAddDialog extends StatefulWidget {
  final String title;

  final Widget deleteFieldsWidget;
  const MMAddDialog({Key? key,required this.title,required this.deleteFieldsWidget}) : super(key: key);

  @override
  State<MMAddDialog> createState() => _MMAddDialogState();
}

class _MMAddDialogState extends State<MMAddDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width*0.6,
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


              widget.deleteFieldsWidget


          ],
        ),
      ),
    );
  }
}

Widget mmDeleteDialogFooter({required BuildContext context,required Function onDelete}){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      MainButton(
          text: "Cancel",
          icon: const Icon(Icons.cancel,
            color: Colors.white,
          ),
          color: Colors.grey, onPressed: (){
        Navigator.of(context).pop();
      }).expand(),

      const SizedBox(width: 16,),

      MainButton(text: "Delete",
          icon: const Icon(Icons.delete,
            color: Colors.white,
          ),
          color: Colors.red, onPressed: (){
            onDelete();
          }).expand(),
    ],
  );

}