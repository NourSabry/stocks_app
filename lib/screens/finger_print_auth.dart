// ignore_for_file: avoid_print, deprecated_member_use, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:stocks_app/colors.dart';
import 'package:stocks_app/screens/stocks_screen.dart';
import 'package:stocks_app/widgets/custom_appBar.dart';
import 'package:stocks_app/widgets/custom_button.dart';

class FingerprintAuth extends StatefulWidget {
  @override
  _FingerprintAuthState createState() => _FingerprintAuthState();
}

class _FingerprintAuthState extends State<FingerprintAuth> {
  final auth = LocalAuthentication();
  String authorized = " not authorized";

  Future<void> _authenticate() async {
    bool authenticated = false;

    try {
      authenticated = await auth.authenticateWithBiometrics(
        localizedReason: "Scan your finger to authenticate",
        //to tell the user within he entered the correct or the wrong fingerprint
        useErrorDialogs: true,
        //to keep the user authenticated if he leaves the app and came back again
        stickyAuth: true,
      );
    } on PlatformException catch (e) {
      print(e);
    }

    setState(() {
      authorized =
          authenticated ? "Authorized success" : "Failed to authenticate";
      print(authorized);
    });

    if (authenticated) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => StocksScreen(),
        ),
      );
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        "Login to your stocks",
      ),
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "identify\n yourself",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: textColor,
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/fingerprint.png",
                  width: 120.0,
                ),
                const Text(
                  "Fingerprint Auth",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Text(
                    "please authenticate yourself to be able to continue",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: textColor, height: 1.5),
                  ),
                ),
                CustomElevatedButton(
                  function: _authenticate,
                  title: "Authenticate",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
