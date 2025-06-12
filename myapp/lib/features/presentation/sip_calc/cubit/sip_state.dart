class SipCalculatorState {
  final double amount;
  final double returns;
  final double years;
  final double invested;
  final double maturity;
  final double gains;

  SipCalculatorState({
    required this.amount,
    required this.returns,
    required this.years,
    this.invested = 0,
    this.maturity = 0,
    this.gains = 0,
  });

  SipCalculatorState copyWith({
    double? amount,
    double? returns,
    double? years,
    double? invested,
    double? maturity,
    double? gains,
  }) {
    return SipCalculatorState(
      amount: amount ?? this.amount,
      returns: returns ?? this.returns,
      years: years ?? this.years,
      invested: invested ?? this.invested,
      maturity: maturity ?? this.maturity,
      gains: gains ?? this.gains,
    );
  }
}
