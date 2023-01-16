import 'package:flutter/material.dart';
import 'package:fast_csv/fast_csv.dart' as _fast_csv;
import 'package:dio/dio.dart';
import 'package:stocks_app/model/model.dart';

class StocksProvider extends ChangeNotifier {
  Future<List<Stock>?> getStockes(String interval) async {
    var dio = Dio();
    final response = await dio.get(
        "https://query1.finance.yahoo.com/v7/finance/download/SPUS?period1=1633381200&period2=1664917199&interval=$interval&events=history");

    final data = _fast_csv.parse(response.data.toString());
    final List<Stock> list = data
        .skip(1)
        .map((e) => Stock(
              dateTime: DateTime.parse(e[0]),
              open: double.parse(e[1]),
              high: double.parse(e[2]),
              low: double.parse(e[3]),
              close: double.parse(e[4]),
              volume: double.parse(e[5]),
              adjClose: double.parse(e[6]),
            ))
        .toList();
            notifyListeners();

    return list;
  }
}
