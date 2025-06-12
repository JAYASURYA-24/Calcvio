import 'dart:math';

import 'package:calcvio/features/presentation/fd_calc/cubit/fd_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FdCalculatorCubit extends Cubit<FdCalculatorState> {
  FdCalculatorCubit()
    : super(
        FdCalculatorState(
          principal: 1000,
          rate: 11,
          years: 4,
          compoundFreq: 4,
          type: FdType.simple,
        ),
      ) {
    _calculate();
  }

  void updatePrincipal(double value) {
    emit(state.copyWith(principal: value));
    _calculate();
  }

  void updateRate(double value) {
    emit(state.copyWith(rate: value));
    _calculate();
  }

  void updateYears(double value) {
    emit(state.copyWith(years: value));
    _calculate();
  }

  void updateFrequency(int value) {
    emit(state.copyWith(compoundFreq: value));
    _calculate();
  }

  void updateType(FdType type) {
    emit(state.copyWith(type: type));
    _calculate();
  }

  void _calculate() {
    double i = state.rate / 100;
    double p = state.principal;
    double y = state.years;
    double m = 0;

    if (state.type == FdType.simple) {
      m = p + (p * i * y);
    } else {
      int n = state.compoundFreq;
      m = p * pow((1 + i / n), n * y);
    }

    final interest = m - p;

    emit(state.copyWith(maturityAmount: m, interestEarned: interest));
  }
}
