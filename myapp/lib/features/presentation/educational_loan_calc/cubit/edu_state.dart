class EducationalLoanState {
  final double amount;
  final double interestRate;
  final double years;
  final double monthlyEMI;
  final double totalPayment;
  final double totalInterestPayment;
  final double interestPercentage;

  EducationalLoanState({
    required this.amount,
    required this.interestRate,
    required this.years,
    this.monthlyEMI = 0.0,
    this.totalPayment = 0.0,
    this.totalInterestPayment = 0.0,
    this.interestPercentage = 0.0,
  });

  EducationalLoanState copyWith({
    double? amount,
    double? interestRate,
    double? years,
    double? monthlyEMI,
    double? totalPayment,
    double? totalInterestPayment,
    double? interestPercentage,
  }) {
    return EducationalLoanState(
      amount: amount ?? this.amount,
      interestRate: interestRate ?? this.interestRate,
      years: years ?? this.years,
      monthlyEMI: monthlyEMI ?? this.monthlyEMI,
      totalPayment: totalPayment ?? this.totalPayment,
      totalInterestPayment: totalInterestPayment ?? this.totalInterestPayment,
      interestPercentage: interestPercentage ?? this.interestPercentage,
    );
  }
}
