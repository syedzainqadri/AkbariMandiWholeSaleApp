// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:akbarimandiwholesale/helper/price_converter.dart';
// import 'package:akbarimandiwholesale/helper/route_helper.dart';
// import 'package:akbarimandiwholesale/localization/language_constrants.dart';
// import 'package:akbarimandiwholesale/provider/product_provider.dart';
// import 'package:akbarimandiwholesale/provider/splash_provider.dart';
// import 'package:akbarimandiwholesale/utill/color_resources.dart';
// import 'package:akbarimandiwholesale/utill/dimensions.dart';
// import 'package:akbarimandiwholesale/utill/images.dart';
// import 'package:akbarimandiwholesale/utill/styles.dart';
// import 'package:akbarimandiwholesale/view/base/title_widget.dart';
// import 'package:akbarimandiwholesale/view/screens/product/product_details_screen.dart';
// import 'package:provider/provider.dart';

// class AmsItemView extends StatelessWidget {
//   final ScrollController controller = ScrollController();
//   @override
//   Widget build(BuildContext context) {
//     return Provider.of<ProductProvider>(context, listen: false).amsItemList !=
//             null
//         ? Column(children: [
//             Padding(
//               padding: EdgeInsets.fromLTRB(10, 20, 15, 10),
//               child: TitleWidget(
//                   title: getTranslated('ams_items', context) ?? " ",
//                   onTap: () {
//                     Navigator.pushNamed(context, RouteHelper.getAmsItemRoute());
//                   }),
//             ),
//             Container(
//               height: 330,
//               child: Padding(
//                 padding: const EdgeInsets.only(bottom: 8.0),
//                 child: ListView.builder(
//                   controller: controller,
//                   itemCount:
//                       Provider.of<ProductProvider>(context, listen: false)
//                           .amsItemList
//                           .length,
//                   // padding: EdgeInsets.symmetric(
//                   //     horizontal: Dimensions.PADDING_SIZE_SMALL),
//                   scrollDirection: Axis.horizontal,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding:
//                           EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
//                       child: InkWell(
//                         onTap: () {
//                           Navigator.of(context).pushNamed(
//                               RouteHelper.getProductDetailsRoute(
//                                   Provider.of<ProductProvider>(context,
//                                           listen: false)
//                                       .amsItemList[index]
//                                       .id),
//                               arguments: ProductDetailsScreen(
//                                   product: Provider.of<ProductProvider>(context,
//                                           listen: false)
//                                       .amsItemList[index],
//                                   cart: null));
//                         },
//                         child: Container(
//                           width: 200,
//                           padding: EdgeInsets.all(
//                               Dimensions.PADDING_SIZE_EXTRA_SMALL),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: Theme.of(context).cardColor,
//                           ),
//                           child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Container(
//                                   height: 150,
//                                   width: 200,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     border: Border.all(
//                                         width: 1,
//                                         color: ColorResources.getGreyColor(
//                                             context)),
//                                   ),
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(10),
//                                     child: FadeInImage.assetNetwork(
//                                       placeholder: Images.placeholder,
//                                       width: 100,
//                                       height: 150,
//                                       fit: BoxFit.cover,
//                                       image:
//                                           '${Provider.of<SplashProvider>(context, listen: false).baseUrls.productImageUrl}'
//                                           '/${Provider.of<ProductProvider>(context, listen: false).amsItemList[index].image[0]}',
//                                       imageErrorBuilder: (c, o, s) =>
//                                           Image.asset(Images.placeholder,
//                                               width: 80,
//                                               height: 80,
//                                               fit: BoxFit.fill),
//                                     ),
//                                   ),
//                                 ),
//                                 Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Padding(
//                                         padding:
//                                             const EdgeInsets.only(bottom: 20.0),
//                                         child: Text(
//                                           Provider.of<ProductProvider>(context,
//                                                   listen: false)
//                                               .amsItemList[index]
//                                               .name,
//                                           style: poppinsMedium.copyWith(
//                                               fontSize:
//                                                   Dimensions.FONT_SIZE_SMALL),
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding:
//                                             const EdgeInsets.only(bottom: 8.0),
//                                         child: Text(
//                                           '${Provider.of<ProductProvider>(context, listen: false).amsItemList[index].capacity} ${Provider.of<ProductProvider>(context, listen: false).amsItemList[index].unit}',
//                                           style: poppinsRegular.copyWith(
//                                               fontSize: Dimensions
//                                                   .FONT_SIZE_EXTRA_SMALL),
//                                         ),
//                                       ),
//                                       Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Container(
//                                                   decoration: BoxDecoration(
//                                                     color: Colors.green[900],
//                                                     shape: BoxShape.rectangle,
//                                                     borderRadius:
//                                                         BorderRadius.all(
//                                                       Radius.circular(10),
//                                                     ),
//                                                   ),
//                                                   child: Padding(
//                                                     padding:
//                                                         const EdgeInsets.all(
//                                                             4.0),
//                                                     child: Text(
//                                                       PriceConverter
//                                                           .convertPrice(
//                                                         context,
//                                                         Provider.of<ProductProvider>(
//                                                                 context,
//                                                                 listen: false)
//                                                             .amsItemList[index]
//                                                             .price,
//                                                         discount: Provider.of<
//                                                                     ProductProvider>(
//                                                                 context,
//                                                                 listen: false)
//                                                             .amsItemList[index]
//                                                             .discount,
//                                                         discountType: Provider.of<
//                                                                     ProductProvider>(
//                                                                 context,
//                                                                 listen: false)
//                                                             .amsItemList[index]
//                                                             .discountType,
//                                                       ),
//                                                       style: poppinsBold.copyWith(
//                                                           color: Colors.white,
//                                                           fontSize: Dimensions
//                                                               .FONT_SIZE_SMALL),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 Provider.of<ProductProvider>(
//                                                                 context,
//                                                                 listen: false)
//                                                             .amsItemList[index]
//                                                             .discount >
//                                                         0
//                                                     ? Text(
//                                                         '${Provider.of<ProductProvider>(context, listen: false).amsItemList[index].price}',
//                                                         style: poppinsRegular.copyWith(
//                                                             fontSize: Dimensions
//                                                                 .FONT_SIZE_SMALL,
//                                                             decoration:
//                                                                 TextDecoration
//                                                                     .lineThrough,
//                                                             decorationColor:
//                                                                 Colors.black,
//                                                             color: Colors.red),
//                                                       )
//                                                     : SizedBox(),
//                                               ],
//                                             ),
//                                             Container(
//                                               margin: EdgeInsets.all(2),
//                                               alignment: Alignment.center,
//                                               decoration: BoxDecoration(
//                                                 border: Border.all(
//                                                     width: 1,
//                                                     color: ColorResources
//                                                             .getHintColor(
//                                                                 context)
//                                                         .withOpacity(0.2)),
//                                                 borderRadius:
//                                                     BorderRadius.circular(10),
//                                               ),
//                                               child: Icon(Icons.add,
//                                                   size: 20,
//                                                   color: Theme.of(context)
//                                                       .primaryColor),
//                                             ),
//                                           ]),
//                                     ]),
//                               ]),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             )
//           ])
//         : SizedBox();
//   }
// }
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:akbarimandiwholesale/helper/price_converter.dart';
import 'package:akbarimandiwholesale/helper/route_helper.dart';
import 'package:akbarimandiwholesale/localization/language_constrants.dart';
import 'package:akbarimandiwholesale/provider/product_provider.dart';
import 'package:akbarimandiwholesale/provider/splash_provider.dart';
import 'package:akbarimandiwholesale/utill/color_resources.dart';
import 'package:akbarimandiwholesale/utill/dimensions.dart';
import 'package:akbarimandiwholesale/utill/images.dart';
import 'package:akbarimandiwholesale/utill/styles.dart';
import 'package:akbarimandiwholesale/view/base/title_widget.dart';
import 'package:akbarimandiwholesale/view/screens/product/product_details_screen.dart';
import 'package:provider/provider.dart';

class AmsItemView extends StatelessWidget {
  final ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Provider.of<ProductProvider>(context, listen: false).amsItemList !=
            null
        ? Column(children: [
            Padding(
              padding: EdgeInsets.fromLTRB(10, 20, 15, 10),
              child: TitleWidget(
                  title: getTranslated('ams_items', context) ?? " ",
                  onTap: () {
                    Navigator.pushNamed(context, RouteHelper.getAmsItemRoute());
                  }),
            ),
            Container(
              height: 330,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: ListView.builder(
                  controller: controller,
                  itemCount:
                      Provider.of<ProductProvider>(context, listen: false)
                          .amsItemList
                          .length,
                  // padding: EdgeInsets.symmetric(
                  //     horizontal: Dimensions.PADDING_SIZE_SMALL),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              RouteHelper.getProductDetailsRoute(
                                  Provider.of<ProductProvider>(context,
                                          listen: false)
                                      .amsItemList[index]
                                      .id),
                              arguments: ProductDetailsScreen(
                                  product: Provider.of<ProductProvider>(context,
                                          listen: false)
                                      .amsItemList[index],
                                  cart: null));
                        },
                        child: Container(
                          width: 200,
                          padding: EdgeInsets.all(
                              Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).cardColor,
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 150,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 1,
                                        color: ColorResources.getGreyColor(
                                            context)),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: FadeInImage.assetNetwork(
                                      placeholder: Images.placeholder,
                                      width: 100,
                                      height: 150,
                                      fit: BoxFit.cover,
                                      image:
                                          '${Provider.of<SplashProvider>(context, listen: false).baseUrls.productImageUrl}'
                                          '/${Provider.of<ProductProvider>(context, listen: false).amsItemList[index].image[0]}',
                                      imageErrorBuilder: (c, o, s) =>
                                          Image.asset(Images.placeholder,
                                              width: 80,
                                              height: 80,
                                              fit: BoxFit.fill),
                                    ),
                                  ),
                                ),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20.0),
                                        child: Text(
                                          Provider.of<ProductProvider>(context,
                                                  listen: false)
                                              .amsItemList[index]
                                              .name,
                                          style: poppinsMedium.copyWith(
                                              fontSize:
                                                  Dimensions.FONT_SIZE_SMALL),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: Text(
                                          '${Provider.of<ProductProvider>(context, listen: false).amsItemList[index].capacity} ${Provider.of<ProductProvider>(context, listen: false).amsItemList[index].unit}',
                                          style: poppinsRegular.copyWith(
                                              fontSize: Dimensions
                                                  .FONT_SIZE_EXTRA_SMALL),
                                        ),
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.green[900],
                                                    shape: BoxShape.rectangle,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(10),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Text(
                                                      PriceConverter
                                                          .convertPrice(
                                                        context,
                                                        Provider.of<ProductProvider>(
                                                                context,
                                                                listen: false)
                                                            .amsItemList[index]
                                                            .price,
                                                        discount: Provider.of<
                                                                    ProductProvider>(
                                                                context,
                                                                listen: false)
                                                            .amsItemList[index]
                                                            .discount,
                                                        discountType: Provider.of<
                                                                    ProductProvider>(
                                                                context,
                                                                listen: false)
                                                            .amsItemList[index]
                                                            .discountType,
                                                      ),
                                                      style: poppinsBold.copyWith(
                                                          color: Colors.white,
                                                          fontSize: Dimensions
                                                              .FONT_SIZE_SMALL),
                                                    ),
                                                  ),
                                                ),
                                                Provider.of<ProductProvider>(
                                                                context,
                                                                listen: false)
                                                            .amsItemList[index]
                                                            .discount >
                                                        0
                                                    ? Text(
                                                        PriceConverter
                                                                .convertWithDiscount(
                                                              context,
                                                              Provider.of<ProductProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .amsItemList[
                                                                      index]
                                                                  .price,
                                                              Provider.of<ProductProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .amsItemList[
                                                                      index]
                                                                  .discount,
                                                              Provider.of<ProductProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .amsItemList[
                                                                      index]
                                                                  .discountType,
                                                            ).toString() +
                                                            '.00',
                                                        style: poppinsRegular.copyWith(
                                                            fontSize: Dimensions
                                                                .FONT_SIZE_SMALL,
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                            decorationColor:
                                                                Colors.black,
                                                            color: Colors.red),
                                                      )
                                                    : SizedBox(),
                                                Provider.of<ProductProvider>(
                                                                context,
                                                                listen: false)
                                                            .amsItemList[index]
                                                            .totalStock <=
                                                        0
                                                    ? Text(
                                                        'out of stock',
                                                        style: poppinsMedium.copyWith(
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                            decorationColor:
                                                                Colors.red,
                                                            color: Theme.of(
                                                                    context)
                                                                .errorColor,
                                                            fontSize: Dimensions
                                                                .FONT_SIZE_LARGE),
                                                      )
                                                    : SizedBox()
                                              ],
                                            ),
                                            Container(
                                              margin: EdgeInsets.all(2),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: ColorResources
                                                            .getHintColor(
                                                                context)
                                                        .withOpacity(0.2)),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Icon(Icons.add,
                                                  size: 20,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          ]),
                                    ]),
                              ]),
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ])
        : SizedBox();
  }
}
