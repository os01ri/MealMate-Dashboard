import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealmate_dashboard/core/extensions/widget_extensions.dart';
import 'package:mealmate_dashboard/core/helper/cubit_status.dart';
import 'package:mealmate_dashboard/core/ui/widgets/mm_data_table/mm_add_dialog.dart';
import 'package:mealmate_dashboard/core/ui/widgets/simple_label_text_field.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/add_nutritional.dart';
import 'package:mealmate_dashboard/features/store/presentation/cubit/store_cubit.dart';

class NutritionalAddFieldWidget extends StatefulWidget {
  final Function onAddFinish;
  const NutritionalAddFieldWidget({Key? key,required this.onAddFinish}) : super(key: key);

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
            labelText: "Nutritional Name".tr(),
            textEditingController: nameController,
            validator: (text) {
              if (text != null && text.isNotEmpty) {
                return null;
              } else {
                return "please add a valid Name".tr();
              }
            },
          ),




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
                CubitStatus.failure => Text('error'.tr()).center(),

                _ =>  mmAddDialogFooter(context: context,
                onAdd: (){
                if(_formKey.currentState!.validate())
                {
                _storeCubit.addNutritional(AddNutritionalParams(name: nameController.text));
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
