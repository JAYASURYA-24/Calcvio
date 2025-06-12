import 'package:calcvio/features/presentation/car_loan_calc/cubit/car_loan_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';

class CarLoanCalculatorCubit extends Cubit<CarLoanState> {
  CarLoanCalculatorCubit()
    : super(CarLoanState(amount: 1000000, interestRate: 11, years: 1)) {
    _calculate();
  }

  void updateAmount(double value) {
    emit(state.copyWith(amount: value));
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

    double monthlyEMI = 0.0;
    if (monthlyRateOfInterest > 0 && numberOfMonths > 0) {
      final factor = pow(1 + monthlyRateOfInterest, numberOfMonths);
      monthlyEMI =
          (state.amount * monthlyRateOfInterest * factor) / (factor - 1);
    } else if (numberOfMonths > 0) {
      monthlyEMI = state.amount / numberOfMonths;
    }

    final totalPayment = monthlyEMI * numberOfMonths;
    final totalInterestPayment = totalPayment - state.amount;
    final interestPercentage =
        totalPayment > 0 ? (totalInterestPayment / totalPayment) * 100 : 0.0;

    emit(
      state.copyWith(
        monthlyEMI: monthlyEMI.isFinite ? monthlyEMI : 0.0,
        totalPayment: totalPayment.isFinite ? totalPayment : 0.0,
        totalInterestPayment:
            totalInterestPayment.isFinite ? totalInterestPayment : 0.0,
        interestPercentage:
            interestPercentage.isFinite ? interestPercentage : 0.0,
      ),
    );
  }
}
