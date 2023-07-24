import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealmate_dashboard/core/constants/constants.dart';
import 'package:mealmate_dashboard/core/extensions/widget_extensions.dart';
import 'package:mealmate_dashboard/core/helper/cubit_status.dart';
import 'package:mealmate_dashboard/core/helper/file_uploader/platform_file_picker.dart';
import 'package:mealmate_dashboard/core/helper/file_uploader/upload_service.dart';
import 'package:mealmate_dashboard/core/ui/widgets/main_button.dart';
import 'package:mealmate_dashboard/core/ui/widgets/mm_data_table/mm_add_dialog.dart';
import 'package:mealmate_dashboard/core/ui/widgets/simple_drop_down_option.dart';
import 'package:mealmate_dashboard/core/ui/widgets/simple_label_text_field.dart';
import 'package:mealmate_dashboard/features/store/data/models/categories_ingredient.dart';
import 'package:mealmate_dashboard/features/store/data/models/ingredient_model.dart';
import 'package:mealmate_dashboard/features/store/data/models/unit_types_model.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/add_ingredients.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/index_categories_ingredient.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/index_nutritional.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/index_unit_types.dart';
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
  String? ingredientPriceUnit;
  int? ingredientPriceUnitId;
  String? ingredientCategoryName;
  int? ingredientCategoryId;
  bool firstCheck = false;
  TextEditingController priceController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  late final StoreCubit _storeCubitNutritional;
  final keysForms = <GlobalKey<_IngredientNutritionalWidgetState>>[];

  bool isRefresh = false;
   @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    _storeCubit = StoreCubit();
    _storeCubitNutritional = StoreCubit()..getNutritionalAndUnitsAndCategories(
      paramsNutritional: IndexNutritionalParams(),
      paramsCategoriesIngredient: IndexCategoriesIngredientParams(),
      paramsUnits: IndexUnitTypesParams()
    );

  }

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<StoreCubit, StoreState>(
      bloc: _storeCubitNutritional,
      builder: (BuildContext context, StoreState state) {
        return switch (state.status) {
        CubitStatus.loading => const CircularProgressIndicator.adaptive().center(),
        CubitStatus.success =>
        addFormWidget(categories: state.categories,nutritional: state.nutritional, unitTypes: state.unitTypes),
        _ => Text('error'.tr()).center(),
      };
      },
    ).center();

  }


  Widget addFormWidget({required List<Nutritional> nutritional, required List<UnitTypesModel> unitTypes, required List<CategoriesIngredientModel> categories, }){
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(
            padding: const EdgeInsets.only(top: 16,
                right: 6,left: 6),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  color: Colors.black.withOpacity(0.2)
              ),
              padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 16),
              child: Column(
                children: [
                  Transform.translate(
                      offset: Offset(0,-10),
                      child: Text("Ingredient Details".tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16
                        ),
                      ).center()),
                  Flex(
                    direction: Axis.horizontal,
                    children: [

                      Flexible(
                        fit: FlexFit.tight,
                        flex: 5,
                        child: SimpleLabelTextField(
                          labelText: "Ingredient Name".tr(),
                          textEditingController: nameController,
                          validator: (text) {
                            if (text != null && text.isNotEmpty) {
                              return null;
                            } else {
                              return "please add a valid Name".tr();
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 16),

                      Flexible(
                        flex: 5,
                        fit: FlexFit.tight,
                        child: SimpleDropDownOption(
                          onSelected: (value){
                            ingredientCategoryName = value;
                            ingredientCategoryId = categories.firstWhere((element) => element.name == ingredientCategoryName).id;
                            setState(() {

                            });
                          },
                          selectedItem: ingredientCategoryName,
                          itemsOptions: categories.map((e) => e.name.toString()).toList(),
                          title: "Ingredient Category".tr(),
                          hint: "Select one...".tr(),
                        ),
                      ),


                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16,),

          Padding(
            padding: const EdgeInsets.only(top: 16,
                right: 6,left: 6),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                color: Colors.black.withOpacity(0.2)
              ),
              padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 16),
              child: Column(
                children: [
                  Transform.translate(
                      offset: Offset(0,-10),
                      child: Text("Price Details".tr(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16
                      ),
                      ).center()),
                  Flex(
                    direction: Axis.horizontal,
                    children: [

                      Flexible(
                        fit: FlexFit.tight,
                        flex: 3,
                        child: SimpleLabelTextField(
                          labelText: "Ingredient Price".tr(),
                          textEditingController: priceController,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                          ],

                          validator: (text) {
                            if (text != null && text.isNotEmpty) {
                              return null;
                            } else {
                              return "please add a valid Price".tr();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16,),
                  Flex(
                    direction: Axis.horizontal,
                    children: [

                      Flexible(
                        fit: FlexFit.tight,
                        flex: 5,
                        child: SimpleLabelTextField(
                          labelText: "Weight per Price".tr(),
                          textEditingController: valueController,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                          ],
                          validator: (text) {
                            if (text != null && text.isNotEmpty) {
                              return null;
                            } else {
                              return "please add a valid Weight".tr();
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 16),

                      Flexible(
                        flex: 5,
                        fit: FlexFit.tight,
                        child: SimpleDropDownOption(
                          onSelected: (value){
                            ingredientPriceUnit = value;
                            ingredientPriceUnitId = unitTypes.firstWhere((element) => element.name == ingredientPriceUnit).id;
                            setState(() {

                            });
                          },
                          selectedItem: ingredientPriceUnit,
                          itemsOptions: unitTypes.map((e) => e.name.toString()).toList(),
                          title: "Unit Type".tr(),
                          hint: "Select one...".tr(),
                        ),
                      ),


                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16,),

          Padding(
            padding: const EdgeInsets.only(top: 16,
                right: 6,left: 6),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  color: Colors.black.withOpacity(0.2)
              ),
              padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 16),
              child: Column(
                children: [
                  Transform.translate(
                      offset: Offset(0,-10),
                      child: Text("Ingredient Image".tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16
                        ),
                      ).center()),

                  Row(
                    mainAxisAlignment: imageForIngredient==null?MainAxisAlignment.center:MainAxisAlignment.spaceBetween,
                    children: [
                      MainButton(
                          text: imageForIngredient!=null?"Change Image for ingredient".tr():"Pick an Image for ingredient".tr(),
                          icon: const Icon(Icons.camera,
                            color: Colors.white,
                          ),
                          color:firstCheck && imageForIngredient==null?Colors.red : Colors.grey, onPressed: () async {

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
                ],
              ),
            ),
          ),




          const SizedBox(height: 16,),

          Padding(
            padding: const EdgeInsets.only(top: 16,
                right: 6,left: 6),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  color: Colors.black.withOpacity(0.2)
              ),
              padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 16),
              child: Column(
                children: [
                  Transform.translate(
                      offset: Offset(0,-10),
                      child: Text("Ingredient Nutritional".tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16
                        ),
                      ).center()),




                  Visibility(
                    visible: !isRefresh,
                    replacement: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: const CircularProgressIndicator.adaptive().center(),
                    ),
                    child: ListView.builder(
                      itemCount: keysForms.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return IngredientNutritionalWidget(
                          key: keysForms[index],
                          index: index,
                          nutritional: nutritional,
                          unitTypes: unitTypes,
                          onRemove: (index) async {
                            setState(() {
                              keysForms.removeAt(index);
                            });
                          },
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 16,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [



                      FloatingActionButton(
                          child: const Icon(Icons.add,
                            color: Colors.white,
                          ),
                          backgroundColor:  Colors.cyan,
                          onPressed: (){
                            keysForms.add(GlobalKey<_IngredientNutritionalWidgetState>());
                            setState(() {

                            });
                          })
                    ],
                  ),
                ],
              ),
            ),
          ),



          const SizedBox(height: 30,),

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
                CubitStatus.failure => Text('error'.tr()).center(),

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

  void _onAdd(){
    firstCheck = true;
    bool nutritional =keysForms.where((element) => element.currentState!.formKey.currentState!.validate()).length == keysForms.length;
    bool fromFields =  _formKey.currentState!.validate();
    bool image = imageForIngredient!=null;
    if(nutritional && fromFields && image)
    {

      _storeCubit.addIngredients(AddIngredientsParams(
        name: nameController.text,
        price: double.parse(priceController.text),
        priceBy: double.parse(valueController.text),
        priceUnitId: ingredientPriceUnitId!,
        categoryId: ingredientCategoryId!,
        imageUrl: imageForIngredient!,
        ingredientNutritionals: [
          ...keysForms.map((e) {
            var nutritionalId = e.currentState!.ingredientNutritionalId;
            var unitId = e.currentState!.ingredientUnitId;
            var value = double.parse(e.currentState!.valueController.text);
            var percent = double.parse(e.currentState!.percentController.text);
             return IngredientNutritionals(
               id: nutritionalId,
               unitId: unitId,
               value: value,
               percent: percent
            );
          } )
        ],
      ));
    }

  }

}

 
 class IngredientNutritionalWidget extends StatefulWidget {
  final int index;
  final Function onRemove;
  final List<Nutritional> nutritional;
  final List<UnitTypesModel> unitTypes;

   const IngredientNutritionalWidget({Key? key,
     required  this.nutritional, required  this.unitTypes,
     required this.index,required this.onRemove}) : super(key: key);
 
   @override
   State<IngredientNutritionalWidget> createState() => _IngredientNutritionalWidgetState();
 }
 
 class _IngredientNutritionalWidgetState extends State<IngredientNutritionalWidget> {
   String? ingredientNutritional;
   int? ingredientNutritionalId;
   String? ingredientUnit;
   int? ingredientUnitId;
  TextEditingController percentController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  final formKey = GlobalKey<FormState>();

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  
   @override
   Widget build(BuildContext context) {
     return Form(
       key: formKey,
       child: Padding(
         padding: const EdgeInsets.symmetric(vertical: 4),
         child: Stack(
           alignment: Alignment.center,
           children: [
             Padding(
               padding: const EdgeInsets.only(top: 16,
               right: 6,left: 6),
               child: Container(
                 decoration: BoxDecoration(
                   border: Border.all(color: Colors.white),
                   borderRadius: const BorderRadius.all(Radius.circular(16))
                 ),
                 padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 16),
                 child: Column(
                   children: [
                     Flex(
                       direction: Axis.horizontal,
                       children: [
                         Flexible(
                           flex: 5,
                           fit: FlexFit.tight,
                           child: SimpleDropDownOption(
                             onSelected: (value){
                               ingredientNutritional = value;
                               ingredientNutritionalId = widget.nutritional.firstWhere((element) => element.name == ingredientNutritional).id;
                               setState(() {});
                             },
                             selectedItem: ingredientNutritional,
                             itemsOptions: widget.nutritional.map((e) => e.name.toString()).toList(),
                             title: "Ingredient Nutritionals".tr(),
                             hint: "Select one...".tr(),
                           ),
                         ),
                         SizedBox(width: 16),
                         Flexible(
                           fit: FlexFit.tight,
                           flex: 3,
                           child: SimpleLabelTextField(
                             labelText: "Nutritional Percent".tr(),
                             textEditingController: percentController,
                             inputFormatters: [
                               FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                             ],
                             onFinish: (){

                             },
                             validator: (text) {
                               if (text != null && text.isNotEmpty) {
                                 return null;
                               } else {
                                 return "please add a valid Nutritional Percent".tr();
                               }
                             },
                           ),
                         ),
                       ],
                     ),
                     const SizedBox(height: 16,),
                     Flex(
                       direction: Axis.horizontal,
                       children: [

                         Flexible(
                           fit: FlexFit.tight,
                           flex: 5,
                           child: SimpleLabelTextField(
                             labelText: "Weight per unit".tr(),
                             textEditingController: valueController,
                             inputFormatters: [
                               FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                             ],
                             validator: (text) {
                               if (text != null && text.isNotEmpty) {
                                 return null;
                               } else {
                                 return "please add a valid Weight".tr();
                               }
                             },
                           ),
                         ),
                         SizedBox(width: 16),

                         Flexible(
                           flex: 5,
                           fit: FlexFit.tight,
                           child: SimpleDropDownOption(
                             onSelected: (value){
                               ingredientUnit = value;
                               ingredientUnitId = widget.unitTypes.firstWhere((element) => element.name == ingredientUnit).id;
                               setState(() {

                               });
                             },
                             selectedItem: ingredientUnit,
                             itemsOptions: widget.unitTypes.map((e) => e.name.toString()).toList(),
                             title: "Unit Type".tr(),
                             hint: "Select one...".tr(),
                           ),
                         ),


                       ],
                     ),
                   ],
                 ),
               ),
             ),
             Positioned(
                 top: 0,
                 right: 0,
                 child: Container(
                     decoration: const BoxDecoration(
                         shape: BoxShape.circle,
                         color: Colors.white
                     ),
                     child: GestureDetector(
                       onTap: (){
                         widget.onRemove(widget.index);
                       },
                       child: const Padding(
                         padding: EdgeInsets.all(4.0),
                         child: Icon(Icons.delete,color: Colors.red,size: 24,),
                       ),
                     ))),
             Positioned(
                 top: 0,
                 child: Container(
                     decoration: BoxDecoration(
                         shape: BoxShape.circle,
                         color: primaryColor
                     ),
                     child: GestureDetector(
                       onTap: (){
                         widget.onRemove(widget.index);
                       },
                       child: Padding(
                         padding: EdgeInsets.all(8.0),
                       child:  Text((widget.index+1).toString(),
                       style: TextStyle(color: Colors.white,fontSize: 16),
                       ),
                       ),
                     ))),

           ],
         ),
       ),
     );
   }
 }
 