class RDCalculatorState {
  final double monthlyInvestment;
  final double interestRate;
  final double months;
  final double maturityValue;
  final double interestEarned;
  final double principalAmount;

  RDCalculatorState({
    required this.monthlyInvestment,
    required this.interestRate,
    required this.months,
    this.maturityValue = 0,
    this.interestEarned = 0,
    this.principalAmount = 0,
  });

  RDCalculatorState copyWith({
    double? monthlyInvestment,
    double? interestRate,
    double? months,
    double? maturityValue,
    double? interestEarned,
    double? principalAmount,
  }) {
    return RDCalculatorState(
      monthlyInvestment: monthlyInvestment ?? this.monthlyInvestment,
      interestRate: interestRate ?? this.interestRate,
      months: months ?? this.months,
      maturityValue: maturityValue ?? this.maturityValue,
      interestEarned: interestEarned ?? this.interestEarned,
      principalAmount: principalAmount ?? this.principalAmount,
    );
  }
}
