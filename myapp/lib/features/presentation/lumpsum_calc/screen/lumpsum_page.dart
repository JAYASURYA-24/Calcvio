import 'package:calcvio/core/utils/Appcolors.dart';

import 'package:calcvio/core/widgets/format_currency.dart';
import 'package:calcvio/core/widgets/result_widget.dart';
import 'package:calcvio/core/widgets/slider_widget.dart';
import 'package:calcvio/features/presentation/lumpsum_calc/cubit/lumpsum_cubit.dart';
import 'package:calcvio/features/presentation/lumpsum_calc/cubit/lumpsum_state.dart';
import 'package:calcvio/features/presentation/provider/themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LumpsumCalculatorPage extends StatelessWidget {
  const LumpsumCalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return BlocProvider(
      create: (_) => LumpsumCalculatorCubit(),
      child: SafeArea(
        child: Scaffold(
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
            title: Text("Lumpsum Calculator"),
          ),
          backgroundColor:
              themeProvider.isDarkMode
                  ? AppColors.darkBackground
                  : AppColors.lightBackground,

          body: BlocBuilder<LumpsumCalculatorCubit, LumpsumCalculatorState>(
            builder: (context, state) {
              final cubit = context.read<LumpsumCalculatorCubit>();
              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: ListView(
                  children: [
                    SfCircularChart(
                      palette: [
                        AppColors.lightChartFill,
                        AppColors.lightChartLine,
                      ],
                      legend: Legend(isVisible: true), // disable default legend
                      series: <CircularSeries>[
                        DoughnutSeries<ChartData, String>(
                          dataSource: [
                            ChartData('Invested', state.invested),
                            ChartData('Gains', state.gains),
                          ],

                          xValueMapper: (ChartData data, _) => data.category,
                          yValueMapper: (ChartData data, _) => data.value,
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
                      value: state.amount,
                      min: 500,
                      max: 1000000,
                      divisions: 1999,
                      onChanged: cubit.updateAmount,
                      suffix: formatCurrency(state.amount),
                    ),
                    SliderForPercentage(
                      title: 'Expected Return',
                      value: state.returns,
                      min: 1,
                      max: 30,
                      divisions: 299,
                      onChanged: cubit.updateReturns,
                      suffix: '${state.returns.toStringAsFixed(1)}%',
                    ),
                    SliderForYears(
                      title: 'Investment Period',
                      value: state.years,
                      min: 1,
                      max: 40,
                      divisions: 39,
                      onChanged: cubit.updateYears,
                      suffix: '${state.years.round()} yrs',
                    ),
                    const SizedBox(height: 20),

                    resultTile(
                      'Invested Amount',
                      formatCurrency(state.invested),
                      context,
                    ),
                    resultTile(
                      'Estimated Returns',
                      formatCurrency(state.gains),
                      context,
                    ),
                    resultTile(
                      'Maturity Amount',
                      formatCurrency(state.maturity),
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
                            "Lumpsum Calculation Formula",
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
                            "A = P × (1 + r)^n",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.indigo,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Where:\n"
                            "• P = Initial Investment Amount\n"
                            "• r = Annual Interest Rate (in decimal)\n"
                            "• n = Investment Duration in Years",
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
                            "This formula calculates the future value of a one-time lumpsum investment, assuming a fixed annual rate of return compounded yearly.",
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
                                  "Actual results may vary based on market conditions and investment performance.",
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
