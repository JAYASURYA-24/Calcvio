import 'package:calcvio/core/utils/Appcolors.dart';
import 'package:calcvio/core/widgets/format_currency.dart';
import 'package:calcvio/core/widgets/result_widget.dart';
import 'package:calcvio/core/widgets/slider_widget.dart';
import 'package:calcvio/features/presentation/7th_pay_calc/cubit/7th_pay_cubit.dart';
import 'package:calcvio/features/presentation/7th_pay_calc/cubit/7th_pay_state.dart';
import 'package:calcvio/features/presentation/provider/themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class SeventhPayCalculatorPage extends StatelessWidget {
  const SeventhPayCalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return BlocProvider(
      create: (_) => SeventhPayCalculatorCubit(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor:
              themeProvider.isDarkMode
                  ? AppColors.darkBackground
                  : AppColors.lightBackground,
          appBar: AppBar(
            surfaceTintColor:
                themeProvider.isDarkMode
                    ? AppColors.darkBackground
                    : AppColors.lightBackground,
            backgroundColor:
                themeProvider.isDarkMode
                    ? AppColors.darkBackground
                    : AppColors.lightBackground,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
            title: const Text('7th Pay Calculator'),
          ),
          body: BlocBuilder<SeventhPayCalculatorCubit, SeventhPayState>(
            builder: (context, state) {
              final cubit = context.read<SeventhPayCalculatorCubit>();
              return Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 20),
                child: ListView(
                  children: [
                    SizedBox(height: 10),
                    // SfCircularChart(
                    //   palette: [
                    //     Colors.teal,
                    //     Colors.orangeAccent,
                    //     Colors.deepPurple,
                    //     Colors.lightBlue,
                    //   ],
                    //   legend: Legend(isVisible: true),
                    //   series: <CircularSeries>[
                    //     DoughnutSeries<ChartData, String>(
                    //       dataSource: [
                    //         ChartData("Basic Pay", state.basicPay),
                    //         ChartData("HRA", state.hraAmount),
                    //         ChartData("DA", state.daAmount),
                    //         ChartData("TA", state.taAmount),
                    //       ],
                    //       xValueMapper: (data, _) => data.category,
                    //       yValueMapper: (data, _) => data.value,
                    //       dataLabelMapper:
                    //           (ChartData data, _) =>
                    //               data.value.toStringAsFixed(2),
                    //       dataLabelSettings: const DataLabelSettings(
                    //         isVisible: true,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    SliderforAmount(
                      title: 'Basic Pay',
                      value: state.basicPay,
                      min: 10000,
                      max: 100000,
                      divisions: 1999,
                      onChanged: cubit.updateBasicPay,
                      suffix: '₹${state.basicPay.round()}',
                    ),
                    SliderForPercentage(
                      title: 'HRA (%)',
                      value: state.hraPercent,
                      min: 0,
                      max: 40,
                      divisions: 40,
                      onChanged: cubit.updateHra,
                      suffix: '${state.hraPercent.toStringAsFixed(1)}%',
                    ),
                    SliderForPercentage(
                      title: 'DA (%)',
                      value: state.daPercent,
                      min: 0,
                      max: 40,
                      divisions: 40,
                      onChanged: cubit.updateDa,
                      suffix: '${state.daPercent.toStringAsFixed(1)}%',
                    ),
                    SliderforAmount(
                      title: 'TA',
                      value: state.ta,
                      min: 500,
                      max: 10000,
                      divisions: 1000,
                      onChanged: cubit.updateTa,
                      suffix: '₹${state.ta.round()}',
                    ),
                    const SizedBox(height: 20),
                    resultTile(
                      'HRA Amount',
                      formatCurrency(state.hraAmount),
                      context,
                    ),
                    resultTile(
                      'DA Amount',
                      formatCurrency(state.daAmount),
                      context,
                    ),
                    resultTile(
                      'TA Amount',
                      formatCurrency(state.taAmount),
                      context,
                    ),
                    const Divider(),
                    resultTile(
                      'Total Pay',
                      formatCurrency(state.totalPay),
                      context,
                    ),
                    SizedBox(height: 25),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color:
                            themeProvider.isDarkMode
                                ? AppColors.darkCard
                                : AppColors.lightCard,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color:
                                themeProvider.isDarkMode
                                    ? Colors.white30
                                    : Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "7th Pay Commission Salary Calculation",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color:
                                  themeProvider.isDarkMode
                                      ? AppColors.darkTextSecondary
                                      : AppColors.lightTextPrimary,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Total Salary = Basic Pay + HRA + DA + TA + DA on TA",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.indigo,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "• HRA (House Rent Allowance) = HRA% of Basic Pay\n"
                            "• DA (Dearness Allowance) = DA% of Basic Pay\n"
                            "• TA (Transport Allowance) = Fixed Amount\n"
                            "• DA on TA = TA × DA%",
                            style: TextStyle(
                              fontSize: 14,
                              color:
                                  themeProvider.isDarkMode
                                      ? AppColors.darkTextSecondary
                                      : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "So, Final TA Component = TA + (TA × DA%)\n"
                            "And Final Salary = Basic Pay + HRA + DA + [TA + DA on TA]",
                            style: TextStyle(
                              fontSize: 14,
                              color:
                                  themeProvider.isDarkMode
                                      ? AppColors.darkTextSecondary
                                      : Colors.black54,
                            ),
                          ),
                          const Divider(height: 30),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: Colors.orange,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  "Disclaimer: This is a general estimation of 7th Pay salary. Allowance rules may vary by department and posting location.",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color:
                                        themeProvider.isDarkMode
                                            ? AppColors.darkTextSecondary
                                            : Colors.grey[700],
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ChartData {
  final String category;
  final double value;

  ChartData(this.category, this.value);
}
