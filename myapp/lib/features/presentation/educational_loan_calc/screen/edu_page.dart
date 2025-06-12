import 'package:calcvio/features/presentation/educational_loan_calc/cubit/edu_cubit.dart';
import 'package:calcvio/features/presentation/educational_loan_calc/cubit/edu_state.dart';
import 'package:calcvio/features/presentation/provider/themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:calcvio/core/utils/Appcolors.dart';
import 'package:calcvio/core/widgets/format_currency.dart';
import 'package:calcvio/core/widgets/result_widget.dart';
import 'package:calcvio/core/widgets/slider_widget.dart';

class EducationalLoanCalculatorPage extends StatelessWidget {
  const EducationalLoanCalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return BlocProvider(
      create: (_) => EducationalLoanCalculatorCubit(),
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
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text('Educational Loan Calculator'),
          ),
          backgroundColor:
              themeProvider.isDarkMode
                  ? AppColors.darkBackground
                  : AppColors.lightBackground,
          body: BlocBuilder<
            EducationalLoanCalculatorCubit,
            EducationalLoanState
          >(
            builder: (context, state) {
              final cubit = context.read<EducationalLoanCalculatorCubit>();
              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
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
                            ChartData('Principal', state.amount),
                            ChartData(
                              'Total Interest',
                              state.totalInterestPayment,
                            ),
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
                    const SizedBox(height: 10),
                    SliderforAmount(
                      title: 'Loan Amount',
                      value: state.amount,
                      min: 50000,
                      max: 2000000,
                      divisions: 2000000 - 50000,
                      onChanged: cubit.updateAmount,
                      suffix: formatCurrency(state.amount),
                    ),
                    SliderForYearMonth(
                      title: 'Loan Tenure',
                      value: state.years * 12,
                      min: 6,
                      max: 120,
                      onChanged: (months) => cubit.updateYears(months / 12),
                    ),
                    SliderForPercentage(
                      title: 'Rate of Interest',
                      value: state.interestRate,
                      min: 4,
                      max: 15,
                      divisions: 110,
                      onChanged: cubit.updateInterestRate,
                      suffix: '${state.interestRate.toStringAsFixed(1)}%',
                    ),
                    const SizedBox(height: 20),
                    resultTile(
                      'Monthly EMI',
                      formatCurrency(state.monthlyEMI),
                      context,
                    ),
                    resultTile(
                      'Total Interest',
                      formatCurrency(state.totalInterestPayment),
                      context,
                    ),
                    resultTile(
                      'Interest Percentage',
                      '${state.interestPercentage.toStringAsFixed(2)}%',
                      context,
                    ),
                    resultTile(
                      'Total Amount Payable',
                      formatCurrency(state.totalPayment),
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
                            "Educational Loan EMI Formula",
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
                            "EMI = P × r × (1 + r)^n / [(1 + r)^n − 1]",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.indigo,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Where:\n"
                            "• P = Loan Amount (Principal)\n"
                            "• r = Monthly Interest Rate (Annual Rate ÷ 12 ÷ 100)\n"
                            "• n = Loan Tenure in Months (Years × 12)",
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
                            "This formula helps you calculate your monthly EMI for an education loan, "
                            "assuming fixed interest and consistent monthly payments.",
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
                                  "Disclaimer: The EMI shown here is an approximate value. Actual EMI and interest may vary "
                                  "based on your bank’s terms, moratorium period, and repayment schedule.",
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
