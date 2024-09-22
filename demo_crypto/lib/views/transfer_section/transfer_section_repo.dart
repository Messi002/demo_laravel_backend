import 'dart:convert';
import 'dart:developer';

import 'package:demo_crypto/models/beneficiary.dart';
import 'package:demo_crypto/models/debit_account.dart';
import 'package:demo_crypto/models/generic_res.dart';
import 'package:demo_crypto/models/transfer.dart';
import 'package:demo_crypto/services/api_routes.dart';
import 'package:demo_crypto/services/api_services.dart';
import 'package:demo_crypto/services/global_response_model.dart';

class TransferSectionRepo {
  final ApiClient apiClient;

  TransferSectionRepo({required this.apiClient});

  Future<void> getTransfers() async {
    String url = "${ApiRoutes.baseUrl}${ApiRoutes.getTransfers}";
    ResponseModel response =
        await apiClient.request(url, Method.get, null, passHeader: true);

    if (response.statusCode == 200) {
      List<dynamic> responseData = jsonDecode(response.responseJson);
      // List<TransferModel> transfers = responseData
      //     .map((transferJson) => TransferModel.fromJson(transferJson))
      //     .toList();
      // return transfers;
    } else {
      log("getTransfers: ${response.message}", name: "TransferRepo-Error");
      throw Exception(response.message);
    }
  }

  Future<void> createTransfer({
    required String accountNumber,
    required String bank,
    required String beneficiaryName,
    required String beneficiaryAccountNumber,
    required double amount,
    required String description,
    required bool isAnonymous,
    required DateTime transactionDate,
  }) async {
    Map<String, dynamic> transferData = {
      'account_number': accountNumber,
      'bank': bank,
      'beneficiary_name': beneficiaryName,
      'beneficiary_account_number': beneficiaryAccountNumber,
      'amount': amount.toString(),
      'description': description,
      // 'is_anonymous': isAnonymous,
      'transaction_date': transactionDate.toIso8601String(),
    };

    String url = "${ApiRoutes.baseUrl}${ApiRoutes.createTransfer}";
    ResponseModel response = await apiClient.request(
      url,
      Method.post,
      transferData,
      passHeader: true,
    );
    log("hello there! ${response}");
    if (response.statusCode == 200) {
      log("Number 1");
      // TransferModel transfer = TransferModel.fromJson(
      //   jsonDecode(response.responseJson),
      // );
      // return transfer;
    } else {
      log("createTransfer: ${response.message}", name: "TransferRepo-Error");
      throw Exception(response.message);
    }
  }

  Future<GenericResponseModel<DebitAccountModel>> getDebitAccounts() async {
    String url = "${ApiRoutes.baseUrl}${ApiRoutes.getDebitAccounts}";
    ResponseModel response =
        await apiClient.request(url, Method.get, null, passHeader: true);

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.responseJson);
      GenericResponseModel<DebitAccountModel> debitAccountReponse =
          GenericResponseModel.fromJson(responseData,
              (json) => DebitAccountModel.fromJson(json), 'debitAccounts');

      return debitAccountReponse;
    } else {
      throw Exception(response.message);
    }
  }

  Future<GenericResponseModel<BeneficiaryModel>> getBeneficiaries(
      {int pageSize = 10, String? lastDocumentId}) async {
    String url =
        "${ApiRoutes.baseUrl}${ApiRoutes.updateBeneficiary}?pageSize=$pageSize";
    if (lastDocumentId != null) {
      url += "&lastDocumentId=$lastDocumentId";
    }

    ResponseModel response =
        await apiClient.request(url, Method.get, null, passHeader: true);

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.responseJson);
      // add logic to send nextItemId or add directly to generic but optional field

      GenericResponseModel<BeneficiaryModel> beneAccountReponse =
          GenericResponseModel.fromJson(responseData,
              (json) => BeneficiaryModel.fromJson(json), 'beneficiaries');

      return beneAccountReponse;
    } else {
      log("getBeneficiaries: ${response.message}",
          name: "BeneficiaryRepo-Error");
      throw Exception(response.message);
    }
  }

  Future<void> updateBeneficiary({
    required String id,
    required String name,
    required String bank,
    required String accountNumber,
  }) async {
    Map<String, dynamic> beneficiaryData = {
      'name': name,
      'bank': bank,
      'account_number': accountNumber,
    };

    String url = "${ApiRoutes.baseUrl}${ApiRoutes.updateBeneficiary}$id";
    ResponseModel response = await apiClient.request(
      url,
      Method.update,
      beneficiaryData,
      passHeader: true,
    );
    log("*******response: $response");
    if (response.statusCode != 200) {
      log("updateBeneficiary: ${response.message}",
          name: "BeneficiaryRepo-Error");
      throw Exception(response.message);
    }
  }

  Future<void> deleteBeneficiary(String id) async {
    String url = "${ApiRoutes.baseUrl}${ApiRoutes.updateBeneficiary}$id";
    ResponseModel response =
        await apiClient.request(url, Method.delete, null, passHeader: true);

    if (response.statusCode == 204) {
      log("deleteBeneficiary: ${response.message}",
          name: "BeneficiaryRepo-Error");
      throw Exception(response.message);
    }
  }
}
