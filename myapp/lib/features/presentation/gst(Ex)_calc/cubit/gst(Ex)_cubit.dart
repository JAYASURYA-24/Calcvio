import 'package:calcvio/features/presentation/gst(Ex)_calc/cubit/gst(Ex)_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GstExclusiveCalculatorCubit extends Cubit<GstCalculatorState> {
  GstExclusiveCalculatorCubit()
    : super(GstCalculatorState(price: 500, gstRate: 18)) {
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
    final m = (state.price * state.gstRate) / 100; // GST Amount
    final a = state.price + m; // Final Amount

    emit(state.copyWith(totalGst: m, finalAmount: a));
  }
}
