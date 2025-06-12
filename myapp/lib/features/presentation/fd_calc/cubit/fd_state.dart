enum FdType { simple, compound }

class FdCalculatorState {
  final double principal;
  final double rate;
  final double years;
  final int compoundFreq;
  final FdType type;

  final double interestEarned;
  final double maturityAmount;

  FdCalculatorState({
    required this.principal,
    required this.rate,
    required this.years,
    required this.compoundFreq,
    required this.type,
    this.interestEarned = 0,
    this.maturityAmount = 0,
  });

  FdCalculatorState copyWith({
    double? principal,
    double? rate,
    double? years,
    int? compoundFreq,
    FdType? type,
    double? interestEarned,
    double? maturityAmount,
  }) {
    return FdCalculatorState(
      principal: principal ?? this.principal,
      rate: rate ?? this.rate,
      years: years ?? this.years,
      compoundFreq: compoundFreq ?? this.compoundFreq,
      type: type ?? this.type,
      interestEarned: interestEarned ?? this.interestEarned,
      maturityAmount: maturityAmount ?? this.maturityAmount,
    );
  }
}
