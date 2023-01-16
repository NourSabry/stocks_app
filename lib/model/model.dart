// ignore_for_file: avoid_print

class Stock {
  Stock({
    required this.adjClose,
    required this.close,
    required this.dateTime,
    required this.high,
    required this.low,
    required this.open,
    required this.volume,
  });

  DateTime dateTime;
  double open;
  double high;
  double low;
  double close;
  double adjClose;
  double volume;
}
