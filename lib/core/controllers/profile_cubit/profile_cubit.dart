import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../models/user_model.dart';
import '../../managers/values.dart';
import '../../network/constant.dart';
import '../../network/remote/dio_helper.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitState());

  static ProfileCubit get(context) => BlocProvider.of(context);
  UserModel? profileModel;
  void getUserData(){
    emit(LoadingProfile());
    DioHelperStore.postData(url:ApiConstants.userProfileApi, data:{
      "token": token
    }).then((value){
      profileModel= UserModel.fromJson(value.data);
      print(profileModel!.user!.email);
      emit(GetUserData());
    }).catchError((error){
      print(error.toString());
      emit(ErrorGetUserData());
    });
  }
}
