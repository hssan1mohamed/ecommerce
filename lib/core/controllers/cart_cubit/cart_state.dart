part of 'cart_cubit.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}
class AddToCart extends CartState{}
class AddToCartLoading extends CartState{}
class ErrorAddToCart extends CartState{}
class GetCart extends CartState{}
class ErrorGetCart extends CartState{}
class DeleteCart extends CartState{}
class ErrorDeleteCart extends CartState{}
class UpdateCart extends CartState{}
class ErrorUpdateCart extends CartState{}
