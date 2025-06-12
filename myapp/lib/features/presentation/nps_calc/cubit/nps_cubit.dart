import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';

part 'nps_state.dart';

class NpsCalculatorCubit extends Cubit<NpsCalculatorState> {
  NpsCalculatorCubit()
    : super(
        NpsCalculatorState(
          age: 30,
          monthlyContribution: 3000,
          expectedRateOfReturn: 10,
          annuityPercent: 40,
          annuityRate: 3,
          annuityTenure: 2,
        ),
      ) {
    _calculate();
  }

  void updateAge(double value) {
    emit(state.copyWith(age: value));
    _calculate();
  }

  void updateMonthlyContribution(double value) {
    emit(state.copyWith(monthlyContribution: value));
    _calculate();
  }

  void updateExpectedRate(double value) {
    emit(state.copyWith(expectedRateOfReturn: value));
    _calculate();
  }

  void updateAnnuityPercent(double value) {
    emit(state.copyWith(annuityPercent: value));
    _calculate();
  }

  void updateAnnuityRate(double value) {
    emit(state.copyWith(annuityRate: value));
    _calculate();
  }

  void updateAnnuityTenure(double value) {
    emit(state.copyWith(annuityTenure: value));
    _calculate();
  }

  void _calculate() {
    final tyc = 60 - state.age;
    final n = tyc * 12;
    final r = state.expectedRateOfReturn / 100 / 12;
    final ar = state.annuityRate / 100 / 12;
    final mt = state.annuityTenure * 12;

    final totalInvestment = state.monthlyContribution * n;
    final pw =
        state.monthlyContribution * (((pow(1 + r, n) - 1) / r) * (1 + r));
    final interestEarned = pw - totalInvestment;

    final annuityAmount = (state.annuityPercent / 100) * pw;
    final lumpSum = pw - annuityAmount;

    final pensionPerMonth = (annuityAmount * ar) / (1 - pow(1 + ar, -mt));

    emit(
      state.copyWith(
        totalInvestment: totalInvestment,
        pensionWealth: pw,
        interestEarned: interestEarned,
        annuityAmount: annuityAmount,
        lumpSum: lumpSum,
        pensionPerMonth: pensionPerMonth,
      ),
    );
  }
}
