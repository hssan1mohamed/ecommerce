import 'package:bloc/bloc.dart';
import 'package:ecommerce_training/core/managers/values.dart';
import 'package:ecommerce_training/core/network/constant.dart';
import 'package:ecommerce_training/core/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../models/cart_model.dart';
part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  static CartCubit get(context) => BlocProvider.of(context);
  void addToCart(productId) {
    emit(AddToCartLoading());
    DioHelperStore.postData(url: ApiConstants.addCartApi, data: {
      "nationalId": natoinalId,
      "productId": productId,
      "quantity": "1"
    }).then((value) {
      getCart();
      emit(AddToCart());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorAddToCart());
    });
  }

  CartModel? cartModel;
  void getCart() {
    DioHelperStore.getData(url: ApiConstants.getCartApi, data: {
      "nationalId": natoinalId,
    }).then((value) {
      cartModel = CartModel.fromJson(value.data);
      print(cartModel!.products!.length);
      emit(GetCart());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorGetCart());
    });
  }

  void deleteCart(productId) {
    emit(AddToCartLoading());
    DioHelperStore.delData(url: ApiConstants.deleteCartApi, data: {
      "nationalId": natoinalId,
      "productId": productId,
    }).then((value) {
      getCart();
      emit(DeleteCart());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorDeleteCart());
    });
  }

  void updateQuantity(quantity, productId) {
    emit(AddToCartLoading());
    DioHelperStore.putData(url: ApiConstants.updateCartApi, data: {
      "nationalId": natoinalId,
      "productId": productId,
      "quantity": quantity
    }).then((value) {
      getCart();
      emit(UpdateCart());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorUpdateCart());
    });
  }
}
