import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:akbarimandiwholesale/data/datasource/remote/dio/dio_client.dart';
import 'package:akbarimandiwholesale/data/datasource/remote/exception/api_error_handler.dart';
import 'package:akbarimandiwholesale/data/model/response/base/api_response.dart';
import 'package:akbarimandiwholesale/data/model/response/userinfo_model.dart';
import 'package:akbarimandiwholesale/utill/app_constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;
  ProfileRepo({@required this.dioClient, @required this.sharedPreferences});

  Future<ApiResponse> getAddressTypeList() async {
    try {
      List<String> addressTypeList = [
        'Select Address type',
        'Home',
        'Office',
        'Other',
      ];
      Response response = Response(
          requestOptions: RequestOptions(path: ''),
          data: addressTypeList,
          statusCode: 200);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getUserInfo() async {
    try {
      final response = await dioClient.get(AppConstants.CUSTOMER_INFO_URI);
      print('customer info is $response');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<http.StreamedResponse> updateProfile(UserInfoModel userInfoModel,
      File file, PickedFile data, String token) async {
    http.MultipartRequest request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '${AppConstants.BASE_URL}${AppConstants.UPDATE_PROFILE_URI}'));
    request.headers.addAll(<String, String>{'Authorization': 'Bearer $token'});
    if (file != null) {
      request.files.add(http.MultipartFile(
          'image', file.readAsBytes().asStream(), file.lengthSync(),
          filename: file.path.split('/').last));
    } else if (data != null) {
      Uint8List _list = await data.readAsBytes();
      http.MultipartFile part = http.MultipartFile(
          'image', data.readAsBytes().asStream(), _list.length,
          filename: basename(data.path));
      request.files.add(part);
    }
    Map<String, String> _fields = Map();
    _fields.addAll(<String, String>{
      '_method': 'put',
      'f_name': userInfoModel.fName,
      'l_name': userInfoModel.lName,
      'phone': userInfoModel.phone
    });
    request.fields.addAll(_fields);
    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<http.StreamedResponse> uploadImages(
    File file1,
    File file2,
    File file3,
    PickedFile data1,
    PickedFile data2,
    PickedFile data3,
    String token,
  ) async {
    http.MultipartRequest request = http.MultipartRequest('POST',
        Uri.parse('${AppConstants.BASE_URL}${AppConstants.UPDATE_IMAGES_URI}'));
    request.headers.addAll(<String, String>{'Authorization': 'Bearer $token'});
    if (file1 != null) {
      request.files.add(http.MultipartFile(
          'image1', file1.readAsBytes().asStream(), file1.lengthSync(),
          filename: file1.path.split('/').last));
    }
    if (file2 != null) {
      request.files.add(http.MultipartFile(
          'image2', file2.readAsBytes().asStream(), file2.lengthSync(),
          filename: file2.path.split('/').last));
    }
    if (file3 != null) {
      request.files.add(http.MultipartFile(
          'image3', file3.readAsBytes().asStream(), file3.lengthSync(),
          filename: file3.path.split('/').last));
    }
    Map<String, String> _fields = Map();
    _fields.addAll(<String, String>{
      '_method': 'put',
    });
    request.fields.addAll(_fields);
    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<http.StreamedResponse> uploadsomthing(
    File file1,
    File file2,
    File file3,
    PickedFile data1,
    PickedFile data2,
    PickedFile data3,
    String token,
  ) async {
    http.MultipartRequest request = http.MultipartRequest('POST',
        Uri.parse('${AppConstants.BASE_URL}${AppConstants.UPDATE_IMAGES_URI}'));
    request.headers.addAll(<String, String>{'Authorization': 'Bearer $token'});
    if (file1 != null) {
      request.files.add(http.MultipartFile(
          'image1', file1.readAsBytes().asStream(), file1.lengthSync(),
          filename: file1.path.split('/').last));
    } else if (data1 != null) {
      Uint8List _list = await data1.readAsBytes();
      http.MultipartFile part1 = http.MultipartFile(
          'image1', data1.readAsBytes().asStream(), _list.length,
          filename: basename(data1.path));
      request.files.add(part1);
    }
    if (file2 != null) {
      request.files.add(http.MultipartFile(
          'image1', file2.readAsBytes().asStream(), file2.lengthSync(),
          filename: file2.path.split('/').last));
    } else if (data2 != null) {
      Uint8List _list = await data2.readAsBytes();
      http.MultipartFile part2 = http.MultipartFile(
          'image1', data2.readAsBytes().asStream(), _list.length,
          filename: basename(data1.path));
      request.files.add(part2);
    }
    if (file3 != null) {
      request.files.add(http.MultipartFile(
          'image1', file3.readAsBytes().asStream(), file3.lengthSync(),
          filename: file3.path.split('/').last));
    } else if (data3 != null) {
      Uint8List _list = await data3.readAsBytes();
      http.MultipartFile part3 = http.MultipartFile(
          'image1', data3.readAsBytes().asStream(), _list.length,
          filename: basename(data3.path));
      request.files.add(part3);
    }
    Map<String, String> _fields = Map();
    _fields.addAll(<String, String>{
      '_method': 'put',
      // 'f_name': 'changed name',
      // 'l_name': 'changed name',
      // 'phone': 'changed name'
    });
    http.StreamedResponse response = await request.send();
    return response;
  }
}
