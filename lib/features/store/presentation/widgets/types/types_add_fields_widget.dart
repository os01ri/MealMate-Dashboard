import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealmate_dashboard/core/constants/constants.dart';
import 'package:mealmate_dashboard/core/extensions/widget_extensions.dart';
import 'package:mealmate_dashboard/core/helper/cubit_status.dart';
import 'package:mealmate_dashboard/core/helper/file_uploader/platform_file_picker.dart';
import 'package:mealmate_dashboard/core/helper/file_uploader/upload_service.dart';
import 'package:mealmate_dashboard/core/helper/helper_functions.dart';
import 'package:mealmate_dashboard/core/ui/theme/colors.dart';
import 'package:mealmate_dashboard/core/ui/theme/text_styles.dart';
import 'package:mealmate_dashboard/core/ui/widgets/main_button.dart';
import 'package:mealmate_dashboard/core/ui/widgets/main_text_field.dart';
import 'package:mealmate_dashboard/core/ui/widgets/mm_data_table/mm_add_dialog.dart';
import 'package:mealmate_dashboard/core/ui/widgets/mm_data_table/mm_update_dialog.dart';
import 'package:mealmate_dashboard/core/ui/widgets/simple_drop_down_option.dart';
import 'package:mealmate_dashboard/core/ui/widgets/simple_label_text_field.dart';
import 'package:mealmate_dashboard/features/store/data/models/categories_ingredient.dart';
import 'package:mealmate_dashboard/features/store/data/models/ingredient_model.dart';
import 'package:mealmate_dashboard/features/store/data/models/types_model.dart';
import 'package:mealmate_dashboard/features/store/data/models/unit_types_model.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/add_categories.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/add_categories_types.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/add_ingredients.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/add_nutritional.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/add_types.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/index_categories_ingredient.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/index_nutritional.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/index_unit_types.dart';
import 'package:mealmate_dashboard/features/store/presentation/cubit/store_cubit.dart';

class TypesAddFieldWidget extends StatefulWidget {
  final Function onAddFinish;
  final bool isAdd;
  final TypesModel? typesModel;
  const TypesAddFieldWidget({Key? key,required this.onAddFinish,this.isAdd=true,this.typesModel}) : super(key: key);

  @override
  State<TypesAddFieldWidget> createState() => _TypesAddFieldWidgetState();
}

class _TypesAddFieldWidgetState extends State<TypesAddFieldWidget> {
  late TextEditingController nameController;
  final _formKey = GlobalKey<FormState>();
  late final StoreCubit _storeCubit;
  String? imageForCategory;

 bool firstCheck = false;
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    _storeCubit = StoreCubit();

    if(!widget.isAdd)
      {
        nameController = TextEditingController(text: widget.typesModel!.name);
        imageForCategory = widget.typesModel!.url;
      }
  }

  @override
  Widget build(BuildContext context) {
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
                      child: Text("Type Details".tr(),
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
                          labelText: "Type Name".tr(),
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
                      child: Text("Type Image".tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16
                        ),
                      ).center()),

                  Row(
                    mainAxisAlignment: imageForCategory==null?MainAxisAlignment.center:MainAxisAlignment.spaceBetween,
                    children: [
                      MainButton(
                          text: imageForCategory!=null?"Change Image for Type".tr():"Pick an Image for Type".tr(),
                          icon: const Icon(Icons.camera,
                            color: Colors.white,
                          ),
                          color:firstCheck && imageForCategory==null?Colors.red : Colors.grey, onPressed: () async {

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
                                    imageForCategory = data["data"][0]["url"].toString();
                                  });
                                },
                                failed: (f){
                                  print(f);
                                }
                            );
                          }
                        });

                      }).center(),

                      if(imageForCategory!=null)
                        Image.network(imageForCategory!,height: 50,),
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
    bool fromFields =  _formKey.currentState!.validate();
    bool image = imageForCategory!=null;
    if(fromFields && image)
    {

      // _storeCubit.addTypes(AddTypesParams(
      //   name: nameController.text,
      //   imageUrl: imageForCategory!,
      // ));
    }

  }


  void _onAdd(){
    firstCheck = true;
    bool fromFields =  _formKey.currentState!.validate();
    bool image = imageForCategory!=null;
    if(fromFields && image)
    {

      _storeCubit.addTypes(AddTypesParams(
        name: nameController.text,
        imageUrl: imageForCategory!,
      ));
    }

  }

}

