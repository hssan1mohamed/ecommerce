import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'pages_state.dart';

class PagesCubit extends Cubit<PagesState> {
  PagesCubit() : super(PagesInitial());
  static PagesCubit get(context) => BlocProvider.of(context);

  int selectedPage = 0;

  void onItemTapped(int index) {
    selectedPage = index;
    print(selectedPage);
    emit(PagesInitial());
  }
}
