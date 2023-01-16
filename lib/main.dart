import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stocks_app/provider/stockes_provder.dart';
import 'package:stocks_app/screens/finger_print_auth.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StocksProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Stocks app",
        home: FingerprintAuth(),
      ),
    );
  }
}
