import 'dart:ui';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_training/screens/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/controllers/products_cubit/products_cubit.dart';
import '../../widgets/build_product_item.dart';
import '../../widgets/loading_page.dart';
import '../../widgets/slider_images.dart';

const defaultPadding = 16.0;

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyCustomAppBar(text: 'Power Up Store'),
      body: BlocConsumer<ProductsCubit, ProductsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = ProductsCubit.get(context);
          return cubit.products == null
              ? const LoadingWidget()
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: defaultPadding, horizontal: defaultPadding),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: defaultPadding * 1,
                        ),
                        ImageSliderDemo(list:cubit.products!.product![0].images!),
                        const SizedBox(
                          height: defaultPadding * 2,
                        ),
                        const Row(
                         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'All Products',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontFamily: 'Ubuntu',
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.w500),
                            ),
                            Spacer(),
                          ],
                        ),

                        productsGridv(cubit, context),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }

  Padding card(BuildContext context, String imageUrl) {
    return Padding(
      padding:
          const EdgeInsets.only(right: 5.0, left: 5.0, top: 15, bottom: 15),
      child: Card(
        elevation: 10,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.40,
          height: MediaQuery.of(context).size.height * 0.35,
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}


Widget productsGridv(ProductsCubit cubit, context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        color: Colors.transparent,
        child: GridView.count(
          childAspectRatio: 1 / 1.3,
          mainAxisSpacing: 1.0,
          crossAxisSpacing: 1.0,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          children: List.generate(
              cubit.products!.product!.length,
              (index) =>
                  buildProductItem(cubit.products!.product![index], context)),
        ),
      ),
    ],
  );
}
