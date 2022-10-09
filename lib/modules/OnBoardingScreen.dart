import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goshop/modules/registerScreen.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../remoteNetwork/cacheHelper.dart';
import '../shared/constants.dart';
import 'LoginScreen.dart';

class BoardingModel{
  late final String image;
  late final String title;
  late final String body;

   BoardingModel({
     required this.image,
     required this.body,
     required this.title,
});
}


class OnBoarding extends StatefulWidget {
  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController onBoardController = PageController();

  List<BoardingModel> boardingModel =
  [
    BoardingModel(
        image: 'assets/images/boarding1.svg',
        body: 'Choose Whatever the Product you wish for with the easiest way possible using Go Shop',
        title: 'Explore',
    ),
    BoardingModel(
        image: 'assets/images/boarding2.svg',
        body: 'Yor Order will be shipped to you as fast as possible by our carrier',
        title: 'Shipping',
    ),
    BoardingModel(
        image: 'assets/images/boarding3.svg',
        body: 'Pay with the safest way possible either by cash or credit cards',
        title: 'Make the Payment',
    ),

  ];

  void submit() {
    CacheHelper.saveData(
      key: 'ShowOnBoard',
      value: false,
    ).then((value) {
      if (value) {
        navigateAndKill(
          context,
          LoginScreen(),
        );
      }
    });
  }

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
            [
              Expanded(
                child: PageView.builder(
                  controller: onBoardController,
                  physics: BouncingScrollPhysics(),
                  onPageChanged: (index)
                  {
                    if(index == boardingModel.length - 1)
                      isLast = true;
                    else
                      isLast = false;
                  },
                  itemBuilder:(context,index) => onBoarding(boardingModel[index], context),
                  itemCount: boardingModel.length,
                ),
              ),
              SmoothPageIndicator(
                  controller: onBoardController,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.white,
                    activeDotColor: Colors.amber[700]!,
                    expansionFactor: 4,
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 10
                  ),
                  count: 3,
              ),
            ],
          ),
        ),
      );
  }

  Widget onBoarding (model, context) => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Spacer(),
      Center(
        child: SvgPicture.asset(model.image),
      ),
       SizedBox(
        height: MediaQuery.of(context).size.height * 0.06,
      ),
      Text(
        model.title,
        style: const TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
       SizedBox(
        height: MediaQuery.of(context).size.height * 0.1,
      ),
      Text(
        model.body,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.05,
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                if (onBoardController.page == 0) {
                  submit();
                } else if (onBoardController.page == 1) {
                  onBoardController.previousPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                  );
                } else if (onBoardController.page == 2) {
                  submit();
                }
              },
              child: Text(
                boardingModel.indexOf(model)  == boardingModel.length - 1
                    ? 'Log In'
                    : boardingModel.indexOf(model) == 0
                    ? 'Skip'
                    : 'Back',
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const Text(
              '|',
              style: TextStyle(
                color: Colors.amber,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                if(isLast) {
                  CacheHelper.saveData(key: 'ShowOnBoard', value: false).then((value)
                  {
                    if(value)
                      navigateAndKill(context, RegisterScreen());
                  });
                } else {
                  onBoardController.nextPage(
                    duration: Duration(seconds: 1),
                    curve: Curves.fastLinearToSlowEaseIn,
                  );
                }
              },
              child: Text(
                boardingModel.indexOf(model) == 2 ? 'Register' : 'Next',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber[700],
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.05,
      ),
    ],
  );
}
