import 'package:akbarimandiwholesale/data/model/response/userinfo_model.dart';
import 'package:akbarimandiwholesale/provider/profile_provider.dart';
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
  bool isActive = true;
  Future<void> _loadData(BuildContext context, bool reload) async {
    await Provider.of<CategoryProvider>(context, listen: false).getCategoryList(
      context,
      Provider.of<LocalizationProvider>(context, listen: false)
          .locale
          .languageCode,
      reload,
    );
    await Provider.of<BannerTwoProvider>(context, listen: false)
        .getBannerTwoList(context, reload);
    await Provider.of<ProductProvider>(context, listen: false).getDailyItemList(
      context,
      reload,
      Provider.of<LocalizationProvider>(context, listen: false)
          .locale
          .languageCode,
    );
    await Provider.of<ProfileProvider>(context, listen: false)
        .getUserInfo(context);
    setState(() {
      isLoading = false;
    });
  }

  Future<void> getActiveStatus() async {
    await Provider.of<ProfileProvider>(context, listen: false)
        .getUserInfo(context);
    if (Provider.of<ProfileProvider>(context, listen: false)
            .userInfoModel
            .isActive ==
        0) {
      setState(() {
        isActive = false;
      });
    }
  }

  @override
  void initState() {
    _loadData(context, false);
    getActiveStatus();
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
      child: isActive == true
          ? Scaffold(
              appBar: ResponsiveHelper.isDesktop(context) ? MainAppBar() : null,
              body: Scrollbar(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Center(
                    child: SizedBox(
                      width: 1170,
                      child: Column(children: [
                        BannerTwoView(),
                        CategoryView(),
                      ]),
                    ),
                  ),
                ),
              ),
            )
          : Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'جوائن کرنے کا شکریہ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                      child: Text('براے مہربانی انتظار کیجیے',
                          style: TextStyle(fontSize: 20))),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                      child: Text('آپکا اکاؤنٹ رویو کیا جا رہا ہے',
                          style: TextStyle(fontSize: 20))),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                      child: Text('آپسے جلد رابطہ کیا جائے گا',
                          style: TextStyle(fontSize: 20))),
                ],
              ),
            ),
    );
  }
}
