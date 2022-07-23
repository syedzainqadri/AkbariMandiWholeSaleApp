import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:akbarimandiwholesale/data/model/response/base/api_response.dart';
import 'package:akbarimandiwholesale/data/model/response/response_model.dart';
import 'package:akbarimandiwholesale/data/model/response/userinfo_model.dart';
import 'package:akbarimandiwholesale/data/repository/profile_repo.dart';
import 'package:akbarimandiwholesale/helper/api_checker.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ProfileProvider with ChangeNotifier {
  final ProfileRepo profileRepo;

  ProfileProvider({@required this.profileRepo});

  UserInfoModel _userInfoModel;

  UserInfoModel get userInfoModel => _userInfoModel;

  Future<ResponseModel> getUserInfo(BuildContext context) async {
    ResponseModel _responseModel;
    ApiResponse apiResponse = await profileRepo.getUserInfo();
    print('check info status ${apiResponse.response.data}');
    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
      _userInfoModel = UserInfoModel.fromJson(apiResponse.response.data);
      _responseModel = ResponseModel(true, 'successful');
    } else {
      String _errorMessage;
      if (apiResponse.error is String) {
        _errorMessage = apiResponse.error.toString();
      } else {
        _errorMessage = apiResponse.error.errors[0].message;
      }
      print(_errorMessage);
      _responseModel = ResponseModel(false, _errorMessage);
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
    return _responseModel;
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  File _file;
  PickedFile _data;

  PickedFile get data => _data;

  File get file => _file;
  final picker = ImagePicker();

  void choosePhoto() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 500,
        maxWidth: 500);
    if (pickedFile != null) {
      _file = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
    notifyListeners();
  }

  void pickImage() async {
    _data = await picker.getImage(
        source: ImageSource.gallery,
        maxHeight: 100,
        maxWidth: 100,
        imageQuality: 20);
    notifyListeners();
  }

  Future<ResponseModel> updateUserInfo(UserInfoModel updateUserModel, File file,
      PickedFile data, String token) async {
    _isLoading = true;
    notifyListeners();
    ResponseModel _responseModel;
    http.StreamedResponse response =
        await profileRepo.updateProfile(updateUserModel, file, data, token);
    _isLoading = false;
    if (response.statusCode == 200) {
      Map map = jsonDecode(await response.stream.bytesToString());
      String message = map["message"];
      _userInfoModel = updateUserModel;
      _responseModel = ResponseModel(true, message);
      print(message);
    } else {
      _responseModel = ResponseModel(
          false, '${response.statusCode} ${response.reasonPhrase}');
      print('${response.statusCode} ${response.reasonPhrase}');
    }
    notifyListeners();
    return _responseModel;
  }

  File _file1;
  PickedFile _data1;

  PickedFile get data1 => _data;

  File get file1 => _file1;
  final picker1 = ImagePicker();

  void choosePhoto1() async {
    final pickedFile = await picker1.getImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxHeight: 500,
        maxWidth: 500);
    if (pickedFile != null) {
      _file1 = File(pickedFile.path);
      print(_file1);
    } else {
      print('No image selected.');
    }
    notifyListeners();
  }

  void pickImage1() async {
    _data = await picker1.getImage(
        source: ImageSource.camera,
        maxHeight: 100,
        maxWidth: 100,
        imageQuality: 20);
    notifyListeners();
  }

  Future<ResponseModel> uploadImages(
      File file1,
      File file2,
      File file3,
      PickedFile data1,
      PickedFile data2,
      PickedFile data3,
      String token) async {
    _isLoading = true;
    notifyListeners();
    ResponseModel _responseModel;
    http.StreamedResponse response = await profileRepo.uploadImages(
      file1,
      file2,
      file3,
      data1,
      data2,
      data3,
      token,
    );
    _isLoading = false;
    if (response.statusCode == 200) {
      Map map = jsonDecode(await response.stream.bytesToString());
      String message = map["message"];
      _responseModel = ResponseModel(true, message);
      print(message);
    } else {
      _responseModel = ResponseModel(
          false, '${response.statusCode} ${response.reasonPhrase}');
      print('${response.statusCode} ${response.reasonPhrase}');
    }
    notifyListeners();
    return _responseModel;
  }

  File _file2;
  PickedFile _data2;

  PickedFile get data2 => _data;

  File get file2 => _file2;
  final picker2 = ImagePicker();

  void choosePhoto2() async {
    final pickedFile = await picker2.getImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxHeight: 500,
        maxWidth: 500);
    if (pickedFile != null) {
      _file2 = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
    notifyListeners();
  }

  void pickImage2() async {
    _data = await picker2.getImage(
        source: ImageSource.camera,
        maxHeight: 100,
        maxWidth: 100,
        imageQuality: 20);
    notifyListeners();
  }

  File _file3;
  PickedFile _data3;

  PickedFile get data3 => _data3;

  File get file3 => _file3;
  final picker3 = ImagePicker();

  void choosePhoto3() async {
    final pickedFile = await picker3.getImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxHeight: 500,
        maxWidth: 500);
    if (pickedFile != null) {
      _file3 = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
    notifyListeners();
  }

  void pickImage3() async {
    _data = await picker3.getImage(
        source: ImageSource.camera,
        maxHeight: 100,
        maxWidth: 100,
        imageQuality: 20);
    notifyListeners();
  }
}
