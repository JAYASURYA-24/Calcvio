import 'package:calcvio/core/utils/Appcolors.dart';
import 'package:calcvio/core/widgets/format_currency.dart';
import 'package:calcvio/core/widgets/result_widget.dart';
import 'package:calcvio/core/widgets/slider_widget.dart';
import 'package:calcvio/features/presentation/gratuity_calc/cubit/gratuity_cubit.dart';
import 'package:calcvio/features/presentation/gratuity_calc/cubit/gratuity_state.dart';
import 'package:calcvio/features/presentation/provider/themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class GratuityCalculatorPage extends StatelessWidget {
  const GratuityCalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return BlocProvider(
      create: (_) => GratuityCalculatorCubit(),
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
            title: Text("Gratuity Calculator"),
          ),
          backgroundColor:
              themeProvider.isDarkMode
                  ? AppColors.darkBackground
                  : AppColors.lightBackground,

          body: BlocBuilder<GratuityCalculatorCubit, GratuityCalculatorState>(
            builder: (context, state) {
              final cubit = context.read<GratuityCalculatorCubit>();
              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: ListView(
                  children: [
                    SizedBox(height: 10),
                    SliderforAmount(
                      title: 'Basic Salary',
                      value: state.basicSalary,
                      min: 0,
                      max: 500000,
                      divisions: 500000 - 0,
                      onChanged: cubit.updateBasicSalary,
                      suffix: formatCurrency(state.basicSalary),
                    ),
                    SliderforAmount(
                      title: 'Dearness Allowance',
                      value: state.da,
                      min: 0,
                      max: 500000,
                      divisions: 500000 - 0,
                      onChanged: cubit.updateDA,
                      suffix: formatCurrency(state.da),
                    ),
                    SliderForYears(
                      title: 'Years of Service',
                      value: state.years,
                      min: 5,
                      max: 70,
                      divisions: 64,
                      onChanged: cubit.updateYears,
                      suffix: '${state.years.round()} yrs',
                    ),
                    SliderForMonth(
                      title: 'Month of Service',
                      value: state.month,
                      min: 0,
                      max: 12,
                      divisions: 12 - 0,
                      onChanged: cubit.updateMonth,
                      suffix: '${state.month.round()} Month',
                    ),
                    const SizedBox(height: 20),
                    resultTile(
                      'Total EPF Amount',
                      formatCurrency(state.gratuity),
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
                            "Gratuity Calculation Formula",
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
                            "Gratuity = (Basic + DA) × Years of Service × 15 / 26",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.indigo,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "• Basic: Your last drawn basic salary\n"
                            "• DA: Dearness Allowance\n"
                            "• 15: Number of wage days considered for gratuity\n"
                            "• 26: Average working days in a month\n"
                            "• Years of Service: Includes partial year if ≥ 7 months (rounded up)",
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
                            "Example: If you've served 5 years and 7 months, service is counted as 6 years.",
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
                                  "Note: Applicable if you've completed at least 5 years of continuous service. Gratuity rules may vary for government vs private employees.",
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
