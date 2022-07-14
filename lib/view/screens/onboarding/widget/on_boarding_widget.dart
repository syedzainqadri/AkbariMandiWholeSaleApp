import 'package:flutter/material.dart';
import 'package:flutter_grocery/data/model/response/onboarding_model.dart';
import 'package:flutter_grocery/utill/dimensions.dart';
import 'package:flutter_grocery/utill/styles.dart';

class OnBoardingWidget extends StatelessWidget {
  final OnBoardingModel onBoardingModel;
  OnBoardingWidget({@required this.onBoardingModel});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Expanded(
          flex: 7,
          child: Padding(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_LARGE),
            child: Image.asset(onBoardingModel.imageUrl),
          )),
      Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              onBoardingModel.title,
              style: poppinsMedium.copyWith(
                fontSize: 20,
                color: Colors.white,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          Icon(
            Icons.circle,
            color: Colors.white,
          ),
        ],
      ),
      SizedBox(height: 10),
      Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              onBoardingModel.title2,
              style: poppinsMedium.copyWith(
                fontSize: 20,
                color: Colors.yellow,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          Icon(
            Icons.circle,
            color: Colors.white,
          ),
        ],
      ),
      SizedBox(height: 10),
      Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              onBoardingModel.title3,
              style: poppinsMedium.copyWith(
                fontSize: 20,
                color: Colors.white,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          Icon(
            Icons.circle,
            color: Colors.white,
          ),
        ],
      )
    ]);
  }
}
