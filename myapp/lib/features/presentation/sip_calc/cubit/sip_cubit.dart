import 'dart:math';

import 'package:calcvio/features/presentation/sip_calc/cubit/sip_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SipCalculatorCubit extends Cubit<SipCalculatorState> {
  SipCalculatorCubit()
    : super(SipCalculatorState(amount: 5000, returns: 12, years: 5)) {
    _calculate();
  }

  void updateAmount(double value) {
    emit(state.copyWith(amount: value));
    _calculate();
  }

  void updateReturns(double value) {
    emit(state.copyWith(returns: value));
    _calculate();
  }

  void updateYears(double value) {
    emit(state.copyWith(years: value));
    _calculate();
  }

  void _calculate() {
    final i = (((state.returns / 100) * 100) / 12) / 100;
    final n = state.years * 12;
    final invested = state.amount * n;
    final maturity = state.amount * (pow(1 + i, n) - 1) * (1 + i) / i;
    final gains = maturity - invested;

    emit(state.copyWith(invested: invested, maturity: maturity, gains: gains));
  }
}
