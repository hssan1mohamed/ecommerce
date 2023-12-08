import 'dart:convert';
import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_training/core/managers/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import '../../../core/controllers/products_cubit/products_cubit.dart';
import '../../../models/product_model.dart';
import '../../widgets/build_product_item.dart';
import '../../widgets/loading_page.dart';

const defaultPadding = 16.0;

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocConsumer<ProductsCubit, ProductsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = ProductsCubit.get(context);
          return  cubit.products==null? LoadingWidget():   SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: defaultPadding, horizontal: defaultPadding),
              child: Column(
                children: [
                  SizedBox(
                    height: defaultPadding * 2,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: size.width * 0.9,
                    child: Text('Welcome',
                      style: textStyleH1,)
                  ),

                  SizedBox(
                    height: defaultPadding * 1,
                  ),
                  ImageSliderDemo(cubit: cubit),
                  SizedBox(
                    height: defaultPadding * 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Most Popular',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontFamily: 'Ubuntu',
                            letterSpacing: 2,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'See all',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                            fontFamily: 'Ubuntu',
                            letterSpacing: 2,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),


                  //  ProductsCarousel(),
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
        child: Container(
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

class ImageSliderDemo extends StatefulWidget {
  ProductsCubit? cubit;
  ImageSliderDemo({required this.cubit});
  @override
  _ImageSliderDemoState createState() => _ImageSliderDemoState();

}

int _current = 0;
final CarouselController _controller = CarouselController();

class _ImageSliderDemoState extends State<ImageSliderDemo> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            child: CarouselSlider(
          options: CarouselOptions(
              enlargeCenterPage: true,
              enableInfiniteScroll: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
          items: widget.cubit!.products!.product!.map((item) => Container(
                    child: Center(
                        child: Stack(
                      children: [
                        Container(
                          width: 1200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              image: DecorationImage(
                                image: NetworkImage(item.image!),
                                fit: BoxFit.contain,
                              )),
                        ),
                      ],
                    )),
                  ))
              .toList(),
        )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.cubit!.products!.product!.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 6.0,
                height: 6.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
      ],
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
