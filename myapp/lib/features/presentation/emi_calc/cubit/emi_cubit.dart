import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';
import 'emi_state.dart'; // Ensure you have this state defined similarly to PersonalLoanState

class EMICalculatorCubit extends Cubit<EMICalculatorState> {
  EMICalculatorCubit()
    : super(
        EMICalculatorState(
          principalAmount: 225000,
          interestRate: 13.8,
          years: 6,
        ),
      ) {
    _calculate();
  }

  void updatePrincipalAmount(double value) {
    emit(state.copyWith(principalAmount: value));
    _calculate();
  }

  void updateInterestRate(double value) {
    emit(state.copyWith(interestRate: value));
    _calculate();
  }

  void updateYears(double value) {
    emit(state.copyWith(years: value));
    _calculate();
  }

  void _calculate() {
    final monthlyRateOfInterest = state.interestRate / 100 / 12;
    final numberOfMonths = state.years * 12;

    final monthlyEMI =
        (state.principalAmount *
            monthlyRateOfInterest *
            pow(1 + monthlyRateOfInterest, numberOfMonths)) /
        (pow(1 + monthlyRateOfInterest, numberOfMonths) - 1);

    final totalPayment = monthlyEMI * numberOfMonths;
    final totalInterestPayment = totalPayment - state.principalAmount;
    final interestPercentage = (totalInterestPayment / totalPayment) * 100;

    emit(
      state.copyWith(
        monthlyEMI: monthlyEMI,
        totalPayment: totalPayment,
        totalInterestPayment: totalInterestPayment,
        interestPercentage: interestPercentage,
      ),
    );
  }
}
