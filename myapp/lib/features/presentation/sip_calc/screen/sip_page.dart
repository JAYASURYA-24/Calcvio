import 'package:calcvio/core/utils/Appcolors.dart';
import 'package:calcvio/core/widgets/format_currency.dart';
import 'package:calcvio/core/widgets/result_widget.dart';
import 'package:calcvio/core/widgets/slider_widget.dart';
import 'package:calcvio/features/presentation/provider/themeprovider.dart';
import 'package:calcvio/features/presentation/sip_calc/cubit/sip_cubit.dart';
import 'package:calcvio/features/presentation/sip_calc/cubit/sip_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SipCalculatorPage extends StatelessWidget {
  const SipCalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return BlocProvider(
      create: (_) => SipCalculatorCubit(),
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
            title: Text("SIP Calculator"),
          ),
          backgroundColor:
              themeProvider.isDarkMode
                  ? AppColors.darkBackground
                  : AppColors.lightBackground,
          body: BlocBuilder<SipCalculatorCubit, SipCalculatorState>(
            builder: (context, state) {
              final cubit = context.read<SipCalculatorCubit>();

              return Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 20),
                child: ListView(
                  children: [
                    SfCircularChart(
                      palette: [
                        AppColors.lightChartFill,
                        AppColors.lightChartLine,
                      ],
                      legend: const Legend(isVisible: true),
                      series: <CircularSeries>[
                        DoughnutSeries<ChartData, String>(
                          dataSource: [
                            ChartData('Invested', state.invested),
                            ChartData('Gains', state.gains),
                          ],
                          xValueMapper: (ChartData data, _) => data.label,
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
                      onChanged: cubit.updateAmount,
                      divisions: 1999,
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
                      divisions: 399,
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
                            "SIP Calculation Formula",
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
                            "M = P × [(1 + r)^n − 1] × (1 + r) / r",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.indigo,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Where:\n"
                            "• P = Monthly Investment\n"
                            "• r = Monthly Interest Rate (Annual rate ÷ 12 ÷ 100)\n"
                            "• n = Total Months (Years × 12)",
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
                            "This formula helps estimate the future value of your monthly SIP investments, "
                            "assuming a fixed rate of return compounded monthly.",
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
                                  "Actual results may vary based on market conditions and fund performance.",
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
  final String label;
  final double value;
  ChartData(this.label, this.value);
}
