import 'package:calcvio/core/utils/Appcolors.dart';
import 'package:calcvio/core/widgets/format_currency.dart';
import 'package:calcvio/core/widgets/result_widget.dart';
import 'package:calcvio/core/widgets/slider_widget.dart';
import 'package:calcvio/features/presentation/fd_calc/cubit/fd_cubit.dart';
import 'package:calcvio/features/presentation/fd_calc/cubit/fd_state.dart';
import 'package:calcvio/features/presentation/provider/themeprovider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FdCalculatorPage extends StatelessWidget {
  const FdCalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return DefaultTabController(
      length: 2,
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
            title: Text("Fixed Deposit Calculator"),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          backgroundColor:
              themeProvider.isDarkMode
                  ? AppColors.darkBackground
                  : AppColors.lightBackground,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: TabBar(
                  indicatorColor: AppColors.lightChartLine,
                  labelColor: AppColors.lightSliderActive,
                  unselectedLabelColor:
                      themeProvider.isDarkMode
                          ? AppColors.darkTextSecondary
                          : Colors.black54,
                  dividerColor: Colors.transparent,

                  tabs: [
                    Tab(text: "Simple Interest"),
                    Tab(text: "Compound Interest"),
                  ],
                ),
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    FdTabContent(type: FdType.simple),
                    FdTabContent(type: FdType.compound),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FdTabContent extends StatelessWidget {
  final FdType type;

  const FdTabContent({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return BlocBuilder<FdCalculatorCubit, FdCalculatorState>(
      builder: (context, state) {
        final cubit = context.read<FdCalculatorCubit>();

        if (state.type != type) cubit.updateType(type);

        return Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 20),
          child: ListView(
            children: [
              SfCircularChart(
                palette: [AppColors.lightChartFill, AppColors.lightChartLine],
                legend: const Legend(isVisible: true),
                series: <CircularSeries>[
                  DoughnutSeries<ChartData, String>(
                    dataSource: [
                      ChartData("Invested", state.principal),
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

              if (type == FdType.compound)
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: DropdownButtonFormField<int>(
                    dropdownColor:
                        themeProvider.isDarkMode
                            ? AppColors.darkCard
                            : AppColors.lightBackground,
                    value: state.compoundFreq,
                    items: const [
                      DropdownMenuItem(child: Text("Yearly"), value: 1),
                      DropdownMenuItem(child: Text("Half-Yearly"), value: 2),
                      DropdownMenuItem(child: Text("Quarterly"), value: 4),
                      DropdownMenuItem(child: Text("Monthly"), value: 12),
                    ],
                    onChanged: (v) {
                      if (v != null) cubit.updateFrequency(v);
                    },
                    style: TextStyle(color: AppColors.lightSliderActive),
                    decoration: InputDecoration(
                      labelText: 'Compounding Frequency',
                      labelStyle: TextStyle(
                        color:
                            themeProvider.isDarkMode
                                ? AppColors.darkTextPrimary
                                : AppColors.lightTextPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.lightSliderInactive,
                          width: 4,
                        ), // Color when not focused
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.lightSliderInactive,
                          width: 4,
                        ), // Color when focused
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              SliderforAmount(
                title: 'Principal Amount',
                value: state.principal,
                min: 500,
                max: 1000000,
                divisions: 1999,
                onChanged: cubit.updatePrincipal,
                suffix: formatCurrency(state.principal),
              ),
              SliderForPercentage(
                title: 'Interest Rate (%)',
                value: state.rate,
                min: 1,
                max: 25,
                divisions: 249,
                onChanged: cubit.updateRate,
                suffix: formatCurrency(state.rate),
              ),
              SliderForYears(
                title: 'Time Period (years)',
                value: state.years,
                min: 1,
                max: 50,
                divisions: 49,
                onChanged: cubit.updateYears,
                suffix: formatCurrency(state.years),
              ),
              const SizedBox(height: 20),
              resultTile(
                'Maturity Amount',
                formatCurrency(state.maturityAmount),
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
                      "FD Calculation Formulas",
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
                      "Simple Interest:\nA = P + (P × r × t)",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.indigo,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Compound Interest:\nA = P × (1 + r/n)^(n × t)",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.indigo,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Where:\n"
                      "• P = Principal Amount\n"
                      "• r = Annual Interest Rate (in decimal)\n"
                      "• t = Time in Years\n"
                      "• n = Compounding Frequency per Year\n"
                      "• A = Maturity Amount",
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
                      "Depending on your selection, the calculator uses either the simple or compound interest formula to estimate your Fixed Deposit returns.",
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
                            "Actual results may vary depending on your bank’s policies and compounding rules.",
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
    );
  }
}

class ChartData {
  final String category;
  final double value;
  ChartData(this.category, this.value);
}
