import 'package:flutter/material.dart';
import 'package:mealmate_dashboard/core/ui/theme/colors.dart';
import 'package:mealmate_dashboard/core/ui/widgets/main_text_field.dart';
import 'package:mealmate_dashboard/core/ui/widgets/mm_data_table/mm_add_dialog.dart';
import 'package:mealmate_dashboard/core/ui/widgets/simple_label_text_field.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/index_nutritional.dart';
import 'package:mealmate_dashboard/features/store/presentation/cubit/store_cubit.dart';

class NutritionalAddFieldWidget extends StatefulWidget {
  final Function onAdd;
  const NutritionalAddFieldWidget({Key? key,required this.onAdd}) : super(key: key);

  @override
  State<NutritionalAddFieldWidget> createState() => _NutritionalAddFieldWidgetState();
}

class _NutritionalAddFieldWidgetState extends State<NutritionalAddFieldWidget> {
  late TextEditingController nameController;
  final _formKey = GlobalKey<FormState>();
  late final StoreCubit _storeCubit;



  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    _storeCubit = StoreCubit();

  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          SimpleLabelTextField(
            labelText: "Nutritional Name",
            textEditingController: nameController,
            validator: (text) {
              if (text != null && text.isNotEmpty) {
                return null;
              } else {
                return "please add a valid Name";
              }
            },
          ),




          SizedBox(height: 30,),

          mmAddDialogFooter(context: context,
              onAdd: (){
            if(_formKey.currentState!.validate())
              {
                Navigator.of(context).pop();
                widget.onAdd();
              }

              }),
        ],
      ),
    );
  }
}
