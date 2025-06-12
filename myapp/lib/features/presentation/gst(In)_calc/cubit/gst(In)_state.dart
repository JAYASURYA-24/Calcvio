class GstInclusiveCalculatorState {
  final double price;
  final double gstRate;
  final double totalGst;
  final double baseAmount;

  GstInclusiveCalculatorState({
    required this.price,
    required this.gstRate,
    this.totalGst = 0,
    this.baseAmount = 0,
  });

  GstInclusiveCalculatorState copyWith({
    double? price,
    double? gstRate,
    double? totalGst,
    double? baseAmount,
  }) {
    return GstInclusiveCalculatorState(
      price: price ?? this.price,
      gstRate: gstRate ?? this.gstRate,
      totalGst: totalGst ?? this.totalGst,
      baseAmount: baseAmount ?? this.baseAmount,
    );
  }
}
