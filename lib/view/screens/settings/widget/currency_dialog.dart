import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:akbarimandiwholesale/localization/language_constrants.dart';
import 'package:akbarimandiwholesale/provider/localization_provider.dart';
import 'package:akbarimandiwholesale/provider/splash_provider.dart';
import 'package:akbarimandiwholesale/utill/app_constants.dart';
import 'package:akbarimandiwholesale/utill/color_resources.dart';
import 'package:akbarimandiwholesale/utill/dimensions.dart';
import 'package:akbarimandiwholesale/utill/styles.dart';
import 'package:provider/provider.dart';

class CurrencyDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int index;
    index =
        Provider.of<LocalizationProvider>(context, listen: false).languageIndex;

    return Dialog(
      backgroundColor: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        width: 300,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                child: Text(getTranslated('language', context),
                    style: poppinsRegular.copyWith(
                        fontSize: Dimensions.FONT_SIZE_LARGE)),
              ),
              SizedBox(
                  height: 150,
                  child: Consumer<SplashProvider>(
                    builder: (context, splash, child) {
                      List<String> _valueList = [];
                      AppConstants.languages.forEach(
                          (language) => _valueList.add(language.languageName));

                      return CupertinoPicker(
                        itemExtent: 40,
                        useMagnifier: true,
                        magnification: 1.2,
                        scrollController:
                            FixedExtentScrollController(initialItem: index = 0),
                        onSelectedItemChanged: (int i) {
                          index = i;
                        },
                        children: _valueList.map((value) {
                          return Center(
                              child: Text(value,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .color)));
                        }).toList(),
                      );
                    },
                  )),
              Divider(
                  height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                  color: ColorResources.getHintColor(context)),
              Row(children: [
                Expanded(
                    child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(getTranslated('cancel', context),
                      style: poppinsRegular.copyWith(
                          color: ColorResources.getYellow(context))),
                )),
                Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(
                      vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  child: VerticalDivider(
                      width: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                      color: Theme.of(context).hintColor),
                ),
                Expanded(
                    child: TextButton(
                  onPressed: () {
                    Provider.of<LocalizationProvider>(context, listen: false)
                        .setLanguage(Locale(
                      AppConstants.languages[index].languageCode,
                      AppConstants.languages[index].countryCode,
                    ));
                    Navigator.pop(context);
                  },
                  child: Text(getTranslated('ok', context),
                      style: poppinsRegular.copyWith(
                          color: ColorResources.getGreen(context))),
                )),
              ]),
            ]),
      ),
    );
  }
}
