import 'package:flutter/foundation.dart';

@immutable
class BeneficiaryModel {
  final String id;
  final String name;
  final String bank;
  final String accountNumber;

  const BeneficiaryModel({
    required this.id,
    required this.name,
    required this.bank,
    required this.accountNumber,
  });

  factory BeneficiaryModel.fromJson(Map<String, dynamic> json) {
    return BeneficiaryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      bank: json['bank'] as String,
      accountNumber: json['account_number'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id'  : id,
      'name': name,
      'bank': bank,
      'account_number': accountNumber,
    };
  }

  @override
  String toString() =>
      'Beneficiary(id: $id, name: $name, bank: $bank, accountNumber: $accountNumber)';

  BeneficiaryModel copyWith({
    String? id,
    String? name,
    String? bank,
    String? accountNumber,
  }) {
    return BeneficiaryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      bank: bank ?? this.bank,
      accountNumber: accountNumber ?? this.accountNumber,
    );
  }
}
