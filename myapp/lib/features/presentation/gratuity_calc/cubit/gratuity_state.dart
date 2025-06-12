class GratuityCalculatorState {
  final double basicSalary;
  final double da;
  final double years;
  final double gratuity;
  final double month;

  GratuityCalculatorState({
    required this.basicSalary,
    required this.da,
    required this.years,
    this.gratuity = 0,
    this.month = 0,
  });

  GratuityCalculatorState copyWith({
    double? basicSalary,
    double? da,
    double? years,
    double? gratuity,
    double? month,
  }) {
    return GratuityCalculatorState(
      basicSalary: basicSalary ?? this.basicSalary,
      da: da ?? this.da,
      years: years ?? this.years,
      gratuity: gratuity ?? this.gratuity,
      month: month ?? this.month,
    );
  }
}
