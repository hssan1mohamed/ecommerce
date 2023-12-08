import 'package:ecommerce_training/models/user_model.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterDoneState extends RegisterStates {
  final UserModel userModel;
  RegisterDoneState({required this.userModel});
}

class RegisterErrorState extends RegisterStates {

}

class ChoseImage extends RegisterStates {}
