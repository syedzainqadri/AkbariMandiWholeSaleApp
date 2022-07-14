import 'package:flutter/material.dart';
import 'package:akbarimandiwholesale/provider/splash_provider.dart';
import 'package:akbarimandiwholesale/utill/color_resources.dart';
import 'package:akbarimandiwholesale/utill/dimensions.dart';
import 'package:akbarimandiwholesale/utill/images.dart';
import 'package:akbarimandiwholesale/utill/styles.dart';
import 'package:provider/provider.dart';

class SubCategoryItem extends StatelessWidget {
  final String title;
  final String icon;
  final bool isSelected;

  SubCategoryItem(
      {@required this.title, @required this.icon, @required this.isSelected});

  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.only(bottom: 8.0),
      width: 100,
      height: 220,
      margin: EdgeInsets.symmetric(
          vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL, horizontal: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        //Color needs attention
        // color: isSelected
        //     ? Theme.of(context).primaryColor
        //     : ColorResources.getBackgroundColor(context)
      ),
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            height: 100,
            width: 100,
            alignment: Alignment.center,
            //padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              //color needs attention
              // color: isSelected
              //     ? ColorResources.getCategoryBgColor(context)
              //     : ColorResources.getGreyLightColor(context)
              //         .withOpacity(0.05),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: FadeInImage.assetNetwork(
                placeholder: Images.placeholder,
                image:
                    '${Provider.of<SplashProvider>(context, listen: false).baseUrls.categoryImageUrl}/$icon',
                fit: BoxFit.cover,
                width: 150,
                height: 150,
                imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder,
                    height: 100, width: 100, fit: BoxFit.cover),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: Dimensions.PADDING_SIZE_DEFAULT,
                horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            child: Text(title,
                // maxLines: 2,
                // overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: poppinsSemiBold.copyWith(
                    fontSize: Dimensions.FONT_SIZE_DEFAULT,
                    color: isSelected
                        ? ColorResources.getBackgroundColor(context)
                        : ColorResources.getTextColor(context))),
          ),
        ]),
      ),
    );
  }
}
