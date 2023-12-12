import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../models/cart_model.dart';
import '../../../models/favourite_model.dart';
import '../../managers/values.dart';
import '../../network/constant.dart';
import '../../network/remote/dio_helper.dart';
part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteInitial());
  static FavouriteCubit get(context) => BlocProvider.of(context);
  void addToFavourite(productId) {
    emit(AddToFavouriteLoading());
    DioHelperStore.postData(url: ApiConstants.favouriteApi, data: {
      "nationalId": natoinalId,
      "productId": productId,
    }).then((value) {
      emit(AddToFavourite());
      getFavourite();
    }).catchError((error) {
      print(error.toString());
      emit(ErrorAddToFavourite());
    });
  }

  FavouriteModel ? favouriteModel;
  void getFavourite() {
    DioHelperStore.getData(url: ApiConstants.favouriteApi, data: {
      "nationalId": natoinalId,
    }).then((value) {
      print(value.data);
      favouriteModel = FavouriteModel.fromJson(value.data);
      print(favouriteModel!.products!.length);
      emit(GetFavourite());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorGetFavourite());
    });
  }

  void deleteFavourite(productId) {
    emit(AddToFavouriteLoading());
    DioHelperStore.delData(url: ApiConstants.favouriteApi, data: {
      "nationalId": natoinalId,
      "productId": productId,
    }).then((value) {
      emit(DeleteFavourite());
      getFavourite();
    }).catchError((error) {
      print(error.toString());
      emit(ErrorDeleteFavourite());
    });
  }

}
