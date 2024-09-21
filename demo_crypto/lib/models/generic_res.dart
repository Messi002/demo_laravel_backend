import 'package:flutter/foundation.dart';

@immutable
class GenericResponseModel<T> {
  final bool isSuccess;
  final int statusCode;
  final String message;
  final List<T> items;

  const GenericResponseModel({
    required this.isSuccess,
    required this.statusCode,
    required this.message,
    required this.items,
    //make items optional and add another string for error 
  });

  factory GenericResponseModel.fromJson(
      Map<String, dynamic> json,
      T Function(Map<String, dynamic>) fromJsonModel,
      String listKey
      ) {
    var itemsList = (json['responseJson'][listKey] as List)
        .map((itemJson) => fromJsonModel(itemJson))
        .toList();

    return GenericResponseModel<T>(
      isSuccess: json['isSuccess'] as bool,
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      items: itemsList,
    );
  }

  Map<String, dynamic> toJson(
      Map<String, dynamic> Function(T) toJsonModel, String listKey) {
    return {
      'isSuccess': isSuccess,
      'statusCode': statusCode,
      'message': message,
      'responseJson': {
        listKey: items.map((item) => toJsonModel(item)).toList(),
      },
    };
  }
}
