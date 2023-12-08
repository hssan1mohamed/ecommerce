import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_training/core/controllers/register_cubit/register_states.dart';
import 'package:ecommerce_training/core/managers/values.dart';
import 'package:ecommerce_training/core/network/remote/dio_helper.dart';
import 'package:ecommerce_training/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../network/constant.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;
  String errorRegister = "000000";

  void userRegister(
      {required name,
      required email,
      required phone,
      required nationalId,
      required password}) {
    emit(RegisterLoadingState());
    try {
      DioHelperStore.postData(url: ApiConstants.registerApi, data: {
        "name": name,
        "email": email,
        "phone": phone,
        "nationalId": nationalId,
        "gender": 'male',
        "password": password,
        "profileImage": userImage,
      }).then((value) {
        userModel = UserModel.fromJson(value.data);
        emit(RegisterDoneState(userModel: userModel!));
        print(userModel!.user!.name);
      }).onError((error, stackTrace) {
        print (error.toString());
       // emit(RegisterErrorState());
      });
    } on DioException catch (e) {
      emit(RegisterErrorState());
    }
  }

  ImagePicker picker = ImagePicker();
  File? image;
  Uint8List? bytes;
  String? userImage;
  Future<void> addImage() async {
    final pickeredFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickeredFile != null) {
      image = File(pickeredFile.path);
      bytes = File(image!.path).readAsBytesSync();
      userImage = base64Encode(bytes!);
      emit(ChoseImage());
    } else {
      print('No Image Selecter');
    }
  }

  void tryAgain(){
    emit(RegisterInitialState());
  }
}
