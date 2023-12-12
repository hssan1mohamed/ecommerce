import 'package:ecommerce_training/core/controllers/pages_cubit/pages_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/managers/colors.dart';
import '../../core/managers/lists.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PagesCubit, PagesState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = PagesCubit.get(context);
        return Scaffold(
          body:pages[cubit.selectedPage],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.selectedPage,
            onTap: (index) => cubit.onItemTapped(index),
            selectedItemColor: AppColors.primaryMaterialColor,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border), label: "favourite"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart), label: "Cart"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Profile"),
            ],
          ),
        );
      },
    );
  }
}
