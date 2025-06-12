import 'package:calcvio/core/utils/Appcolors.dart';
import 'package:calcvio/core/widgets/format_currency.dart';
import 'package:calcvio/core/widgets/result_widget.dart';
import 'package:calcvio/core/widgets/slider_widget.dart';
import 'package:calcvio/features/presentation/nps_calc/cubit/nps_cubit.dart';
import 'package:calcvio/features/presentation/provider/themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class NpsCalculatorPage extends StatelessWidget {
  const NpsCalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return BlocProvider(
      create: (_) => NpsCalculatorCubit(),
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
            title: Text("NPS Calculator"),
          ),

          backgroundColor:
              themeProvider.isDarkMode
                  ? AppColors.darkBackground
                  : AppColors.lightBackground,
          body: BlocBuilder<NpsCalculatorCubit, NpsCalculatorState>(
            builder: (context, state) {
              final cubit = context.read<NpsCalculatorCubit>();

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
                            ChartData("Invested", state.totalInvestment),
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
                      title: 'Monthly Contribution',
                      value: state.monthlyContribution,
                      min: 500,
                      max: 20000,
                      divisions: 1999,
                      onChanged: cubit.updateMonthlyContribution,
                      suffix: '₹${state.monthlyContribution.round()}',
                    ),
                    SliderForYears(
                      title: 'Current Age',
                      value: state.age,
                      min: 18,
                      max: 59,
                      divisions: 59 - 18,
                      onChanged: cubit.updateAge,
                      suffix: '${state.age.round()} yrs',
                    ),
                    SliderForPercentage(
                      title: 'Expected Return Rate (%)',
                      value: state.expectedRateOfReturn,
                      min: 1,
                      max: 20,
                      divisions: 19,
                      onChanged: cubit.updateExpectedRate,
                      suffix:
                          '${state.expectedRateOfReturn.toStringAsFixed(1)}%',
                    ),
                    SliderForPercentage(
                      title: 'Annuity % of Corpus',
                      value: state.annuityPercent,
                      min: 10,
                      max: 100,
                      divisions: 89,
                      onChanged: cubit.updateAnnuityPercent,
                      suffix: '${state.annuityPercent.toStringAsFixed(0)}%',
                    ),
                    SliderForPercentage(
                      title: 'Expected Annuity Return Rate (%)',
                      value: state.annuityRate,
                      min: 1,
                      max: 15,
                      divisions: 14,
                      onChanged: cubit.updateAnnuityRate,
                      suffix: '${state.annuityRate.toStringAsFixed(1)}%',
                    ),
                    SliderForYears(
                      title: 'Annuity Tenure (yrs)',
                      value: state.annuityTenure,
                      min: 1,
                      max: 40,
                      divisions: 39,
                      onChanged: cubit.updateAnnuityTenure,
                      suffix: '${state.annuityTenure.round()} yrs',
                    ),
                    const SizedBox(height: 20),
                    resultTile(
                      'Total Investment',
                      formatCurrency(state.totalInvestment),
                      context,
                    ),
                    resultTile(
                      'Pension Wealth',
                      formatCurrency(state.pensionWealth),
                      context,
                    ),
                    resultTile(
                      'Interest Earned',
                      formatCurrency(state.interestEarned),
                      context,
                    ),
                    resultTile(
                      'Annuity Amount',
                      formatCurrency(state.annuityAmount),
                      context,
                    ),
                    resultTile(
                      'Lumpsum Amount',
                      formatCurrency(state.lumpSum),
                      context,
                    ),
                    resultTile(
                      'Pension/Month',
                      formatCurrency(state.pensionPerMonth),
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
                            "NPS Calculation Formula",
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
                            "Pension Wealth = P × [(1 + r)^n − 1] × (1 + r) / r",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.indigo,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Where:\n"
                            "• P = Monthly Contribution\n"
                            "• r = Monthly Interest Rate (Expected Annual Return ÷ 12 ÷ 100)\n"
                            "• n = Total Contributions (Months until retirement)\n\n"
                            "Annuity Per Month = A × r / [1 − (1 + r)^-n]\n"
                            "• A = Annuity Investment (from pension wealth)\n"
                            "• r = Monthly Annuity Rate\n"
                            "• n = Annuity Tenure (in months)",
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
                            "This formula estimates the pension corpus accumulated through regular NPS contributions and "
                            "calculates expected monthly pension based on annuity conversion.",
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
                                  "Disclaimer: This calculation is an estimate and not 100% accurate. "
                                  "Final returns and pension amount may vary based on actual market performance, provider policies, and annuity plan terms.",
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
