import 'package:ecommerce_training/core/managers/images.dart';
import 'package:flutter/cupertino.dart';

import '../../models/on_bording_module.dart';

import '../../../screens/module/main_4_page/cart_page.dart';
import '../../../screens/module/main_4_page/home_page.dart';
import '../../../screens/module/main_4_page/profile_page.dart';
import '../../../screens/module/main_4_page/search_page.dart';

final List<OnBordingModel> onbording = [
  OnBordingModel(
      title: 'Welcome',
      subTitle: "Welcome to our sales program",
      image: AddImage.onBordingImage),
  OnBordingModel(
      title: 'Shopping',
      subTitle: 'We have many product to shop',
      image: AddImage.onBordingImage1),
  OnBordingModel(
      title: 'Start',
      subTitle: 'lets start to shop',
      image: AddImage.onBordingImage2),
];
final List<Widget> pages = [
  const HomePage(),
  const SearchPage(),
  const CartPage(),
  const ProfilePage()
];
