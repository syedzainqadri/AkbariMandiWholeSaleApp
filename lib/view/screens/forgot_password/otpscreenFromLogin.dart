import 'package:alt_sms_autofill/alt_sms_autofill.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:akbarimandiwholesale/Services/databseServices.dart';
import 'package:akbarimandiwholesale/data/model/response/firebaseuserModel.dart';
import 'package:akbarimandiwholesale/provider/auth_provider.dart';
import 'package:akbarimandiwholesale/utill/dimensions.dart';
import 'package:akbarimandiwholesale/utill/images.dart';
import 'package:akbarimandiwholesale/utill/styles.dart';
import 'package:akbarimandiwholesale/view/screens/auth/create_account_screen.dart';
import 'package:akbarimandiwholesale/view/screens/forgot_password/onShopScreen.dart';
import 'package:akbarimandiwholesale/view/screens/menu/menu_screen.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';

class OtpScreenFromLogin extends StatefulWidget {
  String emailAddress;
  final bool fromLogin;
  OtpScreenFromLogin({
    @required this.emailAddress,
    this.fromLogin,
  });

  @override
  State<OtpScreenFromLogin> createState() => _OtpScreenFromLoginState();
}

class _OtpScreenFromLoginState extends State<OtpScreenFromLogin> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String _verificationCode;
  TextEditingController textEditingController1;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(0, 0, 0, 0),
    borderRadius: BorderRadius.circular(5.0),
    border: Border.all(
      color: const Color.fromRGBO(0, 0, 0, 1),
    ),
  );

  String _comingSms = 'Unknown';
  String _token;

  Future<void> initSmsListener() async {
    String comingSms;
    try {
      comingSms = await AltSmsAutofill().listenForSms;
    } on PlatformException {
      comingSms = 'Failed to get Sms.';
    }
    if (!mounted) return;
    setState(() {
      _comingSms = comingSms;
      print("====>Message: ${_comingSms}");
      print("${_comingSms[1]}");
      textEditingController1.text = _comingSms[0] +
          _comingSms[1] +
          _comingSms[2] +
          _comingSms[3] +
          _comingSms[4] +
          _comingSms[
              5]; //used to set the code in the message to a string and setting it to a textcontroller. message length is 38. so my code is in string index 32-37.
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      key: _scaffoldkey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              child: ClipRRect(
                child: Image.asset(
                  Images.app_logo,
                  height: 100,
                  width: 100,
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 20),
              child: Center(
                child: Text(
                  'آپنا کوڈ انٹر کریں ',
                  style: poppinsBold.copyWith(
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 50.0, left: 50, top: 20),
            child: PinPut(
              fieldsCount: 6,
              textStyle: poppinsBold.copyWith(
                  fontSize: Dimensions.FONT_SIZE_SMALL,
                  color: Colors.green[700]),
              eachFieldWidth: 40.0,
              eachFieldHeight: 55.0,
              focusNode: _pinPutFocusNode,
              controller: textEditingController1,
              // controller: _pinPutController,
              submittedFieldDecoration: pinPutDecoration,
              selectedFieldDecoration: pinPutDecoration,
              followingFieldDecoration: pinPutDecoration,
              pinAnimationType: PinAnimationType.fade,
              onSubmit: (pin) async {
                try {
                  await FirebaseAuth.instance
                      .signInWithCredential(PhoneAuthProvider.credential(
                          verificationId: _verificationCode, smsCode: pin))
                      .then((value) async {
                    await Database().getFcmToken(value.user.uid).then((value) {
                      setState(() {
                        _token = value;
                      });
                      print('token upon login is: $_token');
                    });
                    if (value.user != null) {
                      await Provider.of<AuthProvider>(context, listen: false)
                          .loginWithFirebase(value.user.uid)
                          .then((status) {
                        if (status.isSuccess) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MenuScreen()),
                              (route) => false);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Please Try Again In 5 Min',
                                  style: TextStyle(color: Colors.white)),
                              duration: Duration(milliseconds: 600),
                              backgroundColor: Colors.red));
                        }
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Token is empty',
                              style: TextStyle(color: Colors.white)),
                          duration: Duration(milliseconds: 600),
                          backgroundColor: Colors.red));
                    }
                  });
                } catch (e) {
                  FocusScope.of(context).unfocus();
                  _scaffoldkey.currentState.showSnackBar(
                      SnackBar(content: Text('Please Enter A Valid OTP')));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: widget.emailAddress,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            // if (value.user != null) {
            // await Database().getFcmToken(value.user.uid).then((value) {
            //   setState(() {
            //     _token = value;
            //   });
            //   print('token upon login is: $_token');
            // });
            if (value.user != null) {
              await Provider.of<AuthProvider>(context, listen: false)
                  .loginWithFirebase(value.user.uid)
                  .then((status) {
                if (status.isSuccess) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MenuScreen()),
                      (route) => false);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Please Try Again In 5 Min',
                          style: TextStyle(color: Colors.white)),
                      duration: Duration(milliseconds: 600),
                      backgroundColor: Colors.red));
                }
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Token is empty',
                      style: TextStyle(color: Colors.white)),
                  duration: Duration(milliseconds: 600),
                  backgroundColor: Colors.red));
              // }
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verficationID, int resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
  }

  @override
  void initState() {
    super.initState();
    _verifyPhone();
    textEditingController1 = TextEditingController();
    initSmsListener();
  }

  @override
  void dispose() {
    textEditingController1.dispose();
    AltSmsAutofill().unregisterListener();
    super.dispose();
  }
}
