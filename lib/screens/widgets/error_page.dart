import 'package:flutter/material.dart';

import '../../core/controllers/register_cubit/register_cubit.dart';
import '../../core/managers/colors.dart';
import '../../core/managers/textStyle.dart';
import 'botton.dart';
class erroeWidget extends StatelessWidget {
  final String error;
  const erroeWidget({
    super.key, required this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding:  const EdgeInsets.only(right: 18.0, left: 18),
            child: Center(
                child: Container(
                  child:Image.asset('assets/images/error.png'),
                )),
          ),
          const SizedBox(height: 60,),
          Padding(
              padding: const EdgeInsets.only(right: 18.0, left: 18),
              child:Center(child: Text(error,style: textStyleH2,))
          ),
          const SizedBox(height: 60,),

          Padding(
            padding: const EdgeInsets.only(right: 18.0, left: 18),
            child: DefaultButton(
                backgroundColor: buttonColor,
                buttonWidget: const Text('Try Again',
                    style:
                    TextStyle(color: Colors.white, fontSize: 20)),
                function: () {
                  RegisterCubit.get(context).tryAgain();
                }),
          )
        ],
      ),
    );
  }
}
