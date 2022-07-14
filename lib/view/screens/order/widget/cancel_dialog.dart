import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:akbarimandiwholesale/localization/language_constrants.dart';
import 'package:akbarimandiwholesale/provider/order_provider.dart';
import 'package:akbarimandiwholesale/utill/color_resources.dart';
import 'package:akbarimandiwholesale/utill/dimensions.dart';
import 'package:akbarimandiwholesale/utill/styles.dart';
import 'package:provider/provider.dart';

class OrderCancelDialog extends StatelessWidget {
  final String orderID;
  final Function callback;
  final bool fromOrder;
  OrderCancelDialog(
      {@required this.orderID,
      @required this.callback,
      @required this.fromOrder});

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
        builder: (context, order, child) => Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              width: 300,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_LARGE, vertical: 50),
                  child: Text(getTranslated('are_you_sure_to_cancel', context),
                      style: poppinsRegular, textAlign: TextAlign.center),
                ),
                Divider(height: 0, color: ColorResources.getHintColor(context)),
                !order.isLoading
                    ? Row(children: [
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            Provider.of<OrderProvider>(context, listen: false)
                                .cancelOrder(orderID, fromOrder,
                                    (String message, bool isSuccess,
                                        String orderID) {
                              Navigator.pop(context);
                              callback(message, isSuccess, orderID);
                            });
                          },
                          child: Container(
                            padding:
                                EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10))),
                            child: Text(getTranslated('yes', context),
                                style: poppinsRegular.copyWith(
                                    color: Theme.of(context).primaryColor)),
                          ),
                        )),
                        Expanded(
                            child: InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding:
                                EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(10))),
                            child: Text(getTranslated('no', context),
                                style: poppinsRegular.copyWith(
                                    color: Colors.white)),
                          ),
                        )),
                      ])
                    : Container(
                        height: 50,
                        child: Center(
                            child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Theme.of(context).primaryColor)))),
              ]),
            )));
  }
}
