import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealmate_dashboard/core/extensions/context_extensions.dart';
import 'package:mealmate_dashboard/core/extensions/validation_extensions.dart';
import 'package:mealmate_dashboard/core/extensions/widget_extensions.dart';
import 'package:mealmate_dashboard/core/helper/app_config.dart';
import 'package:mealmate_dashboard/core/helper/helper_functions.dart';
import 'package:mealmate_dashboard/core/helper/responsive.dart';
import 'package:mealmate_dashboard/core/ui/theme/colors.dart';
import 'package:mealmate_dashboard/core/ui/widgets/loading_widget.dart';
import 'package:mealmate_dashboard/core/ui/widgets/main_app_bar.dart';
import 'package:mealmate_dashboard/core/ui/widgets/main_button.dart';
import 'package:mealmate_dashboard/features/auth/domain/usecases/login_usecase.dart';
import 'package:mealmate_dashboard/features/auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:mealmate_dashboard/features/auth/presentation/pages/auth_page.dart';
import 'package:mealmate_dashboard/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:mealmate_dashboard/features/home/views/main/main_screen.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _userNameController;
  late final TextEditingController _passwordController;
  late final ValueNotifier<bool> _rememberMe;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _userNameController = TextEditingController();
    _passwordController = TextEditingController();
    _rememberMe = ValueNotifier(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: BlocProvider(
        create: (context) => AuthCubit(),
        child: Builder(
          builder: (context) {
            return BlocConsumer<AuthCubit, AuthState>(
              listener: _listener,
              builder: (BuildContext context, AuthState state) {
                return Form(
                  key: _formKey,
                  child: ListView(
                    shrinkWrap: true ,

                    children: [
                      const SizedBox(height: 80,),

                      Image.asset('assets/images/intro3.png',
                        alignment: Alignment.center,
                        fit: BoxFit.contain,
                        width: 300,
                        height: 300,
                      ).padding(const EdgeInsets.all(20)),

                      Column(
                        children: [
                          const SizedBox(height: 20,),
                          AuthTextField(
                            label: "user_name".tr(),
                            icon: Icons.person,
                            hint: "please_enter_user_name".tr(),
                            controller: _userNameController,
                            validator: (text) {
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          AuthTextField(
                            label: "password".tr(),
                            hint: '********',
                            icon: Icons.lock,
                            isPassword: true,
                            controller: _passwordController,
                            validator: (text) {
                              if (text != null && text.isValidPassword()) {
                                return null;
                              } else {
                                return "Enter a Valid password";
                              }
                            },
                          ),
                          // const SizedBox(height: 20),
                          // Row(
                          //   children: [
                          //     ValueListenableBuilder<bool>(
                          //       valueListenable: _rememberMe,
                          //       builder: (context, save, _) {
                          //         return Checkbox(
                          //           value: save,
                          //           activeColor: AppColors.mainColor,
                          //           onChanged: (value) {
                          //             _rememberMe.value = value!;
                          //           },
                          //         );
                          //       },
                          //     ),
                          //     Text("stay_logged_in".tr()),
                          //   ],
                          // ),
                          const SizedBox(height: 40),

                          if(state.status == AuthStatus.loading)
                            const LoadingWidget(),

                          if(state.status != AuthStatus.loading)
                            MainButton(
                            text: "login".tr(),
                            color: AppColors.mainColor,
                            width: context.width,
                            onPressed: () {
                              BlocProvider.of<AuthCubit>(context).login(LoginUserParams(
                                email: _userNameController.text,
                                password: _passwordController.text
                              ));
                            },
                          ),

                          if(state.status == AuthStatus.failed)
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text("Error in login"),
                            )
                        ],
                      ).paddingHorizontal(
                        Responsive.isMobile(context)?8:MediaQuery.of(context).size.width*0.25
                      ),


                    ],
                  ),
                );
              },
            );
          }
        ),
      ).padding(AppConfig.pagePadding).scrollable(),
    );
  }

  Future<void> _listener(BuildContext context, AuthState state) async {
    if (state.status == AuthStatus.success) {
      var user = state.user;
      await HelperFunctions.setToken(user!.tokenInfo!.token!);
      await HelperFunctions.setUser(user);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
        return AuthPage();
      },));
    }
  }
}
