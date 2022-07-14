import 'package:flutter/material.dart';
import 'package:flutter_grocery/localization/language_constrants.dart';
import 'package:flutter_grocery/utill/color_resources.dart';
import 'package:flutter_grocery/utill/dimensions.dart';
import 'package:flutter_grocery/utill/styles.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final Function onTap;
  TitleWidget({@required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Text(title, style: poppinsBold.copyWith(fontSize: 20)),
      ),
      onTap != null
          ? InkWell(
              onTap: onTap,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
                child: Text(
                  getTranslated('view_all', context),
                  style: poppinsRegular.copyWith(
                      fontSize: Dimensions.FONT_SIZE_SMALL,
                      color: ColorResources.getHintColor(context)),
                ),
              ),
            )
          : SizedBox(),
    ]);
  }
}
