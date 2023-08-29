import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealmate_dashboard/core/extensions/widget_extensions.dart';
import 'package:mealmate_dashboard/core/helper/app_config.dart';
import 'package:mealmate_dashboard/core/helper/cubit_status.dart';
import 'package:mealmate_dashboard/core/ui/widgets/error_widget.dart';
import 'package:mealmate_dashboard/core/ui/widgets/main_button.dart';
import 'package:mealmate_dashboard/core/ui/widgets/mm_data_table/mm_add_dialog.dart';
import 'package:mealmate_dashboard/core/ui/widgets/mm_data_table/mm_data_table.dart';
import 'package:mealmate_dashboard/core/ui/widgets/mm_data_table/mm_data_table_column_type.dart';
import 'package:mealmate_dashboard/core/ui/widgets/mm_data_table/mm_data_teble_enums.dart';
import 'package:mealmate_dashboard/core/ui/widgets/mm_data_table/mm_delete_dialog.dart';
import 'package:mealmate_dashboard/core/ui/widgets/mm_data_table/mm_update_dialog.dart';
import 'package:mealmate_dashboard/core/ui/widgets/simple_label_text_field.dart';
import 'package:mealmate_dashboard/features/store/data/models/categories_ingredient.dart';
import 'package:mealmate_dashboard/features/store/data/models/categories_model.dart';
import 'package:mealmate_dashboard/features/store/data/models/ingredient_model.dart';
import 'package:mealmate_dashboard/features/store/data/models/types_model.dart';
import 'package:mealmate_dashboard/features/store/data/models/unit_types_model.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/index_categories.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/index_categories_ingredient.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/index_ingredients.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/index_nutritional.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/index_types.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/index_unit_types.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/sned_notification.dart';
import 'package:mealmate_dashboard/features/store/presentation/cubit/store_cubit.dart';
import 'package:mealmate_dashboard/features/store/presentation/widgets/categories_ingredients/categories_ingredients_add_fields_widget.dart';
import 'package:mealmate_dashboard/features/store/presentation/widgets/categories_ingredients/categories_ingredients_delete_fields_widget.dart';
import 'package:mealmate_dashboard/features/store/presentation/widgets/nutritional/nutritional_add_fields_widget.dart';
import 'package:mealmate_dashboard/features/store/presentation/widgets/nutritional/nutritional_delete_fields_widget.dart';
import 'package:mealmate_dashboard/features/store/presentation/widgets/types/types_add_fields_widget.dart';
import 'package:mealmate_dashboard/features/store/presentation/widgets/types/types_delete_fields_widget.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  late final StoreCubit _storeCubit;
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _storeCubit = StoreCubit();
  }



  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: BlocProvider(
        create: (context) => _storeCubit,
        child: Scaffold(
          body: Column(
            children: [
              BlocBuilder<StoreCubit, StoreState>(
                bloc: _storeCubit,
                builder: (BuildContext context, StoreState state) {
                  return switch (state.status) {
                  CubitStatus.loading => const CircularProgressIndicator.adaptive().center(),
                  CubitStatus.failure => MainErrorWidget(
                  onTap: (){
                  onSend();
                  },
                  size: const Size(400,200),
                  ).center(),
                  CubitStatus.success => notificationForm(true),
                  _ => notificationForm(false),
                };
                },
              ).expand(),
            ],
          ).padding(AppConfig.pagePadding),
        ),
      ),
    );
  }

  Widget notificationForm(bool success){


    return ListView(
      children: [
        if(success)
          Row(
            children: [
              Container(
                width: 500,
                decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.5),
                    border: Border.all(
                    color: Colors.green
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(16))
                ),
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                child:  Row(
                  children: [

                    Icon(Icons.check_circle,color: Colors.white,size: 30,),
                    SizedBox(width: 10,),
                    Text("Notification Sent Successfully".tr(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        SizedBox(height: 20,),

        SimpleLabelTextField(
          labelText: "Title".tr(),
          textEditingController: titleController,
          validator: (text) {
            if (text != null && text.isNotEmpty) {
              return null;
            } else {
              return "please add a valid Title".tr();
            }
          },
        ),

        SizedBox(height: 20,),
        SimpleLabelTextField(
          labelText: "Body".tr(),
          isMultiLine: true,
          textEditingController: bodyController,
          validator: (text) {
            if (text != null && text.isNotEmpty) {
              return null;
            } else {
              return "please add a valid Body".tr();
            }
          },
        ),

        SizedBox(height: 40,),

        MainButton(text: "Send".tr(),
            icon: const Icon(Icons.send,
              color: Colors.white,
            ),
            color: Colors.cyan, onPressed: (){
              onSend();
            }),

      ],
    );
  }

  onSend(){

    bool fromFields =  _formKey.currentState!.validate();

    if(fromFields)
    {

      _storeCubit.sendNotification(SendNotificationParams(
        title: titleController.text,
          body: bodyController.text
      ));
    }
    setState(() {

    });
  }
}

