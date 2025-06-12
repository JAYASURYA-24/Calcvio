import 'package:flutter_bloc/flutter_bloc.dart';

import 'rd_state.dart';

class RDCalculatorCubit extends Cubit<RDCalculatorState> {
  RDCalculatorCubit()
    : super(
        RDCalculatorState(
          monthlyInvestment: 5000,
          interestRate: 8.0,
          months: 27,
        ),
      ) {
    _calculate();
  }

  void updateMonthlyInvestment(double value) {
    emit(state.copyWith(monthlyInvestment: value));
    _calculate();
  }

  void updateInterestRate(double value) {
    emit(state.copyWith(interestRate: value));
    _calculate();
  }

  void updateMonths(double value) {
    emit(state.copyWith(months: value));
    _calculate();
  }

  void _calculate() {
    final P = state.monthlyInvestment;
    final R = state.interestRate;
    final N = state.months;

    final interest = (P * N * (N + 1) * R) / (2 * 12 * 100);

    final maturityValue = (P * N) + interest;
    final principalAmount = P * N;

    emit(
      state.copyWith(
        maturityValue: maturityValue,
        principalAmount: principalAmount,
        interestEarned: interest,
      ),
    );
  }
}
