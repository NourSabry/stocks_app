// ignore_for_file: unused_field, unused_element, avoid_print, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stocks_app/colors.dart';
import 'package:stocks_app/model/model.dart';
import 'package:stocks_app/provider/stockes_provder.dart';
import 'package:stocks_app/widgets/custom_appBar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StocksScreen extends StatefulWidget {
  @override
  StocksScreenState createState() => StocksScreenState();
}

class StocksScreenState extends State<StocksScreen> {
  int _value = 0;
  String intervalValue = "";

  Future<List<Stock>> _getStocks(BuildContext context) async {
    final List<Stock>? listStocks =
        await Provider.of<StocksProvider>(context, listen: false)
            .getStockes(intervalValue);

    return listStocks!;
  }

  var _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("Watch your stocks"),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  "the interval to display",
                  style: TextStyle(
                    color: backgroundColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                DropdownButton(
                  isExpanded: false,
                  value: _value,
                  items: const [
                    DropdownMenuItem(
                      child: Text("1 day"),
                      value: 1,
                    ),
                    DropdownMenuItem(
                      child: Text("1 week"),
                      value: 2,
                    ),
                    DropdownMenuItem(
                      child: Text("1 month"),
                      value: 3,
                    )
                  ],
                  onChanged: (int? value) {
                    if (value == 1) {
                      intervalValue = "1d";
                    } else if (value == 2) {
                      intervalValue = "1wk";
                    } else {
                      intervalValue = "1mo";
                    }
                    setState(() {
                      _value = value!;
                    });
                  },
                  hint: const Text("available intervals"),
                  dropdownColor: tabColor.withOpacity(0.4),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _getStocks(context);
                setState(() {
                  _isPressed = true;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text("show chart"),
            ),
            _isPressed
                ? FutureBuilder<List<Stock>>(
                    future: _getStocks(context),
                    builder: (context, snapshot) =>
                        snapshot.connectionState == ConnectionState.waiting
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : !snapshot.hasData
                                ? const Text("there's no stocks")
                                : SizedBox(
                                    height: 500,
                                    width: 320,
                                    child: SfCartesianChart(
                                      backgroundColor: Colors.white,
                                      primaryXAxis: DateTimeAxis(
                                        // visibleMinimum: DateTime(2016, 01, 8),
                                        // visibleMaximum: DateTime(2016, 03, 16),
                                        edgeLabelPlacement:
                                            EdgeLabelPlacement.shift,
                                        intervalType: intervalValue == "1d"
                                            ? DateTimeIntervalType.days
                                            : intervalValue == "1mo"
                                                ? DateTimeIntervalType.months
                                                : DateTimeIntervalType.days,
                                        majorGridLines:
                                            const MajorGridLines(width: 0),
                                      ),
                                      primaryYAxis: intervalValue == "1wk"
                                          ? NumericAxis(interval: 7)
                                          : NumericAxis(interval: 1),
                                      series: <ChartSeries<Stock, DateTime>>[
                                        CandleSeries<Stock, DateTime>(
                                          dataSource: snapshot.data!,
                                          xValueMapper: (Stock sales, _) =>
                                              sales.dateTime,
                                          lowValueMapper: (Stock sales, _) =>
                                              sales.low,
                                          highValueMapper: (Stock sales, _) =>
                                              sales.high,
                                          openValueMapper: (Stock sales, _) =>
                                              sales.open,
                                          closeValueMapper: (Stock sales, _) =>
                                              sales.close,
                                          name: 'Sales',
                                        ),
                                      ],
                                    ),
                                  ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
