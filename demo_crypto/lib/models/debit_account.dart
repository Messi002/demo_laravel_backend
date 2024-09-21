import 'package:flutter/foundation.dart';

@immutable
class DebitAccountModel {
  final String id;
  final String bankName;
  final String accountNumber;

  const DebitAccountModel({
    required this.id,
    required this.bankName,
    required this.accountNumber,
  });

  factory DebitAccountModel.fromJson(Map<String, dynamic> json) {
    return DebitAccountModel(
      id: json['id'] as String,
      bankName: json['bank_name'] as String,
      accountNumber: json['account_number'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'bank_name': bankName,
      'account_number': accountNumber,
    };
  }

  @override
  String toString() =>
      'DebitAccount(id: $id, bankName: $bankName, accountNumber: $accountNumber)';

  DebitAccountModel copyWith({
    String? id,
    String? bankName,
    String? accountNumber,
  }) {
    return DebitAccountModel(
      id: id?? this.id,

      bankName: bankName ?? this.bankName,
      accountNumber: accountNumber ?? this.accountNumber,
    );
  }
}
