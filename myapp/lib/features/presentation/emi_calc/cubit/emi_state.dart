import 'package:equatable/equatable.dart';

class EMICalculatorState extends Equatable {
  final double principalAmount;
  final double interestRate;
  final double years;
  final double monthlyEMI;
  final double totalPayment;
  final double totalInterestPayment;
  final double interestPercentage;

  const EMICalculatorState({
    required this.principalAmount,
    required this.interestRate,
    required this.years,
    this.monthlyEMI = 0.0,
    this.totalPayment = 0.0,
    this.totalInterestPayment = 0.0,
    this.interestPercentage = 0.0,
  });

  EMICalculatorState copyWith({
    double? principalAmount,
    double? interestRate,
    double? years,
    double? monthlyEMI,
    double? totalPayment,
    double? totalInterestPayment,
    double? interestPercentage,
  }) {
    return EMICalculatorState(
      principalAmount: principalAmount ?? this.principalAmount,
      interestRate: interestRate ?? this.interestRate,
      years: years ?? this.years,
      monthlyEMI: monthlyEMI ?? this.monthlyEMI,
      totalPayment: totalPayment ?? this.totalPayment,
      totalInterestPayment: totalInterestPayment ?? this.totalInterestPayment,
      interestPercentage: interestPercentage ?? this.interestPercentage,
    );
  }

  @override
  List<Object?> get props => [
    principalAmount,
    interestRate,
    years,
    monthlyEMI,
    totalPayment,
    totalInterestPayment,
    interestPercentage,
  ];
}
