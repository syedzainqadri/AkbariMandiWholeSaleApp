import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grocery/data/model/response/category_model.dart';
import 'package:flutter_grocery/data/model/response/product_model.dart';
import 'package:flutter_grocery/helper/responsive_helper.dart';
import 'package:flutter_grocery/helper/route_helper.dart';
import 'package:flutter_grocery/localization/language_constrants.dart';
import 'package:flutter_grocery/provider/banner_provider.dart';
import 'package:flutter_grocery/provider/banner_two_provider.dart';
import 'package:flutter_grocery/provider/category_provider.dart';
import 'package:flutter_grocery/utill/dimensions.dart';
import 'package:flutter_grocery/utill/images.dart';
import 'package:flutter_grocery/view/screens/product/product_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class BannerTwoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: ResponsiveHelper.isDesktop(context)
          ? 300
          : MediaQuery.of(context).size.width * 0.4,
      padding: EdgeInsets.only(
          top: Dimensions.PADDING_SIZE_LARGE,
          bottom: Dimensions.PADDING_SIZE_SMALL),
      child: Provider.of<BannerTwoProvider>(context, listen: false)
                  .bannerTwoList !=
              null
          ? Provider.of<BannerTwoProvider>(context, listen: false)
                      .bannerTwoList
                      .length !=
                  0
              ? Stack(
                  fit: StackFit.expand,
                  children: [
                    CarouselSlider.builder(
                      options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: true,
                        viewportFraction: 1,
                        disableCenter: true,
                        onPageChanged: (index, reason) {
                          Provider.of<BannerProvider>(context, listen: false)
                              .setCurrentIndex(index);
                        },
                      ),
                      itemCount:
                          Provider.of<BannerTwoProvider>(context, listen: false)
                                      .bannerTwoList
                                      .length ==
                                  0
                              ? 1
                              : Provider.of<BannerTwoProvider>(context,
                                      listen: false)
                                  .bannerTwoList
                                  .length,
                      itemBuilder: (context, index, _) {
                        return InkWell(
                          onTap: () {
                            if (Provider.of<BannerTwoProvider>(context,
                                        listen: false)
                                    .bannerTwoList[index]
                                    .productId !=
                                null) {
                              Product product;
                              for (Product prod
                                  in Provider.of<BannerTwoProvider>(context,
                                          listen: false)
                                      .productList) {
                                if (prod.id ==
                                    Provider.of<BannerTwoProvider>(context,
                                            listen: false)
                                        .bannerTwoList[index]
                                        .productId) {
                                  product = prod;
                                  break;
                                }
                              }
                              if (product != null) {
                                Navigator.pushNamed(
                                  context,
                                  RouteHelper.getProductDetailsRoute(
                                      product.id),
                                  arguments:
                                      ProductDetailsScreen(product: product),
                                );
                              }
                            } else if (Provider.of<BannerTwoProvider>(context,
                                        listen: false)
                                    .bannerTwoList[index]
                                    .categoryId !=
                                null) {
                              CategoryModel category;
                              for (CategoryModel categoryModel
                                  in Provider.of<CategoryProvider>(context,
                                          listen: false)
                                      .categoryList) {
                                if (categoryModel.id ==
                                    Provider.of<BannerTwoProvider>(context,
                                            listen: false)
                                        .bannerTwoList[index]
                                        .categoryId) {
                                  category = categoryModel;
                                  break;
                                }
                              }
                              if (category != null) {
                                Navigator.of(context).pushNamed(
                                  RouteHelper.getCategoryProductsRoute(
                                      category.id),
                                );
                              }
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: FadeInImage.assetNetwork(
                                placeholder: Images.placeholder,
                                image:
                                    'https://wholesale.akbarimandi.online/storage/app/public/bannertwo'
                                    '/${Provider.of<BannerTwoProvider>(context, listen: false).bannerTwoList[index].image}',
                                fit: BoxFit.cover,
                                imageErrorBuilder: (c, o, s) => Image.asset(
                                    Images.placeholder,
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                )
              : Center(
                  child: Text(getTranslated('no_banner_available', context)))
          : Shimmer(
              duration: Duration(seconds: 2),
              enabled: Provider.of<BannerTwoProvider>(context, listen: false)
                      .bannerTwoList ==
                  null,
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[300],
                  )),
            ),
    );
  }
}
