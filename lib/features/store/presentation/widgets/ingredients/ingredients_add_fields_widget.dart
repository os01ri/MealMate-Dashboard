import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealmate_dashboard/core/extensions/widget_extensions.dart';
import 'package:mealmate_dashboard/core/helper/cubit_status.dart';
import 'package:mealmate_dashboard/core/helper/helper_functions.dart';
import 'package:mealmate_dashboard/core/ui/theme/colors.dart';
import 'package:mealmate_dashboard/core/ui/widgets/main_button.dart';
import 'package:mealmate_dashboard/core/ui/widgets/main_text_field.dart';
import 'package:mealmate_dashboard/core/ui/widgets/mm_data_table/mm_add_dialog.dart';
import 'package:mealmate_dashboard/core/ui/widgets/simple_label_text_field.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/add_ingredients.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/add_nutritional.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/index_nutritional.dart';
import 'package:mealmate_dashboard/features/store/presentation/cubit/store_cubit.dart';

class IngredientsAddFieldWidget extends StatefulWidget {
  final Function onAddFinish;
  const IngredientsAddFieldWidget({Key? key,required this.onAddFinish}) : super(key: key);

  @override
  State<IngredientsAddFieldWidget> createState() => _IngredientsAddFieldWidgetState();
}

class _IngredientsAddFieldWidgetState extends State<IngredientsAddFieldWidget> {
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
            labelText: "Ingredient Name",
            textEditingController: nameController,
            validator: (text) {
              if (text != null && text.isNotEmpty) {
                return null;
              } else {
                return "please add a valid Name";
              }
            },
          ),


          // MainButton(
          //     text: "Pick File",
          //     icon: const Icon(Icons.cancel,
          //       color: Colors.white,
          //     ),
          //     color: Colors.grey, onPressed: () async {
          //   FilePickerResult? result = await FilePicker.platform.pickFiles();
          //
          //   if (result != null) {
          //     final fileBytes = result.files.first.bytes;
          //     final fileName = result.files.first.name;
          //
          //   } else {
          //     // User canceled the picker
          //   }
          // }),


          SizedBox(height: 30,),

          BlocListener(
            bloc: _storeCubit,
            listener: (context,StoreState state) {
              if(state.status == CubitStatus.success)
                {
                  Navigator.of(context).pop();
                  widget.onAddFinish();
                }
            },
            child: BlocBuilder<StoreCubit, StoreState>(
              bloc: _storeCubit,
              builder: (BuildContext context, StoreState state) {
                return switch (state.status) {
                CubitStatus.loading => const CircularProgressIndicator.adaptive().center(),
                CubitStatus.failure => const Text('error').center(),

                _ =>  mmAddDialogFooter(context: context,
                onAdd: (){
                if(_formKey.currentState!.validate())
                {
                _storeCubit.addIngredients(AddIngredientsParams(name: nameController.text));
                }
                }),
              };
              },
            ),
          ),

        ],
      ),
    );
  }
}
