import 'package:calcvio/features/presentation/personal_loan_calc/cubit/personal_loan_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';

class PersonalLoanCalculatorCubit extends Cubit<PersonalLoanState> {
  PersonalLoanCalculatorCubit()
    : super(PersonalLoanState(amount: 400000, interestRate: 13, years: 3)) {
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
    final amount = state.amount;
    final r = state.interestRate / 100 / 12;
    final n = state.years * 12;

    double monthlyEMI = 0.0;

    if (r > 0 && n > 0) {
      final factor = pow(1 + r, n);
      monthlyEMI = amount * r * factor / (factor - 1);
    } else if (n > 0) {
      monthlyEMI = amount / n;
    }

    final totalPayment = monthlyEMI * n;
    final totalInterestPayment = totalPayment - amount;
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
