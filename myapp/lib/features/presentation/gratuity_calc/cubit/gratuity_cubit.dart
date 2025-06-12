import 'package:flutter_bloc/flutter_bloc.dart';
import 'gratuity_state.dart';

class GratuityCalculatorCubit extends Cubit<GratuityCalculatorState> {
  GratuityCalculatorCubit()
    : super(
        GratuityCalculatorState(basicSalary: 100, da: 0, years: 5, month: 0),
      ) {
    _calculate();
  }

  void updateBasicSalary(double value) {
    emit(state.copyWith(basicSalary: value));
    _calculate();
  }

  void updateDA(double value) {
    emit(state.copyWith(da: value));
    _calculate();
  }

  void updateYears(double value) {
    emit(state.copyWith(years: value));
    _calculate();
  }

  void updateMonth(double value) {
    emit(state.copyWith(month: value));
    _calculate();
  }

  void _calculate() {
    final totalSalary = state.basicSalary + state.da;
    final monthFactor = state.month >= 7 ? 1 : 0;
    final totalServiceYears = state.years + monthFactor;
    final gratuity = (totalSalary * totalServiceYears * 15) / 26;

    emit(state.copyWith(gratuity: gratuity));
  }
}
