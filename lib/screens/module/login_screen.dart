import 'package:ecommerce_training/core/controllers/login_cubit/login_cubit.dart';
import 'package:ecommerce_training/core/managers/nav.dart';
import 'package:ecommerce_training/core/managers/show_snakbar.dart';
import 'package:ecommerce_training/screens/module/homeScreen.dart';
import 'package:ecommerce_training/screens/module/register_screen.dart';
import 'package:ecommerce_training/screens/widgets/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../core/managers/colors.dart';
import '../../core/managers/values.dart';
import '../../core/network/local/cache_helper.dart';
import '../widgets/error_page.dart';
import '../widgets/text_form.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var cubit = LoginCubit.get(context);
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginDoneState) {
          if (state.userModel.status == "success") {
            ShowSnakbar(context, state.userModel.message!);
            CacheHelper.saveData(
                    key: 'userId', value: state.userModel.user!.nationalId)
                .then((value) {
              natoinalId = state.userModel.user!.nationalId;
            });
            CacheHelper.saveData(
              key: 'token',
              value: state.userModel.user!.token,
            ).then((value) {
              token = state.userModel.user!.token!;
              navigateAndFinishThisScreen(
                context,
                const HomeScreen(),
              );
            });
          } else {
            ShowSnakbar(context, state.userModel.message!);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Form(
            key: formKey,
            child: state is LoginLoadingState
                ? const LoadingWidget()
                : Container(
                    margin: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _header(context),
                        _inputField(context, cubit),
                        _signup(context),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }

  _header(context) {
    return const Column(
      children: [
        Text(
          "Login",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 15,),
        Text("Enter your credential to login"),
      ],
    );
  }

  _inputField(context, var cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DefaultFieldForm(
          labelStyle: const TextStyle(color: Colors.black),
          controller: emailController,
          keyboard: TextInputType.emailAddress,
          valid: (value) {
            if (value.isEmpty) {
              return 'Please Enter your Email';
            }
            return null;
          },
          label: 'Email Address',
          prefix: Icons.email,
          hint: 'Email Address',
          hintStyle: const TextStyle(color: Colors.grey),
          show: false,
        ),
        const SizedBox(height: 10),
        DefaultFieldForm(
          labelStyle: const TextStyle(color: Colors.black),
          controller: passwordController,
          keyboard: TextInputType.visiblePassword,
          valid: (value) {
            if (value.isEmpty) {
              return 'Please Enter Your Password';
            }
            return null;
          },
          label: 'Password',
          prefix: Icons.password,
          hint: 'Password',
          hintStyle: const TextStyle(color: Colors.grey),
          show: false,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              if (!emailController.text.contains('@')) {
                ShowSnakbar(context, 'please sure email contain @gmail.com');
              } else if (passwordController.text.length < 8) {
                ShowSnakbar(context, 'please sure password at last 8');
              } else {
                try {
                  cubit.userLogin(
                    email: emailController.text,
                    password: passwordController.text,
                  );
                } on Exception catch (e) {
                  ShowSnakbar(context,e.toString());
                }
              }
            }
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: AppColors.primaryColor,
          ),
          child: const Text(
            "Login",
            style: TextStyle(fontSize: 20),
          ),
        )
      ],
    );
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Do not have an account? "),
        TextButton(
            onPressed: () {
              navigateAndFinishThisScreen(context, RegisterScreen());
            },
            child: const Text(
              "Sign Up",
              style: TextStyle(color: AppColors.primaryColor,),
            ))
      ],
    );
  }
}
