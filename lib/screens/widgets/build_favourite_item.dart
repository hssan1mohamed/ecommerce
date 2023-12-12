import 'package:ecommerce_training/core/controllers/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_training/core/controllers/favorit_cubit/favourite_cubit.dart';
import 'package:ecommerce_training/core/managers/show_snakbar.dart';
import 'package:ecommerce_training/models/cart_model.dart';
import 'package:ecommerce_training/models/favourite_model.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../core/managers/colors.dart';

Widget buildFavouriteItem(FavouriteProducts favouriteProducts, context) =>
   Container(
     height: 100,
     padding: EdgeInsets.all(10),
     width: double.infinity,
     decoration: BoxDecoration(
       borderRadius: BorderRadius.circular(15),
       color: AppColors.primaryColor
     ),
     child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       crossAxisAlignment: CrossAxisAlignment.center,
       children: [
         Container(
           decoration: BoxDecoration(
               color:  AppColors.primaryColor,
               borderRadius: const BorderRadius.only(
                   topLeft: Radius.circular(10), topRight: Radius.circular(10))),
           child: Image(
             width: 150,
             image: NetworkImage(favouriteProducts.image!),
           ),
         ),
         Flexible(
           child: Column(
             children: [
               Text(
                 softWrap: true,
                 overflow: TextOverflow.ellipsis,
                 favouriteProducts.name!,
                 style: const TextStyle(
                     color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
               ),
               Text(
                 '\$${favouriteProducts.price!}',
                 style: TextStyle(
                     color: HexColor('#07094D'),
                     fontSize: 13,
                     fontWeight: FontWeight.w600),
               ),
             ],
           ),
         ),
         TextButton.icon(onPressed: (){
           FavouriteCubit.get(context).deleteFavourite(favouriteProducts.sId);
           ShowSnakbar(context, 'Deleted From Favourite');
           
         },
             icon: Icon(Icons.delete ,color: Colors.red), label: Text('delete'))

       ],
     ),
   );


//
//   Container(
// width: double.infinity,
// height: 150,
// decoration: BoxDecoration(
//     borderRadius: BorderRadius.circular(12), color: HexColor('#FEFEFE')),
// child: Column(
//   children: [
//     Container(
//       width: double.infinity,
//       height: 150,
//       color: Colors.transparent,
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: 120,
//             height: 120,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [
//                   Expanded(
//                     flex: 3,
//                     child: Container(
//                       decoration: BoxDecoration(
//                           color: HexColor('#535482'),
//                           borderRadius: const BorderRadius.only(
//                               topLeft: Radius.circular(10),
//                               topRight: Radius.circular(10))),
//                       child:Image(
//                         width: 120,
//                         image: NetworkImage(favouriteProducts.image!),
//                       ),
//                     ),
//                   ),
//                   if(favouriteProducts.status=='New')
//                     Expanded(
//                         child: Container(
//                           decoration: const BoxDecoration(
//                               color: Colors.red,
//                               borderRadius: BorderRadius.only(
//                                   bottomLeft: Radius.circular(10),
//                                   bottomRight: Radius.circular(10))),
//                           width: double.infinity,
//                           child:const Center(
//                               child: Text(
//                                 '15% OFF',
//                                 style: TextStyle(color: Colors.white),
//                               )),
//                         ))
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children:[
//                   Text(favouriteProducts.name!,style:const TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w500),),
//                   const SizedBox(
//                     height:20,
//                   ),
//                   Row(
//                     children:[
//                       Text('\$${favouriteProducts.totalPrice!}',style: TextStyle(color: HexColor('#07094D'),fontSize: 16,fontWeight: FontWeight.w600),),
//                       const SizedBox(
//                         width: 20,
//                       ),
//                       Container(
//                         width: 1,
//                         height: 20,
//                         color: Colors.black,
//                       ),
//                       const SizedBox(
//                         width: 20,
//                       ),
//                       Container(
//                         decoration:BoxDecoration(
//                             color: Colors.black,
//                             borderRadius: BorderRadius.circular(3)
//                         ),
//                         height: 13,
//                         width: 13,
//                       ),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       const Text('Black',style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
//
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 12,
//                   ),
//                   InkWell(
//                     onTap:(){
//                       CartCubit.get(context).deleteCart(favouriteProducts.sId!);
//                     },
//                     child: Row(
//                       children: [
//                         const Icon(Icons.delete,color: Colors.grey,),
//                         Text('Remove'),
//                         Spacer(),
//                         InkWell(
//                           onTap:(){
//                             FavouriteCubit.get(context).deleteFavourite(favouriteProducts.sId);
//                             ShowSnakbar(context, 'deleted success');
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 color:favouriteProducts.quantity!=1?HexColor('#07094D'):HexColor('#07094D').withOpacity(0.4),
//                                 borderRadius: BorderRadius.circular(3)
//                             ),
//                             height: 26,
//                             width:26,
//                             child:const Icon(Icons.remove,color: Colors.white,),
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Text('${favouriteProducts.quantity!}',style:const TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
//                         const SizedBox(
//                           width: 10,
//                         ),
//
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     )
//   ],
// ),
//);
