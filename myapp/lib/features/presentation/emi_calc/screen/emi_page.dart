// import 'package:financial_calc/core/widgets/result_widget.dart';
// import 'package:financial_calc/core/widgets/slider_widget.dart';
// import 'package:financial_calc/features/presentation/emi_calc/cubit/emi_cubit.dart';
// import 'package:financial_calc/features/presentation/emi_calc/cubit/emi_state.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// class EmiCalculatorPage extends StatelessWidget {
//   const EmiCalculatorPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => EMICalculatorCubit(),
//       child: Scaffold(
//         appBar: AppBar(title: const Text('EMI Calculator')),
//         body: BlocBuilder<EMICalculatorCubit, EMICalculatorState>(
//           builder: (context, state) {
//             final cubit = context.read<EMICalculatorCubit>();
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
//                           ChartData("Principal", state.principalAmount),
//                           ChartData("Interest", state.totalInterestPayment),
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
//                     title: 'Loan Amount',
//                     value: state.principalAmount,
//                     min: 5000,
//                     max: 1000000,
//                     onChanged: cubit.updatePrincipalAmount,
//                     suffix: '₹${state.principalAmount.round()}',
//                   ),
//                   buildSlider(
//                     title: 'Annual Interest Rate',
//                     value: state.interestRate,
//                     min: 1,
//                     max: 30,
//                     onChanged: cubit.updateInterestRate,
//                     suffix: '${state.interestRate.toStringAsFixed(1)}%',
//                   ),
//                   buildSlider(
//                     title: 'Loan Tenure (years)',
//                     value: state.years,
//                     min: 1,
//                     max: 40,
//                     onChanged: cubit.updateYears,
//                     suffix: '${state.years.round()} yrs',
//                   ),
//                   const SizedBox(height: 20),
//                   resultTile(
//                     'Monthly EMI',
//                     '₹${state.monthlyEMI.toStringAsFixed(2)}',
//                   ),
//                   resultTile(
//                     'Total Payment',
//                     '₹${state.totalPayment.toStringAsFixed(2)}',
//                   ),
//                   resultTile(
//                     'Total Interest Payment',
//                     '₹${state.totalInterestPayment.toStringAsFixed(2)}',
//                   ),
//                   resultTile(
//                     'Interest Percentage',
//                     '${state.interestPercentage.toStringAsFixed(2)}%',
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
