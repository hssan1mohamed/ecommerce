import 'package:ecommerce_training/core/controllers/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_training/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../core/managers/colors.dart';

Widget buildCartItem(CartProducts cartProducts, context) => Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.primaryColor),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 150,
            color: Colors.transparent,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.primaryMaterialColor.shade400,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10))),
                            child: Image(
                              width: 120,
                              image: NetworkImage(cartProducts.image!),
                            ),
                          ),
                        ),
                        if (cartProducts.status == 'New')
                          Expanded(
                              child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10))),
                            width: double.infinity,
                            child: const Center(
                                child: Text(
                              '15% OFF',
                              style: TextStyle(color: Colors.white),
                            )),
                          ))
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cartProducts.name!,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              '\$${cartProducts.totalPrice!.toStringAsFixed(2)}',
                              style: TextStyle(
                                  color: HexColor('#07094D'),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: 1,
                              height: 20,
                              color: Colors.black,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(3)),
                              height: 13,
                              width: 13,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'Black',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        InkWell(
                          onTap: () {
                            CartCubit.get(context)
                                .deleteCart(cartProducts.sId!);
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              const Text('Remove'),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  cartProducts.quantity == 1
                                      ? null
                                      : CartCubit.get(context).updateQuantity(
                                          cartProducts.sId,
                                          --cartProducts.quantity);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: cartProducts.quantity != 1
                                          ? HexColor('#07094D')
                                          : HexColor('#07094D')
                                              .withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(3)),
                                  height: 26,
                                  width: 26,
                                  child: const Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${cartProducts.quantity!}',
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  CartCubit.get(context)
                                      .addToCart(cartProducts.sId);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: HexColor('#07094D'),
                                      borderRadius: BorderRadius.circular(3)),
                                  height: 26,
                                  width: 26,
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
