import 'package:flutter/material.dart';
import 'package:akbarimandiwholesale/helper/route_helper.dart';
import 'package:akbarimandiwholesale/utill/app_constants.dart';
import 'package:akbarimandiwholesale/utill/dimensions.dart';
import 'package:akbarimandiwholesale/utill/images.dart';
import 'package:akbarimandiwholesale/utill/styles.dart';
import 'package:akbarimandiwholesale/view/base/menu_bar.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          color: Theme.of(context).cardColor,
          width: 1170.0,
          height: 70.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    onTap: () => Navigator.pushNamed(context, RouteHelper.menu),
                    child: Row(
                      children: [
                        Image.asset(Images.app_logo,
                            height: 70,
                            width: 70,
                            color: Theme.of(context).primaryColor),
                        SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                        Text(AppConstants.APP_NAME,
                            style: poppinsMedium.copyWith(
                                color: Theme.of(context).primaryColor)),
                      ],
                    )),
              ),
              MenuBar(),
            ],
          )),
    );
  }

  @override
  Size get preferredSize => Size(double.maxFinite, 70);
}
