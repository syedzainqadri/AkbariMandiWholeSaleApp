import 'package:flutter/material.dart';
import 'package:akbarimandiwholesale/helper/product_type.dart';
import 'package:akbarimandiwholesale/helper/responsive_helper.dart';
import 'package:akbarimandiwholesale/localization/language_constrants.dart';
import 'package:akbarimandiwholesale/provider/banner_provider.dart';
import 'package:akbarimandiwholesale/provider/banner_two_provider.dart';
import 'package:akbarimandiwholesale/provider/category_provider.dart';
import 'package:akbarimandiwholesale/provider/localization_provider.dart';
import 'package:akbarimandiwholesale/provider/product_provider.dart';
import 'package:akbarimandiwholesale/utill/dimensions.dart';
import 'package:akbarimandiwholesale/view/base/main_app_bar.dart';
import 'package:akbarimandiwholesale/view/base/title_widget.dart';
import 'package:akbarimandiwholesale/view/screens/home/widget/ams_list_view.dart';
import 'package:akbarimandiwholesale/view/screens/home/widget/banners_view.dart';
import 'package:akbarimandiwholesale/view/screens/home/widget/category_view.dart';
import 'package:akbarimandiwholesale/view/screens/home/widget/daily_item_view.dart';
import 'package:akbarimandiwholesale/view/screens/home/widget/product_view.dart';
import 'package:provider/provider.dart';
import 'widget/banners_two_view.dart';
import 'widget/cat_with_sub_on_home.dart';
import 'widget/fresh_item_view.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  Future<void> _loadData(BuildContext context, bool reload) async {
    await Provider.of<CategoryProvider>(context, listen: false).getCategoryList(
      context,
      Provider.of<LocalizationProvider>(context, listen: false)
          .locale
          .languageCode,
      reload,
    );
    // await Provider.of<BannerProvider>(context, listen: false)
    //     .getBannerList(context, reload);
    await Provider.of<BannerTwoProvider>(context, listen: false)
        .getBannerTwoList(context, reload);
    await Provider.of<ProductProvider>(context, listen: false).getDailyItemList(
      context,
      reload,
      Provider.of<LocalizationProvider>(context, listen: false)
          .locale
          .languageCode,
    );
    // await Provider.of<CategoryProvider>(context, listen: false).getBrands(
    //   context,
    // );
    // await Provider.of<ProductProvider>(context, listen: false).getFreshItemList(
    //   context,
    //   reload,
    //   Provider.of<LocalizationProvider>(context, listen: false)
    //       .locale
    //       .languageCode,
    // );
    // await Provider.of<ProductProvider>(context, listen: false).getAmsItemList(
    //   context,
    //   reload,
    //   Provider.of<LocalizationProvider>(context, listen: false)
    //       .locale
    //       .languageCode,
    // );
    // Provider.of<ProductProvider>(context, listen: false).getPopularProductList(
    //   context,
    //   '1',
    //   reload,
    //   Provider.of<LocalizationProvider>(context, listen: false)
    //       .locale
    //       .languageCode,
    // );

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    _loadData(context, false);
    super.initState();
  }

  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    final ScrollController _scrollController2 = ScrollController();

    return RefreshIndicator(
      onRefresh: () async {
        await _loadData(context, true);
      },
      backgroundColor: Theme.of(context).primaryColor,
      child: Scaffold(
        appBar: ResponsiveHelper.isDesktop(context) ? MainAppBar() : null,
        body: Scrollbar(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Center(
              child: SizedBox(
                width: 1170,
                child: Column(children: [
                  BannerTwoView(),
                  // Category
                  CategoryView(),
                  // Banner Two

                  // daily item view
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 12.0),
                  //   child: DailyItemView(),
                  // ),
                  // Ams Item View
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 12.0),
                  //   child: AmsItemView(),
                  // ),
                  // Fresh Items
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 12.0),
                  //   child: FreshItemView(),
                  // ),
                  //All Categories with sub Categories
                  // CatwithSubCatonHome(),
                  // Popular Item
                  // Padding(
                  //   padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  //   child: TitleWidget(
                  //       title: getTranslated('popular_item', context)),
                  // ),
                  // ProductView(
                  //     productType: ProductType.POPULAR_PRODUCT,
                  //     scrollController: _scrollController2),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
