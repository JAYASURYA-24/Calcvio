import 'package:calcvio/features/presentation/pf_calc/cubit/pf_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PFCalculatorCubit extends Cubit<PFCalculatorState> {
  PFCalculatorCubit()
    : super(
        PFCalculatorState(
          salary: 1000,
          empContrib: 12,
          emprContrib: 3,
          interestRate: 8,
          currentAge: 22,
          retirementAge: 55,
          salaryGrowth: 10,
          currentPFBalance: 0,
        ),
      ) {
    _calculate();
  }

  void updateSalary(double value) => _update(state.copyWith(salary: value));
  void updateEmpContrib(double value) =>
      _update(state.copyWith(empContrib: value));
  void updateEmprContrib(double value) =>
      _update(state.copyWith(emprContrib: value));
  void updateInterestRate(double value) =>
      _update(state.copyWith(interestRate: value));

  void updateCurrentAge(double value) {
    double newRetirementAge =
        state.retirementAge <= value ? value + 1 : state.retirementAge;
    _update(state.copyWith(currentAge: value, retirementAge: newRetirementAge));
  }

  void updateRetirementAge(double value) {
    if (value <= state.currentAge) return;
    _update(state.copyWith(retirementAge: value));
  }

  void updateSalaryGrowth(double value) =>
      _update(state.copyWith(salaryGrowth: value));

  void _update(PFCalculatorState newState) {
    emit(newState);
    _calculate();
  }

  void updateCurrentPFBalance(double value) =>
      _update(state.copyWith(currentPFBalance: value));

  void _calculate() {
    int years = (state.retirementAge - state.currentAge).toInt();
    double salary = state.salary;
    double openingBalance = 0;

    double salrayIncreaseRate = state.salaryGrowth / 100;
    double interestRate = state.interestRate / 100;
    double pfInterest = state.currentPFBalance * interestRate;
    double contribution = 0;
    for (int year = 1; year <= years; year++) {
      if (year > 1) {
        salary += salary * salrayIncreaseRate;
      }

      double monthlyEmp = (salary * state.empContrib) / 100;
      double monthlyEmpr = (salary * state.emprContrib) / 100;
      double annualContribution = (monthlyEmp + monthlyEmpr) * 12;

      double baseForInterest = openingBalance + annualContribution;
      double interest = baseForInterest * interestRate;
      double closingBalance = baseForInterest + interest;

      double finalValue = 0;
      double totalvalue = 0;
      double finalValueInterest = 0;

      if (year == 1) {
        if (state.currentPFBalance > 0) {
          finalValue = closingBalance + state.currentPFBalance;
          finalValueInterest = finalValue * interestRate;
          totalvalue = finalValue + finalValueInterest;
          closingBalance = totalvalue - pfInterest;
        }
      }

      openingBalance = closingBalance;
      contribution = closingBalance;
    }

    double totalEPF = contribution;

    emit(state.copyWith(totalEPF: totalEPF));
  }
}
