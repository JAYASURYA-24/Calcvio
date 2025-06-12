// import 'package:financial_calc/features/presentation/gst(In)_calc/cubit/gst(In)_cubit.dart';
// import 'package:financial_calc/features/presentation/gst(In)_calc/cubit/gst(In)_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// import '../../../../../core/widgets/slider_widget.dart';
// import '../../../../../core/widgets/result_widget.dart';

// class GstInclusiveCalculatorPage extends StatelessWidget {
//   const GstInclusiveCalculatorPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => GstInclusiveCalculatorCubit(),
//       child: Scaffold(
//         appBar: AppBar(title: const Text('GST Calculator (Inclusive)')),
//         body: BlocBuilder<
//           GstInclusiveCalculatorCubit,
//           GstInclusiveCalculatorState
//         >(
//           builder: (context, state) {
//             final cubit = context.read<GstInclusiveCalculatorCubit>();
//             return Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: ListView(
//                 children: [
//                   SfCircularChart(
//                     palette: [
//                       Colors.lightBlue,
//                       const Color.fromARGB(255, 0, 91, 248),
//                     ],
//                     legend: Legend(isVisible: true),
//                     series: <CircularSeries>[
//                       DoughnutSeries<ChartData, String>(
//                         dataSource: [
//                           ChartData("Base Price", state.baseAmount),
//                           ChartData("GST", state.totalGst),
//                         ],
//                         xValueMapper: (data, _) => data.category,
//                         yValueMapper: (data, _) => data.value,
//                         dataLabelMapper:
//                             (ChartData data, _) =>
//                                 data.value.toStringAsFixed(2),
//                         dataLabelSettings: const DataLabelSettings(
//                           isVisible: true,
//                         ),
//                       ),
//                     ],
//                   ),
//                   buildSlider(
//                     title: 'Final Price (incl. GST)',
//                     value: state.price,
//                     min: 1,
//                     max: 1000000,
//                     onChanged: cubit.updatePrice,
//                     suffix: '₹${state.price.round()}',
//                   ),
//                   buildSlider(
//                     title: 'GST Rate (%)',
//                     value: state.gstRate,
//                     min: 1,
//                     max: 50,
//                     onChanged: cubit.updateGstRate,
//                     suffix: '${state.gstRate.toStringAsFixed(1)}%',
//                   ),
//                   const SizedBox(height: 20),
//                   resultTile(
//                     'GST Amount',
//                     '₹${state.totalGst.toStringAsFixed(2)}',
//                   ),
//                   resultTile(
//                     'Base Price (Excl. GST)',
//                     '₹${state.baseAmount.toStringAsFixed(2)}',
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// class ChartData {
//   final String category;
//   final double value;
//   ChartData(this.category, this.value);
// }
