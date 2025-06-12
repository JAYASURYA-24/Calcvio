import 'package:calcvio/features/presentation/lumpsum_calc/cubit/lumpsum_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';

class LumpsumCalculatorCubit extends Cubit<LumpsumCalculatorState> {
  LumpsumCalculatorCubit()
    : super(LumpsumCalculatorState(amount: 5000, returns: 12, years: 5)) {
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
    final n = state.returns / 100;
    final invested = state.amount;
    final maturity = invested * pow(1 + n, state.years);
    final gains = maturity - invested;

    emit(state.copyWith(invested: invested, maturity: maturity, gains: gains));
  }
}
