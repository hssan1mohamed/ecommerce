import 'package:ecommerce_training/core/controllers/favorit_cubit/favourite_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/build_favourite_item.dart';
import '../../widgets/build_product_item.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/empity_item.dart';
import '../../widgets/loading_page.dart';

const defaultPadding = 16.0;

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var cubit = FavouriteCubit.get(context);
    cubit.getFavourite();
    return BlocConsumer<FavouriteCubit, FavouriteState>(
        listener: (context, state) {},
        builder: (context, state) {
          return cubit.favouriteModel == null
              ? const LoadingWidget()
              : Scaffold(
                  backgroundColor: Colors.grey[200],
                  appBar: MyCustomAppBar(text: 'My Favourite'),
                  body: state is AddToFavouriteLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                              child: Column(children: [
                            if (cubit.favouriteModel!.products!.isNotEmpty)
                              ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) =>
                                      buildFavouriteItem(
                                          cubit
                                              .favouriteModel!.products![index],
                                          context),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                        height: 30,
                                      ),
                                  itemCount:
                                      cubit.favouriteModel!.products!.length),
                            if (cubit.favouriteModel!.products!.isEmpty)
                              const Column(
                                children: [
                                  EmpityPage(),
                                  Center(
                                    child: Text('Favourite Is Empty'),
                                  ),
                                ],
                              ),
                            const SizedBox(
                              height: 20,
                            ),
                          ]))));
        });
  }
}
