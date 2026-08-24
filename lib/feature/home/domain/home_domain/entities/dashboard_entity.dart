import 'package:equatable/equatable.dart';

// ============================================================
// DASHBOARD ENTITY (Domain)
// ------------------------------------------------------------
// Overview stats shown on Home. Extra API fields (trends,
// recent patients) stay unused until a later screen needs them.
// ============================================================

class DashboardOverviewStatEntity extends Equatable {
  const DashboardOverviewStatEntity({
    required this.key,
    required this.title,
    required this.formattedValue,
    this.subtitle,
  });

  final String key;
  final String title;
  final String formattedValue;
  final String? subtitle;

  factory DashboardOverviewStatEntity.empty({
    required String key,
    required String title,
  }) {
    return DashboardOverviewStatEntity(
      key: key,
      title: title,
      formattedValue: '—',
    );
  }

  @override
  List<Object?> get props => [key, title, formattedValue, subtitle];
}

class DashboardEntity extends Equatable {
  const DashboardEntity({
    required this.totalEmployees,
    required this.totalPatients,
    required this.monthlyIncome,
    required this.monthlyExpenses,
  });

  final DashboardOverviewStatEntity totalEmployees;
  final DashboardOverviewStatEntity totalPatients;
  final DashboardOverviewStatEntity monthlyIncome;
  final DashboardOverviewStatEntity monthlyExpenses;

  factory DashboardEntity.empty() {
    return DashboardEntity(
      totalEmployees: DashboardOverviewStatEntity.empty(
        key: 'total_employees',
        title: 'Total Employees',
      ),
      totalPatients: DashboardOverviewStatEntity.empty(
        key: 'total_patients',
        title: 'Total Patients',
      ),
      monthlyIncome: DashboardOverviewStatEntity.empty(
        key: 'monthly_income',
        title: 'Monthly Income',
      ),
      monthlyExpenses: DashboardOverviewStatEntity.empty(
        key: 'monthly_expenses',
        title: 'Monthly Expenses',
      ),
    );
  }

  @override
  List<Object?> get props => [
        totalEmployees,
        totalPatients,
        monthlyIncome,
        monthlyExpenses,
      ];
}
