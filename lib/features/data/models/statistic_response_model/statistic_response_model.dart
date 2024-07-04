class StatisticResponseModel {
  final String ticker;
  final int queryCount;
  final int resultsCount;
  final bool adjusted;
  final List<StatisticModel> statistic;

  StatisticResponseModel({
    required this.ticker,
    required this.queryCount,
    required this.resultsCount,
    required this.adjusted,
    required this.statistic,
  });
}

class StatisticModel {
  final dynamic volume;
  final dynamic volumeWeightedAveragePrice;
  final dynamic open;
  final dynamic close;
  final dynamic high;
  final dynamic low;
  final dynamic timestamp;
  final dynamic numberOfTrades;

  StatisticModel({
    required this.volume,
    required this.volumeWeightedAveragePrice,
    required this.open,
    required this.close,
    required this.high,
    required this.low,
    required this.timestamp,
    required this.numberOfTrades,
  });

  factory StatisticModel.fromJson(Map<String, dynamic> json) {
    return StatisticModel(
      volume: json['v'],
      volumeWeightedAveragePrice: json['vw'],
      open: json['o'],
      close: json['c'],
      high: json['h'],
      low: json['l'],
      timestamp: json['t'],
      numberOfTrades: json['n'],
    );
  }
}
