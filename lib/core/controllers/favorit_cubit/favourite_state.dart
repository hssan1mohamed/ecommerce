part of 'favourite_cubit.dart';

@immutable
abstract class FavouriteState {}

class FavouriteInitial extends FavouriteState {}

class AddToFavouriteLoading extends FavouriteState {}
class AddToFavourite extends FavouriteState {}

class ErrorAddToFavourite extends FavouriteState {}

class GetFavourite extends FavouriteState {}

class ErrorGetFavourite extends FavouriteState {}

class DeleteFavourite extends FavouriteState {}

class ErrorDeleteFavourite extends FavouriteState {}
