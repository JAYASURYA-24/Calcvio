class GstCalculatorState {
  final double price;
  final double gstRate;
  final double totalGst;
  final double finalAmount;

  GstCalculatorState({
    required this.price,
    required this.gstRate,
    this.totalGst = 0,
    this.finalAmount = 0,
  });

  GstCalculatorState copyWith({
    double? price,
    double? gstRate,
    double? totalGst,
    double? finalAmount,
  }) {
    return GstCalculatorState(
      price: price ?? this.price,
      gstRate: gstRate ?? this.gstRate,
      totalGst: totalGst ?? this.totalGst,
      finalAmount: finalAmount ?? this.finalAmount,
    );
  }
}
