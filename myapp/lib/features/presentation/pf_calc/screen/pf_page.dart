import 'package:calcvio/core/utils/Appcolors.dart';
import 'package:calcvio/core/widgets/format_currency.dart';
import 'package:calcvio/core/widgets/result_widget.dart';
import 'package:calcvio/core/widgets/slider_widget.dart';
import 'package:calcvio/features/presentation/pf_calc/cubit/pf_cubit.dart';
import 'package:calcvio/features/presentation/pf_calc/cubit/pf_state.dart';
import 'package:calcvio/features/presentation/provider/themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class PFCalculatorPage extends StatelessWidget {
  const PFCalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return BlocProvider(
      create: (_) => PFCalculatorCubit(),
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
            title: Text("PF Calculator"),
          ),
          backgroundColor:
              themeProvider.isDarkMode
                  ? AppColors.darkBackground
                  : AppColors.lightBackground,

          body: BlocBuilder<PFCalculatorCubit, PFCalculatorState>(
            builder: (context, state) {
              final cubit = context.read<PFCalculatorCubit>();
              return ListView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                children: [
                  SizedBox(height: 10),
                  SliderForYears(
                    title: 'Current Age',
                    value: state.currentAge,
                    min: 16,
                    max: 100,
                    divisions: 100 - 16,
                    onChanged: cubit.updateCurrentAge,
                    suffix: '${state.currentAge.round()} yrs',
                  ),
                  SliderForYears(
                    title: 'Retirement Age',
                    value: state.retirementAge,
                    min: state.currentAge + 1,
                    max: 100,
                    divisions: (100 - (state.currentAge + 1)).toInt(),

                    onChanged: cubit.updateRetirementAge,
                    suffix: '${state.retirementAge.round()} yrs',
                  ),
                  SliderforAmount(
                    title: 'Monthly Basic Salary',
                    value: state.salary,
                    min: 1000,
                    max: 1000000,
                    divisions: 1000,
                    onChanged: cubit.updateSalary,
                    suffix: formatCurrency(state.salary),
                  ),
                  SliderforAmount(
                    title: 'Current PF Balance',
                    value: state.currentPFBalance,
                    min: 0,
                    max: 50000000,
                    divisions: 10000,
                    onChanged: cubit.updateCurrentPFBalance,
                    suffix: formatCurrency(state.currentPFBalance),
                  ),
                  SliderForPercentage(
                    title: 'Employee Contribution',
                    value: state.empContrib,
                    min: 0,
                    max: 50,
                    divisions: 500,
                    onChanged: cubit.updateEmpContrib,
                    suffix: '${state.empContrib.toStringAsFixed(1)}%',
                  ),
                  SliderForPercentage(
                    title: 'Employer Contribution',
                    value: state.emprContrib,
                    min: 0,
                    max: 20,
                    divisions: 200,
                    onChanged: cubit.updateEmprContrib,
                    suffix: '${state.emprContrib.toStringAsFixed(1)}%',
                  ),
                  SliderForPercentage(
                    title: 'Expected Increase In Salary',
                    value: state.salaryGrowth,
                    min: 0,
                    max: 100,
                    divisions: 1000,
                    onChanged: cubit.updateSalaryGrowth,
                    suffix: '${state.salaryGrowth.toStringAsFixed(1)}%',
                  ),
                  SliderForPercentage(
                    title: 'Current Interest Rate',
                    value: state.interestRate,
                    min: 0,
                    max: 20,
                    divisions: 200,
                    onChanged: cubit.updateInterestRate,
                    suffix: '${state.interestRate.toStringAsFixed(1)}%',
                  ),

                  const SizedBox(height: 20),

                  resultTile(
                    'Total EPF Amount',
                    formatCurrency(state.totalEPF),
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
                          "Provident Fund (PF) Calculation Formula",
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
                          "Annual Contribution = (Monthly Salary × Employee Contribution%) + (Monthly Salary × Employer Contribution%) × 12",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.indigo,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "For each year:\n"
                          "• Updated Salary = Salary + (Salary × Annual Growth%)\n"
                          "• Interest = (Opening Balance + Annual Contribution) × Interest Rate\n"
                          "• Closing Balance = Opening Balance + Annual Contribution + Interest\n\n"
                          "Final PF = Future Value of all yearly contributions with compounding interest.",
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
                          "Your existing PF balance is added in year 1 and also accrues interest annually.",
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
                                "Disclaimer: This is an estimated projection based on the values provided. Actual PF accumulation may vary depending on salary structure, contribution caps, and policy changes.",
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
              );
            },
          ),
        ),
      ),
    );
  }
}
