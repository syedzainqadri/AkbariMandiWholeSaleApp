import 'dart:async';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:akbarimandiwholesale/helper/responsive_helper.dart';
import 'package:akbarimandiwholesale/provider/auth_provider.dart';
import 'package:akbarimandiwholesale/provider/banner_provider.dart';
import 'package:akbarimandiwholesale/provider/banner_two_provider.dart';
import 'package:akbarimandiwholesale/provider/cart_provider.dart';
import 'package:akbarimandiwholesale/provider/category_provider.dart';
import 'package:akbarimandiwholesale/provider/chat_provider.dart';
import 'package:akbarimandiwholesale/provider/coupon_provider.dart';
import 'package:akbarimandiwholesale/provider/localization_provider.dart';
import 'package:akbarimandiwholesale/provider/location_provider.dart';
import 'package:akbarimandiwholesale/provider/notification_provider.dart';
import 'package:akbarimandiwholesale/provider/onboarding_provider.dart';
import 'package:akbarimandiwholesale/provider/order_provider.dart';
import 'package:akbarimandiwholesale/provider/product_provider.dart';
import 'package:akbarimandiwholesale/provider/profile_provider.dart';
import 'package:akbarimandiwholesale/provider/search_provider.dart';
import 'package:akbarimandiwholesale/provider/splash_provider.dart';
import 'package:akbarimandiwholesale/provider/theme_provider.dart';
import 'package:akbarimandiwholesale/helper/route_helper.dart';
import 'package:akbarimandiwholesale/theme/dark_theme.dart';
import 'package:akbarimandiwholesale/theme/light_theme.dart';
import 'package:akbarimandiwholesale/utill/app_constants.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'di_container.dart' as di;
import 'localization/app_localization.dart';
import 'helper/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    (Platform.isAndroid || Platform.isIOS)
        ? FlutterLocalNotificationsPlugin()
        : null;

Future<void> main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  int _orderID;
  try {
    // if (!kIsWeb) {
    final RemoteMessage remoteMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (remoteMessage != null) {
      _orderID = remoteMessage.notification.titleLocKey != null
          ? int.parse(remoteMessage.notification.titleLocKey)
          : null;
    }
    await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
    FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
    // }
  } catch (e) {}

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => di.sl<ThemeProvider>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<LocalizationProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<SplashProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<OnBoardingProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<CategoryProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ProductProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<SearchProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ChatProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<AuthProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<CartProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<CouponProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<LocationProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ProfileProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<OrderProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<BannerProvider>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<NotificationProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<BannerTwoProvider>()),
    ],
    child: MyApp(
      orderID: _orderID,
      isWeb: !kIsWeb,
    ),
  ));
}

class MyApp extends StatefulWidget {
  final int orderID;
  final bool isWeb;
  MyApp({@required this.orderID, @required this.isWeb});

  static final navigatorKey = new GlobalKey<NavigatorState>();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    RouteHelper.setupRouter();

    if (kIsWeb) {
      Provider.of<SplashProvider>(context, listen: false).initSharedData();
      Provider.of<CartProvider>(context, listen: false).getCartData();
      _route();
    }
  }

  void _route() {
    Provider.of<SplashProvider>(context, listen: false)
        .initConfig(context)
        .then((bool isSuccess) {
      if (isSuccess) {
        Timer(Duration(seconds: 1), () async {
          if (Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
            Provider.of<AuthProvider>(context, listen: false).updateToken();
            // Navigator.of(context).pushReplacementNamed(RouteHelper.menu, arguments: MenuScreen());
            //Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DashboardScreen()));
          } else {
            // Navigator.of(context).pushReplacementNamed(RouteHelper.onBoarding, arguments: OnBoardingScreen());
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Locale> _locals = [];
    AppConstants.languages.forEach((language) {
      _locals.add(Locale(language.languageCode, language.countryCode));
    });
    return Consumer<SplashProvider>(
      builder: (context, splashProvider, child) {
        return (kIsWeb && splashProvider.configModel == null)
            ? SizedBox()
            : MaterialApp(
                title: splashProvider.configModel != null
                    ? splashProvider.configModel.ecommerceName ?? ''
                    : AppConstants.APP_NAME,
                initialRoute: ResponsiveHelper.isMobilePhone()
                    ? widget.orderID == null
                        ? RouteHelper.splash
                        : RouteHelper.getOrderDetailsRoute(widget.orderID)
                    : Provider.of<SplashProvider>(context, listen: false)
                            .configModel
                            .maintenanceMode
                        ? RouteHelper.getMaintenanceRoute()
                        : RouteHelper.menu,
                onGenerateRoute: RouteHelper.router.generator,
                debugShowCheckedModeBanner: false,
                navigatorKey: MyApp.navigatorKey,
                theme: Provider.of<ThemeProvider>(context).darkTheme
                    ? dark
                    : light,
                locale: Provider.of<LocalizationProvider>(context).locale,
                localizationsDelegates: [
                  AppLocalization.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: _locals,
                //home: orderID == null ? SplashScreen() : OrderDetailsScreen(orderModel: null, orderId: orderID),
              );
      },
    );
  }
}
