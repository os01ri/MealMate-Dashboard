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
import 'package:mealmate_dashboard/core/ui/widgets/mm_data_table/mm_update_dialog.dart';
import 'package:mealmate_dashboard/core/ui/widgets/simple_drop_down_option.dart';
import 'package:mealmate_dashboard/core/ui/widgets/simple_label_text_field.dart';
import 'package:mealmate_dashboard/features/store/data/models/categories_ingredient.dart';
import 'package:mealmate_dashboard/features/store/data/models/categories_model.dart';
import 'package:mealmate_dashboard/features/store/data/models/ingredient_model.dart';
import 'package:mealmate_dashboard/features/store/data/models/recipe_model.dart';
import 'package:mealmate_dashboard/features/store/data/models/types_model.dart';
import 'package:mealmate_dashboard/features/store/data/models/unit_types_model.dart';
import 'package:mealmate_dashboard/features/store/domain/entities/ingredient.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/add_ingredients.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/add_recipes.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/index_categories.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/index_categories_ingredient.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/index_ingredients.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/index_nutritional.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/index_types.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/index_unit_types.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/update_recipes.dart';
import 'package:mealmate_dashboard/features/store/presentation/cubit/store_cubit.dart';

class RecipesAddFieldWidget extends StatefulWidget {
  final Function onAddFinish;
  final bool isAdd;
  final RecipeModel? recipeModel;
  const RecipesAddFieldWidget({Key? key,required this.onAddFinish,this.isAdd=true,this.recipeModel}) : super(key: key);

  @override
  State<RecipesAddFieldWidget> createState() => _RecipesAddFieldWidgetState();
}

class _RecipesAddFieldWidgetState extends State<RecipesAddFieldWidget> {
  late TextEditingController nameController;
  TextEditingController descriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  late final StoreCubit _storeCubit;
  String? imageForRecipe;
  String? recipeTypeName;
  int? recipeTypeId;
  String? ingredientCategoryName;
  int? ingredientCategoryId;
  bool firstCheck = false;
  TextEditingController feedController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  late final StoreCubit _storeCubitData;
  final keysFormsIngredients = <GlobalKey<_RecipeIngredientsWidgetState>>[];
  final keysFormsSteps = <GlobalKey<_StepsWidgetState>>[];

   @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    _storeCubit = StoreCubit();
    _storeCubitData = StoreCubit()..getRecipesAndUnitsAndCategories(
      paramsCategories: IndexCategoriesParams(),
      paramsIngredients: IndexIngredientsParams(),
      paramsTypes: IndexTypesParams(),
      paramsUnitTypes: IndexUnitTypesParams()
    );

    if(!widget.isAdd)
    {
      nameController = TextEditingController(text: widget.recipeModel!.name);
      descriptionController = TextEditingController(text: widget.recipeModel!.description.toString());
      feedController = TextEditingController(text: widget.recipeModel!.feeds.toString());
      timeController = TextEditingController(text: widget.recipeModel!.time.toString());
      ingredientCategoryName = widget.recipeModel!.category!.name.toString();
      ingredientCategoryId = int.parse(widget.recipeModel!.category!.id.toString());
      recipeTypeName = widget.recipeModel!.type!.name.toString();
      recipeTypeId = int.parse(widget.recipeModel!.type!.id.toString());
      imageForRecipe = widget.recipeModel!.url;
      widget.recipeModel!.steps!.forEach((element) {
        keysFormsSteps.add(GlobalKey<_StepsWidgetState>());
      });
      widget.recipeModel!.ingredients!.forEach((element) {
        keysFormsIngredients.add(GlobalKey<_RecipeIngredientsWidgetState>());
      });
    }
   }

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<StoreCubit, StoreState>(
      bloc: _storeCubitData,
      builder: (BuildContext context, StoreState state) {
        return switch (state.status) {
        CubitStatus.loading => const CircularProgressIndicator.adaptive().center(),
        CubitStatus.success =>
        addFormWidget(ingredient: state.ingredients,types: state.types, categories: state.categories,unitTypes: state.unitTypes),
        _ => Text('error'.tr()).center(),
      };
      },
    ).center();

  }


  Widget addFormWidget({required List<IngredientModel> ingredient,required List<UnitTypesModel> unitTypes, required List<TypesModel> types, required List<CategoriesModel> categories, }){
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
                      child: Text("Recipe Details".tr(),
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
                          labelText: "Recipe Name".tr(),
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
                          title: "Recipe Category".tr(),
                          hint: "Select one...".tr(),
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
                        child:  SimpleLabelTextField(
                          labelText: "Recipe Description".tr(),
                          textEditingController: descriptionController,
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
                            recipeTypeName = value;
                            recipeTypeId = types.firstWhere((element) => element.name == recipeTypeName).id;
                            setState(() {

                            });
                          },
                          selectedItem: recipeTypeName,
                          itemsOptions: types.map((e) => e.name.toString()).toList(),
                          title: "Recipe Type".tr(),
                          hint: "Select one...".tr(),
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
                          labelText: "Estimated Time".tr(),
                          textEditingController: timeController,
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
                        fit: FlexFit.tight,
                        flex: 5,
                        child: SimpleLabelTextField(
                          labelText: "Feed (By person)".tr(),
                          textEditingController: feedController,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
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
                      child: Text("Recipe Image".tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16
                        ),
                      ).center()),

                  Row(
                    mainAxisAlignment: imageForRecipe==null?MainAxisAlignment.center:MainAxisAlignment.spaceBetween,
                    children: [
                      MainButton(
                          text: imageForRecipe!=null?"Change Image for Recipe".tr():"Pick an Image for Recipe".tr(),
                          icon: const Icon(Icons.camera,
                            color: Colors.white,
                          ),
                          color:firstCheck && imageForRecipe==null?Colors.red : Colors.grey, onPressed: () async {

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
                                    imageForRecipe = data["data"][0]["url"].toString();
                                  });
                                },
                                failed: (f){
                                  print(f);
                                }
                            );
                          }
                        });

                      }).center(),

                      if(imageForRecipe!=null)
                        Image.network(imageForRecipe!,height: 50,),
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
                      child: Text("Recipe Ingredients".tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16
                        ),
                      ).center()),




                  ListView.builder(
                    itemCount: keysFormsIngredients.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return RecipeIngredientsWidget(
                        key: keysFormsIngredients[index],
                        recipeIngredient: widget.recipeModel!=null && widget.recipeModel!.ingredients!.length > index?widget.recipeModel!.ingredients![index].recipeIngredient : null,
                        index: index,
                        ingredients: ingredient,
                        unitTypes: unitTypes,
                        onRemove: (index) async {
                          setState(() {
                            keysFormsIngredients.removeAt(index);
                          });
                        },
                      );
                    },
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
                            keysFormsIngredients.add(GlobalKey<_RecipeIngredientsWidgetState>());
                            setState(() {

                            });
                          })
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
                      child: Text("Recipe Steps".tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16
                        ),
                      ).center()),




                  ListView.builder(
                    itemCount: keysFormsSteps.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return StepsWidget(
                        key: keysFormsSteps[index],
                        step: widget.recipeModel!=null && widget.recipeModel!.steps!.length > index?widget.recipeModel!.steps![index] : null,
                        index: index,
                        onRemove: (index) async {
                          setState(() {
                            keysFormsSteps.removeAt(index);
                          });
                        },
                      );
                    },
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
                            keysFormsSteps.add(GlobalKey<_StepsWidgetState>());
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
                _ =>  getFooter()
              };
              },
            ),
          ),

        ],
      ),
    );
  }


  Widget getFooter(){
    if(widget.isAdd)
      return mmAddDialogFooter(context: context,
          onAdd: () {
            _onAdd();
          });
    else return mmUpdateDialogFooter(context: context,
        onUpdate: () {
          _onUpdate();
        });
  }

  void _onUpdate(){
    firstCheck = true;
    bool ingredients = keysFormsIngredients.where((element) => element.currentState!.formKey.currentState!.validate()).length == keysFormsIngredients.length;
    bool steps = keysFormsSteps.where((element) => element.currentState!.formKey.currentState!.validate()).length == keysFormsIngredients.length;
    bool fromFields =  _formKey.currentState!.validate();
    bool image = imageForRecipe!=null;
    if(ingredients && steps && fromFields && image)
    {

      _storeCubit.updateRecipe(UpdateRecipesParams(
          body: {
            "id": widget.recipeModel!.id,
            "name":nameController.text,
            "description":descriptionController.text,
            "feeds": feedController.text,
            "time":feedController.text,
            "url":imageForRecipe,
            "type_id":recipeTypeId,
            "category_id":ingredientCategoryId,
            "step": keysFormsSteps.map((e) =>
            {
              "name":e.currentState!.nameController.text.toString(),
              "rank":e.currentState!.widget.index.toString(),
              "description":e.currentState!.descriptionController.text.toString()
            }).toList(),
            "ingredient": keysFormsIngredients.map((e) =>  {
              "id":e.currentState!.ingredientId.toString(),
              "quantity":e.currentState!.quantityController.text.toString(),
              "unit_id":e.currentState!.ingredientUnitId.toString()
            }).toList()
          }
      ));

    }

  }

  void _onAdd(){
    firstCheck = true;
    bool ingredients = keysFormsIngredients.where((element) => element.currentState!.formKey.currentState!.validate()).length == keysFormsIngredients.length;
    bool steps = keysFormsSteps.where((element) => element.currentState!.formKey.currentState!.validate()).length == keysFormsIngredients.length;
    bool fromFields =  _formKey.currentState!.validate();
    bool image = imageForRecipe!=null;
    if(ingredients && steps && fromFields && image)
    {

      _storeCubit.addRecipe(AddRecipeParams(
          body: {
            "name":nameController.text,
            "description":descriptionController.text,
            "feeds": feedController.text,
            "time":feedController.text,
            "url":imageForRecipe,
            "type_id":recipeTypeId,
            "category_id":ingredientCategoryId,
            "step": keysFormsSteps.map((e) =>
            {
              "name":e.currentState!.nameController.text.toString(),
              "rank":e.currentState!.widget.index.toString(),
              "description":e.currentState!.descriptionController.text.toString()
            }).toList(),
            "ingredient": keysFormsIngredients.map((e) =>  {
              "id":e.currentState!.ingredientId.toString(),
              "quantity":e.currentState!.quantityController.text.toString(),
              "unit_id":e.currentState!.ingredientUnitId.toString()
            }).toList()
          }
      ));
    }

  }


}


class RecipeIngredientsWidget extends StatefulWidget {
  final int index;
  final Function onRemove;
  final List<IngredientModel> ingredients;
  final List<UnitTypesModel> unitTypes;
  final RecipeIngredient? recipeIngredient;
  const RecipeIngredientsWidget({Key? key,
    this.recipeIngredient,
    required  this.ingredients, required  this.unitTypes,
    required this.index,required this.onRemove}) : super(key: key);

  @override
  State<RecipeIngredientsWidget> createState() => _RecipeIngredientsWidgetState();
}

class _RecipeIngredientsWidgetState extends State<RecipeIngredientsWidget> {
  String? ingredientName;
  int? ingredientId;
  String? ingredientUnit;
  int? ingredientUnitId;
  TextEditingController quantityController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.recipeIngredient!=null)
      {
        ingredientId = int.parse(widget.recipeIngredient!.ingredientId.toString());
        ingredientName = widget.ingredients.firstWhere((element) => element.id == ingredientId).name;
        ingredientUnitId = int.parse(widget.recipeIngredient!.unitId.toString());
        ingredientUnit = widget.unitTypes.firstWhere((element) => element.id == ingredientUnitId).name;
        quantityController = TextEditingController(text: widget.recipeIngredient!.quantity.toString());
      }
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
                              ingredientName = value;
                              ingredientId = widget.ingredients.firstWhere((element) => element.name == ingredientName).id;
                              setState(() {});
                            },
                            selectedItem: ingredientName,
                            itemsOptions: widget.ingredients.map((e) => e.name.toString()).toList(),
                            title: "Ingredients".tr(),
                            hint: "Select one...".tr(),
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
                          flex: 3,
                          child: SimpleLabelTextField(
                            labelText: "Ingredient Quantity".tr(),
                            textEditingController: quantityController,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                            ],
                            onFinish: (){

                            },
                            validator: (text) {
                              if (text != null && text.isNotEmpty) {
                                return null;
                              } else {
                                return "please add a valid Ingredient Quantity".tr();
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


class StepsWidget extends StatefulWidget {
  final int index;
  final Function onRemove;
  final Steps? step;


  const StepsWidget({Key? key,
    this.step,
    required this.index,required this.onRemove}) : super(key: key);

  @override
  State<StepsWidget> createState() => _StepsWidgetState();
}

class _StepsWidgetState extends State<StepsWidget> {

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.step!=null)
      {
        nameController = TextEditingController(text: widget.step!.name.toString());
        descriptionController = TextEditingController(text: widget.step!.description.toString());
      }
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
                          fit: FlexFit.tight,
                          flex: 3,
                          child: SimpleLabelTextField(
                            labelText: "Step Name".tr(),
                            textEditingController: nameController,

                            onFinish: (){

                            },
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
                          fit: FlexFit.tight,
                          flex: 3,
                          child: SimpleLabelTextField(
                            labelText: "Step Description".tr(),
                            textEditingController: descriptionController,
                            inputFormatters: [
                            ],
                            onFinish: (){

                            },
                            validator: (text) {
                              if (text != null && text.isNotEmpty) {
                                return null;
                              } else {
                                return "please add a valid Description".tr();
                              }
                            },
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
