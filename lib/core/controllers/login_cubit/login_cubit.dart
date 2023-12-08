import 'package:bloc/bloc.dart';
import 'package:ecommerce_training/core/network/constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../models/user_model.dart';
import '../../network/remote/dio_helper.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;


  void userLogin({required email, required password}) {

    emit(LoginLoadingState());

    try {
       DioHelperStore.postData(
          url: ApiConstants.loginApi,
          data: {'email': email, 'password': password}).then((value) {
        userModel = UserModel.fromJson(value.data);
        emit(LoginDoneState(userModel: userModel!));
        print(userModel!.user);
      });
    } on Exception catch (e) {
      print(e);
      emit(LoginErrorState());
    }
  }
}
