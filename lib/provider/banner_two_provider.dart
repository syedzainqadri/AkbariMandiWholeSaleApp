import 'package:flutter/material.dart';
import 'package:akbarimandiwholesale/data/model/response/banner_two_model.dart';
import 'package:akbarimandiwholesale/data/model/response/base/api_response.dart';
import 'package:akbarimandiwholesale/data/model/response/product_model.dart';
import 'package:akbarimandiwholesale/data/repository/banner_two_repo.dart';
import 'package:akbarimandiwholesale/helper/api_checker.dart';

class BannerTwoProvider extends ChangeNotifier {
  final BannerTwoRepo bannerTwoRepo;

  BannerTwoProvider({@required this.bannerTwoRepo});

  List<BannerTwoModel> _bannerTwoList;
  List<Product> _productList = [];
  int _currentIndex = 0;

  List<BannerTwoModel> get bannerTwoList => _bannerTwoList;
  List<Product> get productList => _productList;
  int get currentIndex => _currentIndex;

  Future<void> getBannerTwoList(BuildContext context, bool reload) async {
    if (bannerTwoList == null || reload) {
      ApiResponse apiResponse = await bannerTwoRepo.getBannerTwoList();
      if (apiResponse.response != null &&
          apiResponse.response.statusCode == 200) {
        _bannerTwoList = [];
        apiResponse.response.data.forEach((category) {
          BannerTwoModel bannerTwoModel = BannerTwoModel.fromJson(category);
          if (bannerTwoModel.productId != null) {
            getBannerDetails(context, bannerTwoModel.productId.toString());
          }
          _bannerTwoList.add(bannerTwoModel);
        });
      } else {
        ApiChecker.checkApi(context, apiResponse);
      }
      notifyListeners();
    }
  }

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void getBannerDetails(BuildContext context, String productID) async {
    ApiResponse apiResponse = await bannerTwoRepo.getBannerDetails(productID);
    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
      _bannerTwoList.add(BannerTwoModel.fromJson(apiResponse.response.data));
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
  }
}
