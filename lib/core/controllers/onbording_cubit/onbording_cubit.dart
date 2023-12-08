import 'package:bloc/bloc.dart';
import 'package:ecommerce_training/core/controllers/onbording_cubit/onbording_states.dart';
import 'package:ecommerce_training/core/managers/nav.dart';
import 'package:ecommerce_training/core/network/local/cache_helper.dart';
import 'package:ecommerce_training/screens/module/register_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnBoardingCubit extends Cubit<OnBoardingStates>{
  OnBoardingCubit():super(OnBoardingInitialState());
  static OnBoardingCubit get(context)=>BlocProvider.of(context);
  bool isLastPage=false;
  int screenIndex=0;
  pageLast(index){
    isLastPage=true;
    screenIndex=index;
    emit(LastPageState());
  }
  pageNotLast(index){
    isLastPage=false;
    screenIndex=index;
    emit(NoLastPageState());
  }
  onSubmit(context){
    CacheHelper.saveData(key: 'Boarding', value: true);
    navigateToNextScreen(context, RegisterScreen());
  }


}