import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:akbarimandiwholesale/data/model/response/category_model.dart';
import 'package:akbarimandiwholesale/data/model/response/product_model.dart';
import 'package:akbarimandiwholesale/helper/responsive_helper.dart';
import 'package:akbarimandiwholesale/helper/route_helper.dart';
import 'package:akbarimandiwholesale/localization/language_constrants.dart';
import 'package:akbarimandiwholesale/provider/banner_provider.dart';
import 'package:akbarimandiwholesale/provider/category_provider.dart';
import 'package:akbarimandiwholesale/provider/splash_provider.dart';
import 'package:akbarimandiwholesale/utill/color_resources.dart';
import 'package:akbarimandiwholesale/utill/dimensions.dart';
import 'package:akbarimandiwholesale/utill/images.dart';
import 'package:akbarimandiwholesale/view/screens/product/product_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class BannersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: ResponsiveHelper.isDesktop(context)
          ? 300
          : MediaQuery.of(context).size.width * 0.4,
      // height: MediaQuery.of(context).size.width * 0.4,
      padding: EdgeInsets.only(
          top: Dimensions.PADDING_SIZE_LARGE,
          bottom: Dimensions.PADDING_SIZE_SMALL),
      child: Provider.of<BannerProvider>(context, listen: false).bannerList !=
              null
          ? Provider.of<BannerProvider>(context, listen: false)
                      .bannerList
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
                      itemCount: Provider.of<BannerProvider>(context,
                                      listen: false)
                                  .bannerList
                                  .length ==
                              0
                          ? 1
                          : Provider.of<BannerProvider>(context, listen: false)
                              .bannerList
                              .length,
                      itemBuilder: (context, index, _) {
                        return InkWell(
                          onTap: () {
                            if (Provider.of<BannerProvider>(context,
                                        listen: false)
                                    .bannerList[index]
                                    .productId !=
                                null) {
                              Product product;
                              for (Product prod in Provider.of<BannerProvider>(
                                      context,
                                      listen: false)
                                  .productList) {
                                if (prod.id ==
                                    Provider.of<BannerProvider>(context,
                                            listen: false)
                                        .bannerList[index]
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
                            } else if (Provider.of<BannerProvider>(context,
                                        listen: false)
                                    .bannerList[index]
                                    .categoryId !=
                                null) {
                              CategoryModel category;
                              for (CategoryModel categoryModel
                                  in Provider.of<CategoryProvider>(context,
                                          listen: false)
                                      .categoryList) {
                                if (categoryModel.id ==
                                    Provider.of<BannerProvider>(context,
                                            listen: false)
                                        .bannerList[index]
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
                                    '${Provider.of<SplashProvider>(context, listen: false).baseUrls.bannerImageUrl}'
                                    '/${Provider.of<BannerProvider>(context, listen: false).bannerList[index].image}',
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
              enabled: Provider.of<BannerProvider>(context, listen: false)
                      .bannerList ==
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
