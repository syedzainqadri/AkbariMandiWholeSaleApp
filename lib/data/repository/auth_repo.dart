import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:akbarimandiwholesale/data/datasource/remote/dio/dio_client.dart';
import 'package:akbarimandiwholesale/data/datasource/remote/exception/api_error_handler.dart';
import 'package:akbarimandiwholesale/data/model/response/base/api_response.dart';
import 'package:akbarimandiwholesale/data/model/response/signup_model.dart';
import 'package:akbarimandiwholesale/helper/responsive_helper.dart';
import 'package:akbarimandiwholesale/utill/app_constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;

class AuthRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({@required this.dioClient, @required this.sharedPreferences});

  Future<ApiResponse> registration(SignUpModel signUpModel) async {
    try {
      print(signUpModel.cnic);
      print(signUpModel.toJson());
      Response response = await dioClient.post(
        AppConstants.REGISTER_URI,
        data: signUpModel.toJson(),
      );
      print(response.data);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> login({String email, String password}) async {
    try {
      print({"email": email, "email_or_phone": email, "password": password});
      Response response = await dioClient.post(
        'https://wholesale.akbarimandi.online/api/v1/auth/login?email=$email&password=$password&email_or_phone=$email',
        // AppConstants.LOGIN_URI,
        // data: {"email": email, "email_or_phone": email, "password": password},
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  // Future<ApiResponse> loginWithFirebase({
  //   String token,
  // }) async {
  //   try {
  //     print({
  //       "email": token,
  //     });
  //     Response response = await dioClient.post(
  //       'https://wholesale.akbarimandi.online/api/v1/auth/firebase-login?token=$token',
  //       // AppConstants.LOGIN_URI,
  //       // data: {"email": email, "email_or_phone": email, "password": password},
  //     );
  //     print('response is $response');
  //     return ApiResponse.withSuccess(response);
  //   } catch (e) {
  //     return ApiResponse.withError(ApiErrorHandler.getMessage(e));
  //   }
  // }

  Future<ApiResponse> loginWithFirebase({
    String uid,
  }) async {
    try {
      Response response = await dioClient.post(
        'https://wholesale.akbarimandi.online/api/v1/auth/firebase-login-uid?uid=$uid',
      );
      print('response is $response');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  // https://wholesale.akbarimandi.online/api/v1/auth/firebase-login-uid?uid=

  // for forgot password
  Future<ApiResponse> forgetPassword(String email) async {
    try {
      Response response = await dioClient.post(AppConstants.FORGET_PASSWORD_URI,
          data: {"email": email, "email_or_phone": email});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> resetPassword(String mail, String resetToken,
      String password, String confirmPassword) async {
    try {
      print({
        "_method": "put",
        "reset_token": resetToken,
        "password": password,
        "confirm_password": confirmPassword,
        "email_or_phone": mail,
        "email": mail
      });
      Response response = await dioClient.post(
        AppConstants.RESET_PASSWORD_URI,
        data: {
          "_method": "put",
          "reset_token": resetToken,
          "password": password,
          "confirm_password": confirmPassword,
          "email_or_phone": mail,
          "email": mail
        },
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  // for verify phone number
  Future<ApiResponse> checkEmail(String email) async {
    try {
      Response response = await dioClient
          .post(AppConstants.CHECK_EMAIL_URI, data: {"email": email});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> verifyEmail(String email, String token) async {
    try {
      Response response = await dioClient.post(AppConstants.VERIFY_EMAIL_URI,
          data: {"email": email, "token": token});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  // phone
  //verify phone number

  Future<ApiResponse> checkPhone(String phone) async {
    try {
      Response response = await dioClient
          .post(AppConstants.CHECK_PHONE_URI + phone, data: {"phone": phone});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> verifyPhone(String phone, String token) async {
    try {
      Response response = await dioClient.post(AppConstants.VERIFY_PHONE_URI,
          data: {"phone": phone.trim(), "token": token});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> verifyToken(String email, String token) async {
    try {
      print({"email": email, "reset_token": token});
      Response response = await dioClient.post(AppConstants.VERIFY_TOKEN_URI,
          data: {
            "email": email,
            "email_or_phone": email,
            "reset_token": token
          });
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  // for  user token
  Future<void> saveUserToken(String token) async {
    dioClient.token = token;
    dioClient.dio.options.headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };

    try {
      await sharedPreferences.setString(AppConstants.TOKEN, token);
    } catch (e) {
      throw e;
    }
  }

  Future<ApiResponse> updateToken() async {
    try {
      String _deviceToken = '';
      if (ResponsiveHelper.isMobilePhone()) {
        _deviceToken = await _saveDeviceToken();
        FirebaseMessaging.instance.subscribeToTopic(AppConstants.TOPIC);
      }
      Response response = await dioClient.put(
        'https://wholesale.akbarimandi.online/api/v1/customer/cm-firebase-token?cm_firebase_token=$_deviceToken',
        // AppConstants.TOKEN_URI,
        // data: {"_method": "put", "cm_firebase_token": _deviceToken},
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> saveUID(id) async {
    try {
      Response response = await dioClient.put(
        'https://wholesale.akbarimandi.online/api/v1/customer/cm-user-uid?cm_user_uid=$id',
        // AppConstants.TOKEN_URI,
        // data: {"_method": "put", "cm_firebase_token": _deviceToken},
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<String> _saveDeviceToken() async {
    String _deviceToken = '';
    if (Platform.isAndroid) {
      _deviceToken = await FirebaseMessaging.instance.getToken();
      print('device token is: $_deviceToken');
      Response response = await dioClient.put(
        'https://wholesale.akbarimandi.online/api/v1/customer/cm-firebase-token?cm_firebase_token=$_deviceToken',
        // AppConstants.TOKEN_URI,
        // data: {"_method": "put", "cm_firebase_token": _deviceToken},
      );
    } else if (Platform.isIOS) {
      _deviceToken = await FirebaseMessaging.instance.getAPNSToken();
    }
    if (_deviceToken != null) {
      print('--------Device Token---------- ' + _deviceToken);
    }
    return _deviceToken;
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "";
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  Future<bool> clearSharedData() async {
    // if(!kIsWeb) {
    await sharedPreferences.remove(AppConstants.TOKEN);
    await sharedPreferences.remove(AppConstants.CART_LIST);
    await sharedPreferences.remove(AppConstants.USER_ADDRESS);
    await sharedPreferences.remove(AppConstants.SEARCH_ADDRESS);
    await sharedPreferences.remove(AppConstants.USER_NUMBER);
    await sharedPreferences.remove(AppConstants.USER_PASSWORD);
    await FirebaseMessaging.instance.unsubscribeFromTopic(AppConstants.TOPIC);
    // }
    // await sharedPreferences.remove(AppConstants.TOKEN);
    // await sharedPreferences.remove(AppConstants.CART_LIST);
    // await sharedPreferences.remove(AppConstants.USER_ADDRESS);
    // await sharedPreferences.remove(AppConstants.SEARCH_ADDRESS);
    return true;
  }

  // for  Remember Email
  Future<void> saveUserNumberAndPassword(String number, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.USER_PASSWORD, password);
      await sharedPreferences.setString(AppConstants.USER_NUMBER, number);
    } catch (e) {
      throw e;
    }
  }

  String getUserNumber() {
    return sharedPreferences.getString(AppConstants.USER_NUMBER) ?? "";
  }

  String getUserPassword() {
    return sharedPreferences.getString(AppConstants.USER_PASSWORD) ?? "";
  }

  Future<bool> clearUserNumberAndPassword() async {
    await sharedPreferences.remove(AppConstants.USER_PASSWORD);
    return await sharedPreferences.remove(AppConstants.USER_NUMBER);
  }
}
