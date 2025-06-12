import 'package:calcvio/core/utils/Appcolors.dart';
import 'package:calcvio/core/widgets/format_currency.dart';
import 'package:calcvio/core/widgets/result_widget.dart';
import 'package:calcvio/core/widgets/slider_widget.dart';
import 'package:calcvio/features/presentation/provider/themeprovider.dart';
import 'package:calcvio/features/presentation/rd_calc/cubit/rd_cubit.dart';
import 'package:calcvio/features/presentation/rd_calc/cubit/rd_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RDCalculatorPage extends StatelessWidget {
  const RDCalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return BlocProvider(
      create: (_) => RDCalculatorCubit(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Recurring Deposit Calculator"),
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
          ),
          backgroundColor:
              themeProvider.isDarkMode
                  ? AppColors.darkBackground
                  : AppColors.lightBackground,

          body: BlocBuilder<RDCalculatorCubit, RDCalculatorState>(
            builder: (context, state) {
              final cubit = context.read<RDCalculatorCubit>();
              return Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 20),
                child: ListView(
                  children: [
                    SfCircularChart(
                      palette: [
                        AppColors.lightChartFill,
                        AppColors.lightChartLine,
                      ],
                      legend: Legend(isVisible: true),
                      series: <CircularSeries>[
                        DoughnutSeries<ChartData, String>(
                          dataSource: [
                            ChartData("Invested", state.principalAmount),
                            ChartData("Gains", state.interestEarned),
                          ],
                          xValueMapper: (data, _) => data.category,
                          yValueMapper: (data, _) => data.value,
                          innerRadius: "80%",
                          cornerStyle: CornerStyle.endCurve,
                          dataLabelMapper:
                              (ChartData data, _) => formatCurrency(data.value),
                          dataLabelSettings: DataLabelSettings(
                            isVisible: true,
                            textStyle: TextStyle(
                              color:
                                  themeProvider.isDarkMode
                                      ? AppColors.darkTextPrimary
                                      : AppColors.lightTextPrimary,
                            ),
                            labelPosition: ChartDataLabelPosition.inside,
                          ),
                        ),
                      ],
                    ),
                    SliderforAmount(
                      title: 'Monthly Investment',
                      value: state.monthlyInvestment,
                      min: 500,
                      max: 100000,
                      onChanged: cubit.updateMonthlyInvestment,
                      divisions: 1999,
                      suffix: '₹${state.monthlyInvestment.round()}',
                    ),
                    SliderForPercentage(
                      title: 'Rate of Interest',
                      value: state.interestRate,
                      min: 1,
                      max: 15,
                      divisions: 149,
                      onChanged: cubit.updateInterestRate,
                      suffix: '${state.interestRate.toStringAsFixed(1)}%',
                    ),
                    SliderForMonth(
                      title: 'Investment Period (Months)',
                      value: state.months,
                      min: 6,
                      max: 120,
                      divisions: 120 - 6,
                      onChanged: cubit.updateMonths,
                      suffix: '${state.months.round()} months',
                    ),
                    const SizedBox(height: 20),
                    resultTile(
                      'Invested Amount',
                      formatCurrency(state.principalAmount),
                      context,
                    ),
                    resultTile(
                      'Maturity Amount',
                      formatCurrency(state.maturityValue),
                      context,
                    ),
                    resultTile(
                      'Interest Earned',
                      formatCurrency(state.interestEarned),
                      context,
                    ),
                    SizedBox(height: 25),

                    Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 20),
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
                            "RD Calculation Formula",
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
                            "Maturity Value = P × N + [P × N × (N + 1) × R] / (2 × 12 × 100)",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.indigo,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Where:\n"
                            "• P = Monthly Deposit Amount\n"
                            "• N = Number of Months\n"
                            "• R = Annual Interest Rate (%)",
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
                            "This formula estimates the maturity amount for a Recurring Deposit, assuming monthly compounding and uniform monthly investments.",
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
                                  "Disclaimer: This calculation provides an estimated value and is not 100% accurate. "
                                  "Actual maturity value may vary depending on your bank’s compounding rules and investment schedule.",
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
