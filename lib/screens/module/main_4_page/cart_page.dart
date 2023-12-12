import 'package:ecommerce_training/core/controllers/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_training/screens/widgets/build_cart_item.dart';
import 'package:ecommerce_training/screens/widgets/empity_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../core/managers/colors.dart';
import '../../widgets/botton.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/loading_page.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = CartCubit.get(context);
    cubit.getCart();
    return BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {},
        builder: (context, state) {
          return cubit.cartModel == null
              ? const LoadingWidget()
              : Scaffold(
                  backgroundColor: Colors.grey[200],
                  appBar: MyCustomAppBar(text: 'My Cart'),
                  body: state is AddToCartLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                              child: Column(children: [
                            if (cubit.cartModel!.products!.isNotEmpty)
                              ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) =>
                                      buildCartItem(
                                          cubit.cartModel!.products![index],
                                          context),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                        height: 30,
                                      ),
                                  itemCount: cubit.cartModel!.products!.length),
                            if (cubit.cartModel!.products!.isEmpty)
                               EmpityPage(),
                                Text('Cart Is Empty'),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: HexColor('#FEFEFE'),
                                    borderRadius: BorderRadius.circular(6)),
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const Text('Apply coppen code .....'),
                                      const Spacer(),
                                      DefaultButton(
                                          height: 40,
                                          backgroundColor:
                                              AppColors.primaryColor,
                                          width: 93,
                                          buttonWidget: const Text(
                                            'Apply',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          function: () {}),
                                    ],
                                  ),
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                          ]))));
        });
  }
}
