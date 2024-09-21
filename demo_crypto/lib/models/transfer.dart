import 'package:flutter/foundation.dart';

@immutable
class TransferModel {
  final String id;
  final String accountNumber;
  final String bank;
  final String beneficiaryName;
  final String beneficiaryAccountNumber;
  final double amount;
  final String description;
  final bool isAnonymous;
  final DateTime transactionDate;

  const TransferModel({
    required this.id,
    required this.accountNumber,
    required this.bank,
    required this.beneficiaryName,
    required this.beneficiaryAccountNumber,
    required this.amount,
    required this.description,
    required this.isAnonymous,
    required this.transactionDate,
  });

  factory TransferModel.fromJson(Map<String, dynamic> json) {
    return TransferModel(
      id: json['id'] as String,
      accountNumber: json['account_number'] as String,
      bank: json['bank'] as String,
      beneficiaryName: json['beneficiary_name'] as String,
      beneficiaryAccountNumber: json['beneficiary_account_number'] as String,
      amount: (json['amount'] as num).toDouble(),
      description: json['description'] as String,
      isAnonymous: json['is_anonymous'] as bool,
      transactionDate: DateTime.parse(json['transaction_date'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'account_number': accountNumber,
      'bank': bank,
      'beneficiary_name': beneficiaryName,
      'beneficiary_account_number': beneficiaryAccountNumber,
      'amount': amount,
      'description': description,
      'is_anonymous': isAnonymous,
      'transaction_date': transactionDate.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'Transfer(id: $id, accountNumber: $accountNumber, bank: $bank, beneficiaryName: $beneficiaryName, '
        'beneficiaryAccountNumber: $beneficiaryAccountNumber, amount: $amount, description: $description, '
        'isAnonymous: $isAnonymous, transactionDate: $transactionDate)';
  }

  TransferModel copyWith({
    String? id,
    String? accountNumber,
    String? bank,
    String? beneficiaryName,
    String? beneficiaryAccountNumber,
    double? amount,
    String? description,
    bool? isAnonymous,
    DateTime? transactionDate,
  }) {
    return TransferModel(
      id: id ?? this.id,
      accountNumber: accountNumber ?? this.accountNumber,
      bank: bank ?? this.bank,
      beneficiaryName: beneficiaryName ?? this.beneficiaryName,
      beneficiaryAccountNumber:
          beneficiaryAccountNumber ?? this.beneficiaryAccountNumber,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      isAnonymous: isAnonymous ?? this.isAnonymous,
      transactionDate: transactionDate ?? this.transactionDate,
    );
  }
}
