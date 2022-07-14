import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:akbarimandiwholesale/data/datasource/remote/dio/dio_client.dart';
import 'package:akbarimandiwholesale/data/datasource/remote/exception/api_error_handler.dart';
import 'package:akbarimandiwholesale/data/model/response/base/api_response.dart';
import 'package:akbarimandiwholesale/data/model/response/onboarding_model.dart';
import 'package:akbarimandiwholesale/localization/language_constrants.dart';
import 'package:akbarimandiwholesale/utill/images.dart';

class OnBoardingRepo {
  final DioClient dioClient;

  OnBoardingRepo({@required this.dioClient});

  Future<ApiResponse> getOnBoardingList(BuildContext context) async {
    try {
      List<OnBoardingModel> onBoardingList = [
        OnBoardingModel(
            Images.on_boarding_1,
            'مندی آپکے ہاتھ میں',
            getTranslated('onboarding_1_text', context),
            'روزانہ کے ہول سیل ریٹ ',
            'مندی سے بھی سستا'),
        OnBoardingModel(
            Images.on_boarding_2,
            'اب منڈی کیوں جائیں',
            getTranslated('onboarding_2_text', context),
            'روزانہ کی بنیاد پہ بدلتے ہول سیل ریٹ چیک کریں',
            'اپنے وقت کے مطابق آرڈر کریں'),
        OnBoardingModel(
            Images.on_boarding_3,
            'وقت بچائیں پیسہ بچائیں فائدہ اٹھائیں',
            getTranslated('onboarding_3_text', context),
            'منڈی سے اپنے اسٹور پر مال حاصل کریں',
            'ہر آرڈر کرنے پر دوسرے دن ڈیلیوری حاصل کریں'),
      ];

      Response response = Response(
          requestOptions: RequestOptions(path: ''),
          data: onBoardingList,
          statusCode: 200);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
