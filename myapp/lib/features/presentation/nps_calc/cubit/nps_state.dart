part of 'nps_cubit.dart';

class NpsCalculatorState {
  final double age;
  final double monthlyContribution;
  final double expectedRateOfReturn;
  final double annuityPercent;
  final double annuityRate;
  final double annuityTenure;

  final double totalInvestment;
  final double pensionWealth;
  final double interestEarned;
  final double annuityAmount;
  final double lumpSum;
  final double pensionPerMonth;

  NpsCalculatorState({
    required this.age,
    required this.monthlyContribution,
    required this.expectedRateOfReturn,
    required this.annuityPercent,
    required this.annuityRate,
    required this.annuityTenure,
    this.totalInvestment = 0,
    this.pensionWealth = 0,
    this.interestEarned = 0,
    this.annuityAmount = 0,
    this.lumpSum = 0,
    this.pensionPerMonth = 0,
  });

  NpsCalculatorState copyWith({
    double? age,
    double? monthlyContribution,
    double? expectedRateOfReturn,
    double? annuityPercent,
    double? annuityRate,
    double? annuityTenure,
    double? totalInvestment,
    double? pensionWealth,
    double? interestEarned,
    double? annuityAmount,
    double? lumpSum,
    double? pensionPerMonth,
  }) {
    return NpsCalculatorState(
      age: age ?? this.age,
      monthlyContribution: monthlyContribution ?? this.monthlyContribution,
      expectedRateOfReturn: expectedRateOfReturn ?? this.expectedRateOfReturn,
      annuityPercent: annuityPercent ?? this.annuityPercent,
      annuityRate: annuityRate ?? this.annuityRate,
      annuityTenure: annuityTenure ?? this.annuityTenure,
      totalInvestment: totalInvestment ?? this.totalInvestment,
      pensionWealth: pensionWealth ?? this.pensionWealth,
      interestEarned: interestEarned ?? this.interestEarned,
      annuityAmount: annuityAmount ?? this.annuityAmount,
      lumpSum: lumpSum ?? this.lumpSum,
      pensionPerMonth: pensionPerMonth ?? this.pensionPerMonth,
    );
  }
}
