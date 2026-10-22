import 'package:flutter/material.dart';
import 'package:flux_wallet/core/utils/money_format.dart';
import 'package:flux_wallet/features/transactions/domain/entities/account.dart';

/// Amount text + chosen account of the payment sheet.
class PaymentController extends ChangeNotifier {
  PaymentController({required this.accounts, required this.remaining})
    : accountId = accounts.bankCard.id!;

  final List<Account> accounts;
  final double remaining;
  final text = TextEditingController();
  int accountId;

  double get amount => parseMoney(text.text) ?? 0;
  bool get isValid => amount > 0 && amount <= remaining + 0.005;

  void changed() => notifyListeners();

  void fillAll() {
    text.text = formatPlain(remaining);
    notifyListeners();
  }

  void selectAccount(int id) {
    accountId = id;
    notifyListeners();
  }

  @override
  void dispose() {
    text.dispose();
    super.dispose();
  }
}
