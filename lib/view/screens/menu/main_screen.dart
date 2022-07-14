import 'package:flutter/material.dart';
import 'package:akbarimandiwholesale/helper/html_type.dart';
import 'package:akbarimandiwholesale/helper/responsive_helper.dart';
import 'package:akbarimandiwholesale/helper/route_helper.dart';
import 'package:akbarimandiwholesale/localization/language_constrants.dart';
import 'package:akbarimandiwholesale/provider/auth_provider.dart';
import 'package:akbarimandiwholesale/provider/cart_provider.dart';
import 'package:akbarimandiwholesale/provider/location_provider.dart';
import 'package:akbarimandiwholesale/provider/profile_provider.dart';
import 'package:akbarimandiwholesale/provider/splash_provider.dart';
import 'package:akbarimandiwholesale/utill/app_constants.dart';
import 'package:akbarimandiwholesale/utill/dimensions.dart';
import 'package:akbarimandiwholesale/utill/images.dart';
import 'package:akbarimandiwholesale/utill/styles.dart';
import 'package:akbarimandiwholesale/view/screens/address/address_screen.dart';
import 'package:akbarimandiwholesale/view/screens/cart/cart_screen.dart';
import 'package:akbarimandiwholesale/view/screens/category/all_category_screen.dart';
import 'package:akbarimandiwholesale/view/screens/chat/chat_screen.dart';
import 'package:akbarimandiwholesale/view/screens/coupon/coupon_screen.dart';
import 'package:akbarimandiwholesale/view/screens/home/home_screen.dart';
import 'package:akbarimandiwholesale/view/screens/html/html_viewer_screen.dart';
import 'package:akbarimandiwholesale/view/screens/menu/widget/custom_drawer.dart';
import 'package:akbarimandiwholesale/view/screens/order/my_order_screen.dart';
import 'package:akbarimandiwholesale/view/screens/settings/setting_screen.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  final CustomDrawerController drawerController;
  MainScreen({@required this.drawerController});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> _screens = [];
  List<String> _keys = [];

  @override
  void initState() {
    super.initState();

    final bool _isLoggedIn =
        Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
    if (_isLoggedIn) {
      Provider.of<ProfileProvider>(context, listen: false).getUserInfo(context);
      Provider.of<LocationProvider>(context, listen: false)
          .initAddressList(context);
    } else {
      Provider.of<CartProvider>(context, listen: false).getCartData();
    }
    //ResponsiveHelper.isWeb() ? SizedBox() : NetworkInfo.checkConnectivity(context);

    _screens = [
      HomeScreen(),
      AllCategoryScreen(),
      CartScreen(),
      MyOrderScreen(),
      AddressScreen(),
      CouponScreen(),
      ChatScreen(),
      SettingsScreen(),
      HtmlViewerScreen(htmlType: HtmlType.TERMS_AND_CONDITION),
      HtmlViewerScreen(htmlType: HtmlType.PRIVACY_POLICY),
      HtmlViewerScreen(htmlType: HtmlType.ABOUT_US),
    ];
    _keys = [
      'home',
      'all_categories',
      'shopping_bag',
      'my_order',
      'address',
      'coupon',
      'live_chat',
      'settings',
      'terms_and_condition',
      'privacy_policy',
      'about_us',
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SplashProvider>(
      builder: (context, splash, child) {
        return WillPopScope(
          onWillPop: () async {
            if (splash.pageIndex != 0) {
              splash.setPageIndex(0);
              return false;
            } else {
              return true;
            }
          },
          child: Consumer<LocationProvider>(
            builder: (context, locationProvider, child) => Scaffold(
              appBar: ResponsiveHelper.isDesktop(context)
                  ? null
                  : AppBar(
                      backgroundColor: Theme.of(context).cardColor,
                      leading: IconButton(
                          icon: Image.asset(Images.more_icon,
                              color: Theme.of(context).primaryColor,
                              height: 30,
                              width: 30),
                          onPressed: () {
                            widget.drawerController.toggle();
                          }),
                      title: splash.pageIndex == 0
                          ? Row(children: [
                              Image.asset(Images.app_logo, width: 25),
                              SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                              Expanded(
                                  child: Text(
                                AppConstants.APP_NAME,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: poppinsMedium.copyWith(
                                    fontSize: 16,
                                    color: Theme.of(context).primaryColor),
                              )),
                            ])
                          : Text(
                              getTranslated(_keys[splash.pageIndex], context),
                              style: poppinsMedium.copyWith(
                                  fontSize: Dimensions.FONT_SIZE_LARGE,
                                  color: Theme.of(context).primaryColor),
                            ),
                      actions: splash.pageIndex == 0
                          ? [
                              IconButton(
                                  icon:
                                      Stack(clipBehavior: Clip.none, children: [
                                    Image.asset(Images.cart_icon,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .color,
                                        width: 25),
                                    Positioned(
                                      top: -7,
                                      right: -2,
                                      child: Container(
                                        padding: EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                Theme.of(context).primaryColor),
                                        child: Text(
                                            '${Provider.of<CartProvider>(context).cartList.length}',
                                            style: TextStyle(
                                                color:
                                                    Theme.of(context).cardColor,
                                                fontSize: 10)),
                                      ),
                                    ),
                                  ]),
                                  onPressed: () {
                                    ResponsiveHelper.isMobilePhone()
                                        ? splash.setPageIndex(2)
                                        : Navigator.pushNamed(
                                            context, RouteHelper.cart);
                                  }),
                              IconButton(
                                  icon: Icon(Icons.search,
                                      size: 30,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .color),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, RouteHelper.searchProduct);
                                  }),
                            ]
                          : splash.pageIndex == 2
                              ? [
                                  Center(
                                      child: Text(
                                          '${Provider.of<CartProvider>(context, listen: false).cartList.length} ${getTranslated('items', context)}',
                                          style: poppinsMedium.copyWith(
                                              color: Theme.of(context)
                                                  .primaryColor))),
                                  SizedBox(width: 20)
                                ]
                              : null,
                    ),
              body: _screens[splash.pageIndex],
            ),
          ),
        );
      },
    );
  }
}
