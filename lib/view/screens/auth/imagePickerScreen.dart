import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:akbarimandiwholesale/data/model/response/response_model.dart';
import 'package:akbarimandiwholesale/data/model/response/userinfo_model.dart';
import 'package:akbarimandiwholesale/helper/responsive_helper.dart';
import 'package:akbarimandiwholesale/localization/language_constrants.dart';
import 'package:akbarimandiwholesale/provider/auth_provider.dart';
import 'package:akbarimandiwholesale/provider/profile_provider.dart';
import 'package:akbarimandiwholesale/provider/splash_provider.dart';
import 'package:akbarimandiwholesale/utill/color_resources.dart';
import 'package:akbarimandiwholesale/utill/dimensions.dart';
import 'package:akbarimandiwholesale/utill/images.dart';
import 'package:akbarimandiwholesale/utill/styles.dart';
import 'package:akbarimandiwholesale/view/base/custom_snackbar.dart';
import 'package:akbarimandiwholesale/view/base/main_app_bar.dart';
import 'package:akbarimandiwholesale/view/screens/address/addresspicker.dart';
import 'package:provider/provider.dart';

class ImagePickerScreen extends StatefulWidget {
  String phone;
  String name;
  String shopname;
  ImagePickerScreen(
      {@required this.phone, @required this.name, @required this.shopname});
  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).cardColor,
      appBar: ResponsiveHelper.isDesktop(context)
          ? MainAppBar()
          : AppBar(
              backgroundColor: Theme.of(context).cardColor,
              leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios,
                      color: Theme.of(context).primaryColor),
                  onPressed: () {
                    Provider.of<SplashProvider>(context, listen: false)
                        .setPageIndex(0);
                    Navigator.of(context).pop();
                  }),
              title: Center(
                child: Text('دکان کی تصاویر اپلوڈ کریں' ?? '',
                    style: poppinsBold.copyWith(
                      fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                      color: Theme.of(context).textTheme.bodyText1.color,
                    )),
              ),
            ),
      body: SafeArea(
        child: Consumer<ProfileProvider>(
          builder: (context, profileProvider, child) => Scrollbar(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              child: Center(
                child: SizedBox(
                  width: 1170,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // for shop image1
                      Center(
                          child: Text(
                        'دکان کے بھر کی ایک تصویر ڈالیں',
                        style: poppinsBold.copyWith(
                          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                          color: Theme.of(context).textTheme.bodyText1.color,
                        ),
                      )),
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: ColorResources.getGreyColor(context),
                              width: 0),
                          shape: BoxShape.circle,
                        ),
                        child: InkWell(
                          onTap: () {
                            if (ResponsiveHelper.isMobilePhone()) {
                              profileProvider.choosePhoto1();
                            } else {
                              profileProvider.pickImage1();
                            }
                          },
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: profileProvider.file1 != null
                                    ? Image.file(profileProvider.file1,
                                        width: 300,
                                        height: 170,
                                        fit: BoxFit.cover)
                                    : profileProvider.data1 != null
                                        ? Image.network(
                                            profileProvider.data1.path,
                                            width: 300,
                                            height: 170,
                                            fit: BoxFit.cover)
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: FadeInImage.assetNetwork(
                                              placeholder: Images.placeholder,
                                              width: 300,
                                              height: 170,
                                              fit: BoxFit.cover,
                                              image: Images.placeholder,
                                              // '${Provider.of<SplashProvider>(context, listen: false).baseUrls.customerImageUrl}'
                                              //     '/${profileProvider.userInfoModel.image}',
                                              imageErrorBuilder: (c, o, s) =>
                                                  Image.asset(
                                                      Images.placeholder,
                                                      width: 300,
                                                      height: 170,
                                                      fit: BoxFit.cover),
                                            ),
                                          ),
                              ),
                              Positioned(
                                bottom: 5,
                                right: 0,
                                child: Image.asset(
                                  Images.camera,
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      //for shop image2
                      SizedBox(
                        height: 5,
                      ),
                      Center(
                          child: Text(
                        'دکان کے اندر  کی دو  تصاویر ڈالیں ',
                        style: poppinsBold.copyWith(
                          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                          color: Theme.of(context).textTheme.bodyText1.color,
                        ),
                      )),
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: ColorResources.getGreyColor(context),
                              width: 0),
                          shape: BoxShape.circle,
                        ),
                        child: InkWell(
                          onTap: () {
                            if (ResponsiveHelper.isMobilePhone()) {
                              profileProvider.choosePhoto2();
                            } else {
                              profileProvider.pickImage2();
                            }
                          },
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: profileProvider.file2 != null
                                    ? Image.file(profileProvider.file2,
                                        width: 300,
                                        height: 170,
                                        fit: BoxFit.cover)
                                    : profileProvider.data2 != null
                                        ? Image.network(
                                            profileProvider.data2.path,
                                            width: 300,
                                            height: 170,
                                            fit: BoxFit.cover)
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: FadeInImage.assetNetwork(
                                              placeholder: Images.placeholder,
                                              width: 300,
                                              height: 170,
                                              fit: BoxFit.cover,
                                              image: Images.placeholder,
                                              // '${Provider.of<SplashProvider>(context, listen: false).baseUrls.customerImageUrl}'
                                              //     '/${profileProvider.userInfoModel.image}',
                                              imageErrorBuilder: (c, o, s) =>
                                                  Image.asset(
                                                      Images.placeholder,
                                                      width: 300,
                                                      height: 170,
                                                      fit: BoxFit.cover),
                                            ),
                                          ),
                              ),
                              Positioned(
                                bottom: 5,
                                right: 0,
                                child: Image.asset(
                                  Images.camera,
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // for shop image3
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: ColorResources.getGreyColor(context),
                              width: 0),
                          shape: BoxShape.circle,
                        ),
                        child: InkWell(
                          onTap: () {
                            if (ResponsiveHelper.isMobilePhone()) {
                              profileProvider.choosePhoto3();
                            } else {
                              profileProvider.pickImage3();
                            }
                          },
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: profileProvider.file3 != null
                                    ? Image.file(profileProvider.file3,
                                        width: 300,
                                        height: 170,
                                        fit: BoxFit.cover)
                                    : profileProvider.data3 != null
                                        ? Image.network(
                                            profileProvider.data3.path,
                                            width: 300,
                                            height: 170,
                                            fit: BoxFit.cover)
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: FadeInImage.assetNetwork(
                                              placeholder: Images.placeholder,
                                              width: 300,
                                              height: 170,
                                              fit: BoxFit.cover,
                                              image: Images.placeholder,
                                              // '${Provider.of<SplashProvider>(context, listen: false).baseUrls.customerImageUrl}'
                                              //     '/${profileProvider.userInfoModel.image}',
                                              imageErrorBuilder: (c, o, s) =>
                                                  Image.asset(
                                                      Images.placeholder,
                                                      width: 300,
                                                      height: 170,
                                                      fit: BoxFit.cover),
                                            ),
                                          ),
                              ),
                              Positioned(
                                bottom: 5,
                                right: 0,
                                child: Image.asset(
                                  Images.camera,
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      !profileProvider.isLoading
                          ? TextButton(
                              onPressed: () async {
                                if (profileProvider.file1 == null &&
                                    profileProvider.data1 == null) {
                                  showCustomSnackBar(
                                      'دکان کے بھر کی ایک تصویر ڈالیں',
                                      context);
                                } else if (profileProvider.file2 == null &&
                                    profileProvider.data2 == null) {
                                  showCustomSnackBar(
                                      'دکان کے اندر  کی دو  تصاویر ڈالیں ',
                                      context);
                                } else if (profileProvider.file3 == null &&
                                    profileProvider.data3 == null) {
                                  showCustomSnackBar(
                                      'دکان کے اندر  کی دو  تصاویر ڈالیں ',
                                      context);
                                } else {
                                  await profileProvider.getUserInfo(context);
                                  UserInfoModel updateUserInfoModel =
                                      profileProvider.userInfoModel;
                                  updateUserInfoModel.fName = widget.name;
                                  updateUserInfoModel.lName = widget.shopname;
                                  updateUserInfoModel.phone = widget.phone;
                                  ResponseModel _responseModel =
                                      await profileProvider.uploadImages(
                                    profileProvider.file1,
                                    profileProvider.file2,
                                    profileProvider.file3,
                                    profileProvider.data1,
                                    profileProvider.data2,
                                    profileProvider.data3,
                                    Provider.of<AuthProvider>(context,
                                            listen: false)
                                        .getUserToken(),
                                  );
                                  if (_responseModel.isSuccess) {
                                    profileProvider.getUserInfo(context);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(getTranslated(
                                          'updated_successfully', context)),
                                      backgroundColor: Colors.green,
                                    ));
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddressPickerScreen(
                                                  phone: widget.phone,
                                                  name: widget.name,
                                                )),
                                        (route) => false);
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(_responseModel.message),
                                      backgroundColor: Colors.red,
                                    ));
                                  }
                                  setState(() {});
                                }
                              },
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    'تصاویر اپلوڈ کیجیے',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Center(
                              child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Theme.of(context).primaryColor))),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
