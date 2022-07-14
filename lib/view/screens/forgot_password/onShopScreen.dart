// ignore_for_file: file_names, avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_grocery/helper/responsive_helper.dart';
import 'package:flutter_grocery/view/base/main_app_bar.dart';
import 'package:flutter_grocery/view/screens/auth/create_account_screen.dart';

class OnShopScreen extends StatelessWidget {
  var phone;
  var id;
  OnShopScreen({@required this.phone, @required this.id, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResponsiveHelper.isDesktop(context) ? MainAppBar() : null,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(
                'کیا آپ دکان پر موجود ہیں ؟',
                style: TextStyle(
                    color: Color(0xFF01684B),
                    fontSize: 32,
                    // fontFamily: 'Noto Nastaliq Urdu',
                    fontWeight: FontWeight.normal),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFF01684B)),
                    ),
                    onPressed: () async {
                      print(
                          "Phone Number at create Account Screen is : $phone");
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateAccountScreen(
                                    id: id,
                                    phone: phone,
                                  )),
                          (route) => false);
                    },
                    child: SizedBox(
                      height: 100,
                      width: 120,
                      child: Center(
                        child: Text(
                          "'ہاں\n !دکان پر موجود ہوں",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              // fontFamily: 'Noto Nastaliq Urdu',
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFF01684B)),
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      20.0)), //this right here
                              child: SizedBox(
                                height: 200,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Text(
                                          'دوکان پر جائیں اور دوبارہ اپلائی کریں',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 18,
                                              // fontFamily: 'Noto Nastaliq Urdu',
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 40,
                                      ),
                                      Center(
                                        child: SizedBox(
                                          width: 100.0,
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.green),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "!ٹھیک ہے",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white),
                                            ),
                                            // color: const Color(0xFF1BC0C5),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                    child: SizedBox(
                      height: 100,
                      width: 120,
                      child: Center(
                        child: Text(
                          "'نہیں\n !دکان پر موجود نہیں ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              // fontFamily: 'Noto Nastaliq Urdu',
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
