class SeventhPayState {
  final double basicPay;
  final double hraPercent;
  final double daPercent;
  final double ta;

  final double hraAmount;
  final double daAmount;
  final double taAmount;
  final double totalPay;

  SeventhPayState({
    required this.basicPay,
    required this.hraPercent,
    required this.daPercent,
    required this.ta,
    this.hraAmount = 0.0,
    this.daAmount = 0.0,
    this.taAmount = 0.0,
    this.totalPay = 0.0,
  });

  SeventhPayState copyWith({
    double? basicPay,
    double? hraPercent,
    double? daPercent,
    double? ta,
    double? hraAmount,
    double? daAmount,
    double? taAmount,
    double? totalPay,
  }) {
    return SeventhPayState(
      basicPay: basicPay ?? this.basicPay,
      hraPercent: hraPercent ?? this.hraPercent,
      daPercent: daPercent ?? this.daPercent,
      ta: ta ?? this.ta,
      hraAmount: hraAmount ?? this.hraAmount,
      daAmount: daAmount ?? this.daAmount,
      taAmount: taAmount ?? this.taAmount,
      totalPay: totalPay ?? this.totalPay,
    );
  }
}
