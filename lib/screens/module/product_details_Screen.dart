import 'package:ecommerce_training/core/controllers/favorit_cubit/favourite_cubit.dart';
import 'package:ecommerce_training/core/managers/colors.dart';
import 'package:ecommerce_training/core/managers/show_snakbar.dart';
import 'package:ecommerce_training/screens/widgets/botton.dart';
import 'package:ecommerce_training/screens/widgets/slider_images.dart';
import 'package:flutter/material.dart';

import '../../core/controllers/cart_cubit/cart_cubit.dart';
import '../../models/product_model.dart';

class ProductDetailsPage extends StatelessWidget {
  ProductDetailsPage({this.product});
  Product? product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        // backgroundColor: AppColors.backgroundColor,
        title: const Text('Product Details',
            style: TextStyle(color: AppColors.primaryColor, fontSize: 25)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        backgroundColor: Colors.white,
        child: Icon(Icons.arrow_back, color: AppColors.primaryColor),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageSliderDemo(list: product!.images!),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
                color: AppColors.primaryColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product!.name!,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          IconButton(onPressed: (){
                            try {
                              FavouriteCubit.get(context).addToFavourite(product!.sId);
                              ShowSnakbar(context, 'Add to Favourite success');
                            } on Exception catch (e) {
                              // TODO
                              print(e.toString());
                            }
                          },
                              icon:Icon( Icons.favorite_border),iconSize: 25,color: Colors.red,)
                        ],
                      ),
                      const SizedBox(height: 20),
                      row(product!.company!,product!.category!),
                      const SizedBox(height: 20),
                      text(
                        product!.description!,
                      ),
                      const  Divider(color: AppColors.backgroundColor),
                      const SizedBox(height: 10),
                      row('Count In Stock :',product!.countInStock!.toString() ),
                      const  Divider(color: AppColors.backgroundColor),
                      const SizedBox(height: 10),
                      row('Status :',  product!.status.toString(),),
                      const  Divider(color: AppColors.backgroundColor),
                      const SizedBox(height: 10),
                      row('Price :',  '\$${product!.price!}',),
                      const  Divider(color: AppColors.backgroundColor),
                      const SizedBox(height: 10),

                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            CartCubit.get(context).addToCart(product!.sId);
                            ShowSnakbar(context, 'Add to Cart success');
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: Colors.white,
                          ),
                          child: const Text(
                            "Add To Cart",
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget text(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16, color: AppColors.backgroundColor),
    );
  }
  Widget row(String text1,String txet2){
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          text(text1),
          text(txet2),
        ],
      ),
    );
  }
}
