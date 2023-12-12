import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:ecommerce_training/core/controllers/onbording_cubit/onbording_cubit.dart';
import 'package:ecommerce_training/core/controllers/onbording_cubit/onbording_states.dart';
import 'package:ecommerce_training/screens/widgets/botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/managers/colors.dart';
import '../../core/managers/lists.dart';
import '../../core/managers/textStyle.dart';
import '../widgets/build_onboarding_item.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnBoardingCubit, OnBoardingStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var onBordingController = PageController();
        var cubitOnBording = OnBoardingCubit.get(context);
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Power Up',
                    textStyle: textStyleH1,
                    speed: const Duration(milliseconds: 200),
                  ),
                ],
                totalRepeatCount: 10,
                pause: const Duration(milliseconds: 1000),
                displayFullTextOnTap: true,
                stopPauseOnTap: true,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 450,
                child: PageView.builder(
                    onPageChanged: (index) {
                      if (index == onbording.length - 1) {
                        cubitOnBording.pageLast(index);
                      } else {
                        cubitOnBording.pageNotLast(index);
                      }
                    },
                    physics: const BouncingScrollPhysics(),
                    controller: onBordingController,
                    itemCount: onbording.length,
                    itemBuilder: (context, index) {
                      return buildOnBoardingItem(onbording[index]);
                    }),
              ),
              Row(
                children: [
                  const Spacer(),
                  SmoothPageIndicator(
                    controller: onBordingController,
                    count: onbording.length,
                    effect:const ExpandingDotsEffect(
                        dotColor: Colors.black,
                        activeDotColor: AppColors.primaryColor,
                        dotHeight: 7,
                        expansionFactor: 4,
                        dotWidth: 5,
                        spacing: 5),
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              cubitOnBording.isLastPage
                  ? Padding(
                      padding: const EdgeInsets.only(right: 18.0, left: 18),
                      child: DefaultButton(
                          backgroundColor: AppColors.primaryColor,
                          buttonWidget: const Text('Get Start',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                          function: () {
                            cubitOnBording.onSubmit(context);
                          }),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(right: 18.0, left: 18),
                      child: DefaultButton(
                          backgroundColor: AppColors.primaryColor,
                          buttonWidget: const Text('Next',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                          function: () {
                            onBordingController.nextPage(
                                duration: const Duration(seconds: 3),
                                curve: Curves.fastLinearToSlowEaseIn);
                          }),
                    ),
            ],
          ),
        );
      },
    );
  }
}
