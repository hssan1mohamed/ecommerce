part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}
class ProfileInitState extends ProfileState{}
class LoadingProfile extends ProfileState{}
class GetUserData extends ProfileState{}
class ErrorGetUserData extends ProfileState{}