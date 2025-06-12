import 'package:calcvio/features/presentation/gst(In)_calc/cubit/gst(In)_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GstInclusiveCalculatorCubit extends Cubit<GstInclusiveCalculatorState> {
  GstInclusiveCalculatorCubit()
    : super(GstInclusiveCalculatorState(price: 1000, gstRate: 24)) {
    _calculate();
  }

  void updatePrice(double value) {
    emit(state.copyWith(price: value));
    _calculate();
  }

  void updateGstRate(double value) {
    emit(state.copyWith(gstRate: value));
    _calculate();
  }

  void _calculate() {
    final factor = 100 / (100 + state.gstRate);
    final baseAmount = state.price * factor;
    final totalGst = state.price - baseAmount;

    emit(state.copyWith(totalGst: totalGst, baseAmount: baseAmount));
  }
}
