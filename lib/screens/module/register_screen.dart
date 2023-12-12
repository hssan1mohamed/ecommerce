import 'dart:io';
import 'package:ecommerce_training/core/controllers/register_cubit/register_cubit.dart';
import 'package:ecommerce_training/core/controllers/register_cubit/register_states.dart';
import 'package:ecommerce_training/core/managers/colors.dart';
import 'package:ecommerce_training/core/managers/textStyle.dart';
import 'package:ecommerce_training/screens/module/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/managers/nav.dart';
import '../../core/managers/show_snakbar.dart';
import '../../core/managers/values.dart';
import '../../core/network/local/cache_helper.dart';
import '../widgets/loading_page.dart';
import '../widgets/text_form.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var nationalController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var cubit = RegisterCubit.get(context);
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is RegisterDoneState) {
          if (state.userModel.status == "success") {
            ShowSnakbar(context,state.userModel.message!);
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
            ShowSnakbar(context,state.userModel.message! );
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Form(
                  key: formKey,
                  child: state is RegisterLoadingState
                      ? const LoadingWidget()
                      : Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        height: MediaQuery.of(context).size.height - 50,
                        width: double.infinity,
                        child: SingleChildScrollView(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                const SizedBox(height: 60.0),
                              const  Column(
                                  children: [
                                     Text(
                                      "Sign up",
                                      style: textStyleH1,),
                                     SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Create your account",
                                      style: textStyleH2,
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 50, left: 50 ,top: 15,bottom: 15),
                                  child: cubit.image == null
                                      ? ImageWidget(cubit: cubit)
                                      : ImageWidget(
                                          cubit: cubit,
                                          image1: cubit.image,
                                        ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                DefaultFieldForm(
                                  controller: nameController,
                                  keyboard: TextInputType.text,
                                  valid: (value) {
                                    if (value.isEmpty) {
                                      return 'Please Enter Your Name';
                                    }
                                    return null;
                                  },
                                  labelStyle:
                                  const TextStyle(color: Colors.black),
                                  label: 'Full Name',
                                  prefix: Icons.person,
                                  hint: 'Full Name',
                                  hintStyle:
                                  const TextStyle(color: Colors.grey),
                                  show: false,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                DefaultFieldForm(
                                  labelStyle:
                                  const TextStyle(color: Colors.black),
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
                                  hintStyle:
                                  const TextStyle(color: Colors.grey),
                                  show: false,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                DefaultFieldForm(
                                  labelStyle:
                                  TextStyle(color: Colors.black),
                                  controller: phoneController,
                                  keyboard: TextInputType.phone,
                                  label: 'Phone',
                                  valid: (value) {
                                    if (value.isEmpty) {
                                      return 'Please Enter Your Phone';
                                    }
                                    return null;
                                  },
                                  prefix: Icons.phone,
                                  hint: 'Phone',
                                  hintStyle:
                                  const TextStyle(color: Colors.grey),
                                  show: false,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                DefaultFieldForm(
                                  labelStyle:
                                  const TextStyle(color: Colors.black),
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
                                  hintStyle:
                                  const TextStyle(color: Colors.grey),
                                  show: false,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                DefaultFieldForm(
                                  labelStyle:
                                  const TextStyle(color: Colors.black),
                                  controller: nationalController,
                                  keyboard: TextInputType.number,
                                  label: 'National ID',
                                  valid: (value) {
                                    if (value.isEmpty) {
                                      return 'Please Confirm Your National Id';
                                    }
                                    return null;
                                  },
                                  prefix: Icons.video_stable,
                                  hint: 'National ID',
                                  hintStyle:
                                  const TextStyle(color: Colors.grey),
                                  show: false,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    padding:
                                        const EdgeInsets.only(top: 3, left: 3),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (formKey.currentState!.validate() ) {
                                         if(!emailController.text.contains('@')||emailController.text.contains('.com')){
                                           ShowSnakbar(context,'please sure email contain @ and .com' );
                                         }else if(phoneController.text.length != 11){
                                           ShowSnakbar(context,'please sure number phone at  11 number' );
                                         }else if(passwordController.text.length < 8){
                                           ShowSnakbar(context, 'please sure password at last 8');
                                         }else if(nationalController.text.length != 14){
                                           ShowSnakbar(context,'please sure national id at  14 number' );
                                         }else if(cubit.userImage==null){
                                           ShowSnakbar(context,'please sure image profile' );
                                         } else{
                                          cubit.userRegister(
                                            email: emailController.text,
                                            name: nameController.text,
                                            phone: phoneController.text,
                                            password: passwordController.text,
                                            nationalId: nationalController.text,
                                          );}

                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: const StadiumBorder(),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16),
                                        backgroundColor: AppColors.primaryColor,
                                      ),
                                      child: const Text(
                                        "Sign up",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    )),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    const Text("Already have an account?"),
                                    TextButton(
                                        onPressed: () {
                                          navigateAndFinishThisScreen(
                                              context, LoginScreen());
                                        },
                                        child: const Text(
                                          "Login",
                                          style:
                                              TextStyle(color: AppColors.primaryColor),
                                        ))
                                  ],
                                )
                              ],
                            ),
                        ),
                      ),
                ),
        );
      },
    );
  }

}




class ImageWidget extends StatelessWidget {
 const ImageWidget({
    super.key,
    this.image1,
    required this.cubit,
  });

  final RegisterCubit cubit;
  final File? image1;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        cubit.addImage();
      },
      child: CircleAvatar(
        radius: 65,
        backgroundColor:AppColors.primaryColor,
        child: CircleAvatar(
          radius: 60,
          backgroundColor: Colors.white,
          child: ClipOval(
            child: Container(
              decoration: BoxDecoration(
                image: image1 == null
                    ?const DecorationImage(
                        image: AssetImage('assets/images/noImage.png'),
                        fit: BoxFit.cover,
                      )
                    : DecorationImage(
                        image: FileImage(image1!),
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
