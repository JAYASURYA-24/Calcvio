import 'package:flutter_bloc/flutter_bloc.dart';
import '7th_pay_state.dart';

class SeventhPayCalculatorCubit extends Cubit<SeventhPayState> {
  SeventhPayCalculatorCubit()
    : super(
        SeventhPayState(
          basicPay: 32900,
          hraPercent: 24,
          daPercent: 17,
          ta: 1800,
        ),
      ) {
    _calculate();
  }

  void updateBasicPay(double value) {
    emit(state.copyWith(basicPay: value));
    _calculate();
  }

  void updateHra(double value) {
    emit(state.copyWith(hraPercent: value));
    _calculate();
  }

  void updateDa(double value) {
    emit(state.copyWith(daPercent: value));
    _calculate();
  }

  void updateTa(double value) {
    emit(state.copyWith(ta: value));
    _calculate();
  }

  void _calculate() {
    final basic = state.basicPay;
    final hra = (state.hraPercent / 100) * basic;
    final da = (state.daPercent / 100) * basic;

    // DA is also added on TA (Transport Allowance)
    final taWithDa = state.ta + ((state.ta * state.daPercent) / 100);

    final total = basic + hra + da + taWithDa;

    emit(
      state.copyWith(
        hraAmount: hra,
        daAmount: da,
        taAmount: taWithDa,
        totalPay: total,
      ),
    );
  }
}
