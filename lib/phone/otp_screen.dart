// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:crud_firebase_flutter/screen/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';

class OtpScreen extends StatefulWidget {
  String? number;
  OtpScreen({required this.number});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late String _verificationCode;
  verifyNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(

        //provide phone number
        phoneNumber: '+91 ${widget.number}',

        //user should provide credential
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) {
            if (value != null) print('Logged In');
          });
        },

        //user should provide exception if code might be throw error
        verificationFailed: (FirebaseAuthException exception) {
          // ignore: unnecessary_brace_in_string_interps
          print('EXCEPTION=====>>>>> ${exception}');
        },
        codeSent: (String? VerificationId, int? resendToken) {
          setState(() {
            _verificationCode = VerificationId!;
          });
        },
        codeAutoRetrievalTimeout: (String? VerificationId) {
          setState(() {
            _verificationCode = VerificationId!;
          });
        },
        timeout: Duration(seconds: 60));
  }

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.deepPurpleAccent),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  TextEditingController otpcontroller = TextEditingController();
  @override
  void initState() {
    verifyNumber();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Otp Screen'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.all(15),
                height: 52,
                width: double.infinity,
                color: Colors.white,
                child: PinPut(
                  submittedFieldDecoration: _pinPutDecoration.copyWith(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  fieldsCount: 6,
                  selectedFieldDecoration: _pinPutDecoration,
                  followingFieldDecoration: _pinPutDecoration.copyWith(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      color: Colors.deepPurpleAccent.withOpacity(.5),
                    ),
                  ),
                  controller: otpcontroller,
                  keyboardType: TextInputType.number,
                  onSubmit: (pin) async {
                    try {
                      await FirebaseAuth.instance
                          .signInWithCredential(PhoneAuthProvider.credential(
                              verificationId: _verificationCode, smsCode: pin))
                          .then((value) {
                        if (value != null) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WelcomeScreen()),
                              (route) => false);
                        }
                      });
                    } catch (e) {
                      FocusScope.of(context).unfocus();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('InvalidOtp'),
                      ));
                    }
                  },
                )),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WelcomeScreen(),
                      ));
                  otpcontroller.clear();
                },
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                ))
          ],
        ),
      ),
    );
  }
}
