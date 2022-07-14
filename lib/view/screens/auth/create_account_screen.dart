import 'dart:io';

import 'package:country_code_picker/country_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:akbarimandiwholesale/data/model/response/signup_model.dart';
import 'package:akbarimandiwholesale/helper/email_checker.dart';
import 'package:akbarimandiwholesale/helper/responsive_helper.dart';
import 'package:akbarimandiwholesale/helper/route_helper.dart';
import 'package:akbarimandiwholesale/localization/language_constrants.dart';
import 'package:akbarimandiwholesale/provider/auth_provider.dart';
import 'package:akbarimandiwholesale/provider/splash_provider.dart';
import 'package:akbarimandiwholesale/utill/color_resources.dart';
import 'package:akbarimandiwholesale/utill/dimensions.dart';
import 'package:akbarimandiwholesale/utill/styles.dart';
import 'package:akbarimandiwholesale/view/base/custom_button.dart';
import 'package:akbarimandiwholesale/view/base/custom_snackbar.dart';
import 'package:akbarimandiwholesale/view/base/custom_text_field.dart';
import 'package:akbarimandiwholesale/view/base/idCard_Input_Field.dart';
import 'package:akbarimandiwholesale/view/base/main_app_bar.dart';
import 'package:akbarimandiwholesale/view/screens/auth/imagePickerScreen.dart';
import 'package:akbarimandiwholesale/view/screens/auth/login_screen.dart';
import 'package:provider/provider.dart';

class CreateAccountScreen extends StatelessWidget {
  var id;
  var phone;
  CreateAccountScreen({this.phone, this.id, Key key}) : super(key: key);
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _cnicFocus = FocusNode();
  // final FocusNode _emailFocus = FocusNode();
  final FocusNode _numberFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _cnicController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  // final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String cnic;

  @override
  Widget build(BuildContext context) {
    String _countryDialCode = CountryCode.fromCountryCode(
            Provider.of<SplashProvider>(context, listen: false)
                .configModel
                .country)
        .dialCode;
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: ResponsiveHelper.isDesktop(context) ? MainAppBar() : null,
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) => SafeArea(
          child: Scrollbar(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
              physics: BouncingScrollPhysics(),
              child: Center(
                child: Container(
                  width: _width > 700 ? 700 : _width,
                  padding: _width > 700
                      ? EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT)
                      : null,
                  decoration: _width > 700
                      ? BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[300],
                                blurRadius: 5,
                                spreadRadius: 1)
                          ],
                        )
                      : null,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30),
                      Center(
                          child: Text(
                        getTranslated('create_account', context),
                        style: poppinsMedium.copyWith(
                            fontSize: 24,
                            color: ColorResources.getTextColor(context)),
                      )),
                      SizedBox(height: 30),
                      // for first name section
                      Text(
                        getTranslated('first_name', context),
                        style: poppinsRegular.copyWith(
                            color: ColorResources.getHintColor(context)),
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      CustomTextField(
                        hintText: 'آپنا پورا نام درج کیجیے',
                        isShowBorder: true,
                        controller: _firstNameController,
                        focusNode: _firstNameFocus,
                        nextFocus: _lastNameFocus,
                        inputType: TextInputType.name,
                        capitalization: TextCapitalization.words,
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                      // for last name section
                      Text(
                        getTranslated('last_name', context),
                        style: poppinsRegular.copyWith(
                            color: ColorResources.getHintColor(context)),
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      CustomTextField(
                        hintText: 'دکان کا نام درج کیجیے',
                        isShowBorder: true,
                        controller: _lastNameController,
                        focusNode: _lastNameFocus,
                        nextFocus: _cnicFocus,
                        inputType: TextInputType.name,
                        capitalization: TextCapitalization.words,
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                      // for last name section
                      Text(
                        'شناختی کارڈ نمبر',
                        style: poppinsRegular.copyWith(
                            color: ColorResources.getHintColor(context)),
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      IdCardInputField(
                        hintText: 'شناختی کارڈ نمبر درج کیجیے',
                        isShowBorder: true,
                        controller: _cnicController,
                        focusNode: _cnicFocus,
                        nextFocus: _numberFocus,
                        inputType: TextInputType.number,
                        onChanged: (value) {
                          cnic = value;
                        },
                      ),
                      // Container(
                      //   height: 50,
                      //   decoration: BoxDecoration(
                      //     border: Border.all(
                      //         color: ColorResources.getHintColor(context)),
                      //     borderRadius: BorderRadius.circular(10),
                      //     color: Colors.white,
                      //   ),
                      //   alignment: Alignment.center,
                      //   child: TextField(
                      //     onChanged: (value) {
                      //       cnic = value;
                      //     },
                      //     cursorColor: Colors.black,
                      //     keyboardType: TextInputType.number,
                      //     maxLength: 15,
                      //     decoration: InputDecoration(
                      //       hintText: 'قومی شناختی کارڈ نمبر درج کریں',
                      //       border: InputBorder.none,
                      //     ),
                      //     inputFormatters: [
                      //       FilteringTextInputFormatter.digitsOnly,
                      //       _mobileFormatter
                      //     ],
                      //   ),
                      // ),
                      // CustomTextField(
                      //   hintText: 'قومی شناختی کارڈ نمبر درج کریں',
                      //   isShowBorder: true,
                      //   controller: _cnicController,
                      //   focusNode: _cnicFocus,
                      //   nextFocus: _passwordFocus,
                      //   inputType: TextInputType.number,
                      //   capitalization: TextCapitalization.words,
                      // ),
                      SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                      // for password section
                      Text(
                        getTranslated('password', context),
                        style: poppinsRegular.copyWith(
                            color: ColorResources.getHintColor(context)),
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      CustomTextField(
                        hintText: getTranslated('password_hint', context),
                        isShowBorder: true,
                        isPassword: true,
                        controller: _passwordController,
                        focusNode: _passwordFocus,
                        nextFocus: _confirmPasswordFocus,
                        isShowSuffixIcon: true,
                      ),

                      SizedBox(height: 22),
                      // for confirm password section
                      Text(
                        getTranslated('confirm_password', context),
                        style: poppinsRegular.copyWith(
                            color: ColorResources.getHintColor(context)),
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      CustomTextField(
                        hintText: getTranslated('password_hint', context),
                        isShowBorder: true,
                        isPassword: true,
                        controller: _confirmPasswordController,
                        focusNode: _confirmPasswordFocus,
                        isShowSuffixIcon: true,
                        inputAction: TextInputAction.done,
                      ),

                      SizedBox(height: 22),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          authProvider.registrationErrorMessage.length > 0
                              ? CircleAvatar(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  radius: 5)
                              : SizedBox.shrink(),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              authProvider.registrationErrorMessage ?? "",
                              style: poppinsRegular.copyWith(
                                fontSize: Dimensions.FONT_SIZE_SMALL,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          )
                        ],
                      ),

                      // for signup button
                      SizedBox(height: 10),
                      !authProvider.isLoading
                          ? CustomButton(
                              buttonText: getTranslated('signup', context),
                              onPressed: () {
                                String _cnic = cnic;
                                print('cnic is : $_cnic');
                                String _firstName =
                                    _firstNameController.text.trim();
                                String _lastName =
                                    _lastNameController.text.trim();
                                String _number = _numberController.text.trim();
                                String _email = _numberController.text.trim();
                                String _password =
                                    _passwordController.text.trim();
                                String _confirmPassword =
                                    _confirmPasswordController.text.trim();
                                if (Provider.of<SplashProvider>(context,
                                        listen: false)
                                    .configModel
                                    .emailVerification) {
                                  if (_firstName.isEmpty) {
                                    showCustomSnackBar(
                                        getTranslated(
                                            'enter_first_name', context),
                                        context);
                                  } else if (_lastName.isEmpty) {
                                    showCustomSnackBar(
                                        getTranslated(
                                            'enter_last_name', context),
                                        context);
                                  } else if (_password.isEmpty) {
                                    showCustomSnackBar(
                                        getTranslated(
                                            'enter_password', context),
                                        context);
                                  } else if (_password.length < 6) {
                                    showCustomSnackBar(
                                        getTranslated(
                                            'password_should_be', context),
                                        context);
                                  } else if (_confirmPassword.isEmpty) {
                                    showCustomSnackBar(
                                        getTranslated(
                                            'enter_confirm_password', context),
                                        context);
                                  } else if (_password != _confirmPassword) {
                                    showCustomSnackBar(
                                        getTranslated(
                                            'password_did_not_match', context),
                                        context);
                                  } else if (_cnic.isEmpty) {
                                    showCustomSnackBar(
                                        'Please enter CNIC', context);
                                  } else {
                                    SignUpModel signUpModel = SignUpModel(
                                      fName: _firstName,
                                      lName: _lastName,
                                      password: _password,
                                      phone: this.phone,
                                      cnic: _cnic,
                                    );
                                    print(
                                        'cnic in model is: ${signUpModel.cnic}');
                                    authProvider
                                        .registration(signUpModel, id)
                                        .then((status) async {
                                      if (status.isSuccess) {
                                        var name = _firstName + _lastName;
                                        print(
                                            "Data at the time of Navigation to Address picker is $name + $phone");
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ImagePickerScreen(
                                                      phone: phone,
                                                      name: name,
                                                      shopname: _lastName,
                                                    )),
                                            (route) => false);
                                      }
                                    });
                                  }
                                } else {
                                  if (_firstName.isEmpty) {
                                    showCustomSnackBar(
                                        getTranslated(
                                            'enter_first_name', context),
                                        context);
                                  } else if (_lastName.isEmpty) {
                                    showCustomSnackBar(
                                        'دکان کا نام درج کریں', context);
                                  } else if (_cnic.isEmpty) {
                                    showCustomSnackBar(
                                        'شناختی کارڈ کا نمبر درج کریں',
                                        context);
                                  } else if (_cnic.length != 15) {
                                    showCustomSnackBar(
                                        'شناختی کارڈ کا نمبر 13 رقمی نہیں ہے',
                                        context);
                                  } else if (_password.isEmpty) {
                                    showCustomSnackBar(
                                        getTranslated(
                                            'enter_password', context),
                                        context);
                                  } else if (_password.length < 6) {
                                    showCustomSnackBar(
                                        getTranslated(
                                            'password_should_be', context),
                                        context);
                                  } else if (_confirmPassword.isEmpty) {
                                    showCustomSnackBar(
                                        getTranslated(
                                            'enter_confirm_password', context),
                                        context);
                                  } else if (_password != _confirmPassword) {
                                    showCustomSnackBar(
                                        getTranslated(
                                            'password_did_not_match', context),
                                        context);
                                  } else {
                                    var number = authProvider.email.trim();
                                    var _number = number.substring(1);
                                    print(_number);
                                    SignUpModel signUpModel = SignUpModel(
                                      fName: _firstName,
                                      lName: _lastName,
                                      email: _number,
                                      password: _password,
                                      phone: authProvider.email.trim(),
                                      cnic: _cnic,
                                    );
                                    authProvider
                                        .registration(signUpModel, id)
                                        .then((status) async {
                                      if (status.isSuccess) {
                                        var name = _firstName + _lastName;
                                        print(
                                            "Data at the time of Navigation to Address picker is $name + $phone");
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ImagePickerScreen(
                                                      phone: phone,
                                                      name: name,
                                                      shopname: _lastName,
                                                    )),
                                            (route) => false);
                                        // Navigator.pushNamedAndRemoveUntil(
                                        //     context,
                                        //     RouteHelper.menu,
                                        //     (route) => false,
                                        //     arguments: AddNewAddressScreen());
                                      }
                                    });
                                  }
                                }
                              },
                            )
                          : Center(
                              child: CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).primaryColor),
                            )),

                      // for already an account
                      SizedBox(height: 11),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacementNamed(
                              RouteHelper.login,
                              arguments: LoginScreen());
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                getTranslated('already_have_account', context),
                                style: poppinsRegular.copyWith(
                                    fontSize: Dimensions.FONT_SIZE_SMALL,
                                    color:
                                        ColorResources.getHintColor(context)),
                              ),
                              SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                              Text(
                                getTranslated('login', context),
                                style: poppinsMedium.copyWith(
                                    fontSize: Dimensions.FONT_SIZE_SMALL,
                                    color:
                                        ColorResources.getTextColor(context)),
                              ),
                            ],
                          ),
                        ),
                      ),
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
