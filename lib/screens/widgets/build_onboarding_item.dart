import 'package:ecommerce_training/models/on_bording_module.dart';
import 'package:flutter/material.dart';

import '../../core/managers/textStyle.dart';

Widget buildOnBoardingItem(OnBordingModel model) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Container(
            height: 250,
            child: Image(
              image: AssetImage(model.image!),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            model.title!,
            style: textStyleH1,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            model.subTitle!,
            style: textStyleH2,
          ),
        ],
      ),
    );
