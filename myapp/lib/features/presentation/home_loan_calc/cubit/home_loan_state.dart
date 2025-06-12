class HomeLoanState {
  final double principal;
  final double interestRate;
  final double years;
  final double emi;
  final double totalPayment;
  final double interestAmount;
  final double interestpercent;

  HomeLoanState({
    required this.principal,
    required this.interestRate,
    required this.years,
    required this.emi,
    required this.totalPayment,
    required this.interestAmount,
    required this.interestpercent,
  });

  HomeLoanState copyWith({
    double? principal,
    double? interestRate,
    double? years,
    double? emi,
    double? totalPayment,
    double? interestAmount,
    double? interestpercent,
  }) {
    return HomeLoanState(
      principal: principal ?? this.principal,
      interestRate: interestRate ?? this.interestRate,
      years: years ?? this.years,
      emi: emi ?? this.emi,
      totalPayment: totalPayment ?? this.totalPayment,
      interestAmount: interestAmount ?? this.interestAmount,
      interestpercent: interestpercent ?? this.interestpercent,
    );
  }
}
