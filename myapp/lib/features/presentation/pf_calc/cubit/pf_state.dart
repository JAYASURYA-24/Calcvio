class PFCalculatorState {
  final double salary;
  final double empContrib;
  final double emprContrib;
  final double interestRate;
  final double currentAge;
  final double retirementAge;
  final double salaryGrowth;
  final double balance;
  final double totalInterest;
  final double totalEPF;
  final double currentPFBalance;

  PFCalculatorState({
    required this.salary,
    required this.empContrib,
    required this.emprContrib,
    required this.interestRate,
    required this.currentAge,
    required this.retirementAge,
    required this.salaryGrowth,
    this.balance = 0,
    this.totalInterest = 0,
    this.totalEPF = 0,
    this.currentPFBalance = 0,
  });

  PFCalculatorState copyWith({
    double? salary,
    double? empContrib,
    double? emprContrib,
    double? interestRate,
    double? currentAge,
    double? retirementAge,
    double? salaryGrowth,
    double? balance,
    double? totalInterest,
    double? totalEPF,
    double? currentPFBalance,
  }) {
    return PFCalculatorState(
      salary: salary ?? this.salary,
      empContrib: empContrib ?? this.empContrib,
      emprContrib: emprContrib ?? this.emprContrib,
      interestRate: interestRate ?? this.interestRate,
      currentAge: currentAge ?? this.currentAge,
      retirementAge: retirementAge ?? this.retirementAge,
      salaryGrowth: salaryGrowth ?? this.salaryGrowth,
      balance: balance ?? this.balance,
      totalInterest: totalInterest ?? this.totalInterest,
      totalEPF: totalEPF ?? this.totalEPF,
      currentPFBalance: currentPFBalance ?? this.currentPFBalance,
    );
  }
}
