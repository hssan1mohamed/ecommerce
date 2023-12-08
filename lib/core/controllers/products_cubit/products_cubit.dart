import 'package:bloc/bloc.dart';
import 'package:ecommerce_training/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../network/constant.dart';
import '../../network/remote/dio_helper.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());
  static ProductsCubit get(context) => BlocProvider.of(context);
  Products ? products;
  void getHomeProducts(){
    emit(ProductsLoadingState());
    DioHelperStore.getData(url:ApiConstants.homeApi).then((value){
      products = Products.fromJson(value.data);
      print(products!.product!.length);
      emit(ProductsDoneState());
    }).catchError((error){
      print(error.toString());
      emit(ProductsErrorState());
    });
  }


}
