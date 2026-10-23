import 'package:flux_wallet/core/di/use_cases/auth_use_cases.dart';
import 'package:flux_wallet/core/di/use_cases/budget_use_cases.dart';
import 'package:flux_wallet/core/di/use_cases/debt_use_cases.dart';
import 'package:flux_wallet/core/di/use_cases/notification_use_cases.dart';
import 'package:flux_wallet/core/di/use_cases/profile_use_cases.dart';
import 'package:flux_wallet/core/di/use_cases/schedule_use_cases.dart';
import 'package:flux_wallet/core/di/use_cases/screen_use_cases.dart';
import 'package:flux_wallet/core/di/use_cases/security_use_cases.dart';
import 'package:flux_wallet/core/di/use_cases/settings_use_cases.dart';
import 'package:flux_wallet/core/di/use_cases/use_case_deps.dart';

/// Every use-case group in one place; `AppUseCases` supplies what they need.
abstract class UseCaseBundle extends UseCaseDeps
    with
        AuthUseCases,
        ProfileUseCases,
        SecurityUseCases,
        BudgetUseCases,
        ScheduleUseCases,
        DebtUseCases,
        NotificationUseCases,
        ScreenUseCases,
        SettingsUseCases {}
