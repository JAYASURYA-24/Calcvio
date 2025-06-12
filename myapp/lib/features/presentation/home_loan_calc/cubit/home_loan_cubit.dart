import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_loan_state.dart';

class HomeLoanCalculatorCubit extends Cubit<HomeLoanState> {
  HomeLoanCalculatorCubit()
    : super(
        HomeLoanState(
          principal: 1250000,
          interestRate: 8.5,
          years: 20,
          emi: 0,
          totalPayment: 0,
          interestAmount: 0,
          interestpercent: 0,
        ),
      ) {
    _calculate();
  }

  void updatePrincipal(double value) {
    emit(state.copyWith(principal: value));
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

  // void _calculate() {
  //   final p = state.principal;
  //   final r = state.interestRate / 12 / 100;
  //   final n = (state.years * 12);

  //   final emi = p * r * pow(1 + r, n) / (pow(1 + r, n) - 1);
  //   final total = emi * n;
  //   final interest = total - p;
  //   final interestpercenatge = (interest / total) * 100;

  //   emit(
  //     state.copyWith(
  //       emi: emi,
  //       totalPayment: total,
  //       interestAmount: interest,
  //       interestpercent: interestpercenatge,
  //     ),
  //   );
  // }

  void _calculate() {
    final p = state.principal;
    final r = state.interestRate / 12 / 100;
    final n = (state.years * 12);

    double emi = 0.0;

    if (r > 0 && n > 0) {
      final factor = pow(1 + r, n);
      emi = p * r * factor / (factor - 1);
    } else if (n > 0) {
      emi = p / n;
    }

    final total = emi * n;
    final interest = total - p;
    final interestPercentage = total > 0 ? (interest / total) * 100 : 0.0;

    emit(
      state.copyWith(
        emi: emi.isFinite ? emi : 0.0,
        totalPayment: total.isFinite ? total : 0.0,
        interestAmount: interest.isFinite ? interest : 0.0,
        interestpercent: interestPercentage.isFinite ? interestPercentage : 0.0,
      ),
    );
  }
}
