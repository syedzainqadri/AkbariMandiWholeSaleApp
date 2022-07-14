import 'package:flutter/material.dart';
import 'package:akbarimandiwholesale/helper/price_converter.dart';
import 'package:akbarimandiwholesale/localization/language_constrants.dart';
import 'package:akbarimandiwholesale/provider/order_provider.dart';
import 'package:akbarimandiwholesale/provider/splash_provider.dart';
import 'package:akbarimandiwholesale/utill/dimensions.dart';
import 'package:akbarimandiwholesale/utill/styles.dart';
import 'package:provider/provider.dart';

class DeliveryOptionButton extends StatelessWidget {
  final String value;
  final String title;
  final bool kmWiseFee;
  DeliveryOptionButton(
      {@required this.value, @required this.title, @required this.kmWiseFee});

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, order, child) {
        return InkWell(
          onTap: () => order.setOrderType(value),
          child: Row(
            children: [
              Radio(
                value: value,
                groupValue: order.orderType,
                activeColor: Theme.of(context).primaryColor,
                onChanged: (String value) => order.setOrderType(value),
              ),
              SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
              Text(title, style: poppinsRegular),
              SizedBox(width: 5),
              kmWiseFee
                  ? SizedBox()
                  : Text(
                      '(${value == 'delivery' ? PriceConverter.convertPrice(context, Provider.of<SplashProvider>(context, listen: false).configModel.deliveryCharge) : getTranslated('free', context)})',
                      style: poppinsMedium),
            ],
          ),
        );
      },
    );
  }
}
