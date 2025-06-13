import 'package:calcvio/core/utils/Appcolors.dart';
import 'package:calcvio/core/widgets/toggletheme.dart';
import 'package:calcvio/features/presentation/7th_pay_calc/cubit/7th_pay_cubit.dart';
import 'package:calcvio/features/presentation/7th_pay_calc/screen/7th_pay_screen.dart';
import 'package:calcvio/features/presentation/car_loan_calc/cubit/car_loan_cubit.dart';
import 'package:calcvio/features/presentation/car_loan_calc/screen/car_loan_page.dart';
import 'package:calcvio/features/presentation/educational_loan_calc/cubit/edu_cubit.dart';
import 'package:calcvio/features/presentation/educational_loan_calc/screen/edu_page.dart';
import 'package:calcvio/features/presentation/fd_calc/cubit/fd_cubit.dart';
import 'package:calcvio/features/presentation/fd_calc/screen/fd_page.dart';
import 'package:calcvio/features/presentation/gratuity_calc/cubit/gratuity_cubit.dart';
import 'package:calcvio/features/presentation/gratuity_calc/screen/gratuity_page.dart';
import 'package:calcvio/features/presentation/home_loan_calc/cubit/home_loan_cubit.dart';
import 'package:calcvio/features/presentation/home_loan_calc/screen/home_loan_page.dart';
import 'package:calcvio/features/presentation/lumpsum_calc/cubit/lumpsum_cubit.dart';
import 'package:calcvio/features/presentation/nps_calc/cubit/nps_cubit.dart';
import 'package:calcvio/features/presentation/nps_calc/screen/nps_page.dart';
import 'package:calcvio/features/presentation/personal_loan_calc/cubit/personal_loan_cubit.dart';
import 'package:calcvio/features/presentation/personal_loan_calc/screen/personal_loan_page.dart';
import 'package:calcvio/features/presentation/pf_calc/cubit/pf_cubit.dart';
import 'package:calcvio/features/presentation/pf_calc/screen/pf_page.dart';
import 'package:calcvio/features/presentation/provider/themeprovider.dart';
import 'package:calcvio/features/presentation/rd_calc/cubit/rd_cubit.dart';
import 'package:calcvio/features/presentation/rd_calc/screen/rd_page.dart';

import 'package:calcvio/features/presentation/sip_calc/cubit/sip_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:calcvio/features/presentation/sip_calc/screen/sip_page.dart';

import 'package:calcvio/features/presentation/lumpsum_calc/screen/lumpsum_page.dart';
import 'package:provider/provider.dart';

class FinancialCalculatorTabs extends StatefulWidget {
  const FinancialCalculatorTabs({super.key});

  @override
  State<FinancialCalculatorTabs> createState() =>
      _FinancialCalculatorTabsState();
}

class _FinancialCalculatorTabsState extends State<FinancialCalculatorTabs> {
  String? selectedCalculator;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            themeProvider.isDarkMode
                ? AppColors.darkBackground
                : AppColors.lightBackground,
        appBar: AppBar(
          title: const Text('Financial Calculators'),
          backgroundColor:
              themeProvider.isDarkMode
                  ? AppColors.darkBackground
                  : AppColors.lightBackground,
          surfaceTintColor:
              themeProvider.isDarkMode
                  ? AppColors.darkBackground
                  : AppColors.lightBackground,
          actions: [
            // Switch(
            //   value: themeProvider.isDarkMode,
            //   onChanged: (val) {
            //     themeProvider.toggleTheme(val);
            //   },
            // ),
            // IconButton(
            //   icon: Icon(
            //     themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
            //     color: Theme.of(context).iconTheme.color,
            //   ),
            //   tooltip:
            //       themeProvider.isDarkMode
            //           ? 'Switch to Light Mode'
            //           : 'Switch to Dark Mode',
            //   onPressed: () {
            //     themeProvider.toggleTheme(!themeProvider.isDarkMode);
            //   },
            // ),
            ThemeToggleIcon(),
          ],
        ),

        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Text(
                  "Investment Calculators",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 12, 16, 16),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 20,
                    childAspectRatio: 1,
                  ),
                  itemCount: investcalculators.length,
                  itemBuilder: (context, index) {
                    final calc = investcalculators[index];
                    return _buildCalculatorTile(calc['image']!, calc['key']!);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Text(
                  "Loan Calculators",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 20,
                    childAspectRatio: 1,
                  ),
                  itemCount: loancalculators.length,
                  itemBuilder: (context, index) {
                    final calc = loancalculators[index];
                    return _buildCalculatorTile(calc['image']!, calc['key']!);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Text(
                  "Salary Calculators",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 20,
                    childAspectRatio: 1,
                  ),
                  itemCount: salarycalculators.length,
                  itemBuilder: (context, index) {
                    final calc = salarycalculators[index];
                    return _buildCalculatorTile(calc['image']!, calc['key']!);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalculatorTile(String image, String key) {
    selectedCalculator == key;

    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        setState(() {
          selectedCalculator = key;
        });
        _navigateToCalculator(key);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Image.asset(image, fit: BoxFit.fill),
      ),
    );
  }

  void _navigateToCalculator(String key) {
    final page = _buildCalculatorWidget(key);

    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  Widget _buildCalculatorWidget(String calculator) {
    switch (calculator) {
      case 'sip':
        return BlocProvider(
          create: (_) => SipCalculatorCubit(),
          child: SipCalculatorPage(),
        );
      case 'lumpsum':
        return BlocProvider(
          create: (_) => LumpsumCalculatorCubit(),
          child: LumpsumCalculatorPage(),
        );

      case 'fd':
        return BlocProvider(
          create: (_) => FdCalculatorCubit(),
          child: FdCalculatorPage(),
        );
      case 'rd':
        return BlocProvider(
          create: (_) => RDCalculatorCubit(),
          child: RDCalculatorPage(),
        );
      case 'nps':
        return BlocProvider(
          create: (_) => NpsCalculatorCubit(),
          child: NpsCalculatorPage(),
        );
      case 'pf':
        return BlocProvider(
          create: (_) => PFCalculatorCubit(),
          child: PFCalculatorPage(),
        );
      case 'gratuity':
        return BlocProvider(
          create: (_) => GratuityCalculatorCubit(),
          child: GratuityCalculatorPage(),
        );
      case 'personal_loan':
        return BlocProvider(
          create: (_) => PersonalLoanCalculatorCubit(),
          child: PersonalLoanCalculatorPage(),
        );
      case 'home_loan':
        return BlocProvider(
          create: (_) => HomeLoanCalculatorCubit(),
          child: HomeLoanCalculatorPage(),
        );
      case 'car_loan':
        return BlocProvider(
          create: (_) => CarLoanCalculatorCubit(),
          child: CarLoanCalculatorPage(),
        );
      case 'educational_loan':
        return BlocProvider(
          create: (_) => EducationalLoanCalculatorCubit(),
          child: EducationalLoanCalculatorPage(),
        );
      case '7thpay':
        return BlocProvider(
          create: (_) => SeventhPayCalculatorCubit(),
          child: SeventhPayCalculatorPage(),
        );
      default:
        return const SizedBox();
    }
  }

  final List<Map<String, String>> investcalculators = [
    {'key': 'sip', 'image': 'assets/sip.png'},
    {'key': 'lumpsum', 'image': 'assets/lumpsum.png'},

    {'key': 'fd', 'image': 'assets/fd.png'},
    {'key': 'rd', 'image': 'assets/rd.png'},
    {'key': 'nps', 'image': 'assets/nps.png'},
  ];

  final List<Map<String, String>> loancalculators = [
    {'key': 'home_loan', 'image': 'assets/hl.png'},
    {'key': 'car_loan', 'image': 'assets/cl.png'},
    {'key': 'personal_loan', 'image': 'assets/pl.png'},
    {'key': 'educational_loan', 'image': 'assets/el.png'},
  ];

  final List<Map<String, String>> salarycalculators = [
    {'key': 'pf', 'image': 'assets/pf.png'},
    {'key': '7thpay', 'image': 'assets/7th.png'},
    {'key': 'gratuity', 'image': 'assets/gratuity.png'},
  ];
}
