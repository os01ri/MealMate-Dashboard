import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealmate_dashboard/core/constants/constants.dart';
import 'package:mealmate_dashboard/core/extensions/widget_extensions.dart';
import 'package:mealmate_dashboard/core/helper/cubit_status.dart';
import 'package:mealmate_dashboard/core/helper/file_uploader/platform_file_picker.dart';
import 'package:mealmate_dashboard/core/helper/file_uploader/upload_service.dart';
import 'package:mealmate_dashboard/core/helper/helper_functions.dart';
import 'package:mealmate_dashboard/core/ui/theme/colors.dart';
import 'package:mealmate_dashboard/core/ui/widgets/main_button.dart';
import 'package:mealmate_dashboard/core/ui/widgets/main_text_field.dart';
import 'package:mealmate_dashboard/core/ui/widgets/mm_data_table/mm_add_dialog.dart';
import 'package:mealmate_dashboard/core/ui/widgets/simple_drop_down_option.dart';
import 'package:mealmate_dashboard/core/ui/widgets/simple_label_text_field.dart';
import 'package:mealmate_dashboard/features/store/data/models/ingredient_model.dart';
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
  String? imageForIngredient;
  String? ingredientNutritional;
  late TextEditingController percentController;
  late TextEditingController valueController;
  late final StoreCubit _storeCubitNutritional;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    _storeCubit = StoreCubit();
    _storeCubitNutritional = StoreCubit()..get(IndexNutritionalParams());

  }

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<StoreCubit, StoreState>(
      bloc: _storeCubitNutritional,
      builder: (BuildContext context, StoreState state) {
        return switch (state.status) {
        CubitStatus.loading => const CircularProgressIndicator.adaptive().center(),
        CubitStatus.success =>
        addFormWidget(state.nutritional),
        _ => const Text('error').center(),
      };
      },
    ).center();

  }

  void _onAdd(){

      if(_formKey.currentState!.validate() && imageForIngredient!=null)
      {
        _storeCubit.addIngredients(AddIngredientsParams(
          name: nameController.text,
          price: 3000.0,
          priceById: 1,
          priceUnitId: 1,
          categoryId: "0b51fc18-6ea2-4a93-b0f8-1202f5341824",
          imageUrl: imageForIngredient!,
          ingredientNutritionals: [],
        ));
      }

  }
  
  Widget addFormWidget(List<Nutritional> nutritional){
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

          SizedBox(height: 30,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MainButton(
                  text: imageForIngredient!=null?"Change Image for ingredient":"Pick Image for ingredient",
                  icon: const Icon(Icons.cancel,
                    color: Colors.white,
                  ),
                  color: Colors.grey, onPressed: () async {

                PlatformFilePicker().startWebFilePicker((files) {
                  if(files.isNotEmpty)
                  {
                    UploadService.uploadFile(
                        context: context,
                        url: "http://food.programmer23.store/addimage",
                        file: files.first,
                        fileName: "image",
                        success: (data){
                          print(data);
                          setState(() {
                            imageForIngredient = data["data"][0]["url"].toString();
                          });
                        },
                        failed: (f){
                          print(f);
                        }
                    );
                  }
                });

              }).center(),

              if(imageForIngredient!=null)
                Image.network(imageForIngredient!,height: 50,),
            ],
          ),

          SizedBox(height: 30,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    color: Colors.green,

                  ),
                  child: const Text("Ingredient Nutritional",
                    style: TextStyle(
                        fontSize: 20
                    ),
                  )),

              Row(
                children: [

                  MainButton(
                      text: "Add",
                      icon: const Icon(Icons.add,
                        color: Colors.white,
                      ),
                      color: Colors.cyan, onPressed: (){

                  }),



                ],
              )
            ],
          ),

          SizedBox(height: 16,),




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
                onAdd: () {
                _onAdd();
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

 
 class IngredientNutritionalWidget extends StatefulWidget {
   const IngredientNutritionalWidget({Key? key}) : super(key: key);
 
   @override
   State<IngredientNutritionalWidget> createState() => _IngredientNutritionalWidgetState();
 }
 
 class _IngredientNutritionalWidgetState extends State<IngredientNutritionalWidget> {
  late String ingredientNutritional;
  late TextEditingController percentController;
  late TextEditingController valueController;
  
   @override
   Widget build(BuildContext context) {
     return Column(
       children: [
         Flex(
           direction: Axis.horizontal,
           children: [
             Flexible(
               flex: 5,
               fit: FlexFit.tight,
               child: SimpleDropDownOption(
                 onSelected: (value){

                 },
                 selectedItem: ingredientNutritional,
                 itemsOptions: ["adas",'asd',"dqwd","vsad"],
                 title: "Ingredient Nutritionals",
                 hint: "Select one...",
               ),
             ),
             Flexible(
               fit: FlexFit.tight,
               flex: 3,
               child: SimpleLabelTextField(
                 labelText: "Nutritional Percent",
                 textEditingController: percentController,
                 validator: (text) {
                   if (text != null && text.isNotEmpty) {
                     return null;
                   } else {
                     return "please add a valid Nutritional Percent";
                   }
                 },
               ),
             ),


           ],
         ),
         SizedBox(height: 16,),
         Flex(
           direction: Axis.horizontal,
           children: [
           
             Flexible(
               fit: FlexFit.tight,
               flex: 3,
               child: SimpleLabelTextField(
                 labelText: "Weight per unit",
                 textEditingController: valueController,
                 validator: (text) {
                   if (text != null && text.isNotEmpty) {
                     return null;
                   } else {
                     return "please add a valid Weight";
                   }
                 },
               ),
             ),

             Flexible(
               flex: 5,
               fit: FlexFit.tight,
               child: SimpleDropDownOption(
                 onSelected: (value){

                 },
                 selectedItem: ingredientNutritional,
                 itemsOptions: ["adas",'asd',"dqwd","vsad"],
                 title: "Unit Type",
                 hint: "Select one...",
               ),
             ),


           ],
         ),
       ],
     );
   }
 }
 