import 'package:flutter/foundation.dart';

@immutable
class ResponseModel {
  final bool isSuccess;
  final int statusCode;
  final String message;
  final String responseJson;

  const ResponseModel({
    required this.isSuccess,
    required this.statusCode,
    required this.message,
    required this.responseJson,
  });

  Map<String, dynamic> toJson() {
    return {
      'isSuccess': isSuccess,
      'statusCode': statusCode,
      'message': message,
      'responseJson': responseJson,
    };
  }

  @override
  String toString() {
    return 'ResponseModel(isSuccess: $isSuccess, statusCode: $statusCode, message: $message, responseJson: $responseJson)';
  }

  ResponseModel copyWith({
    bool? isSuccess,
    int? statusCode,
    String? message,
    String? responseJson,
  }) {
    return ResponseModel(
      isSuccess: isSuccess ?? this.isSuccess,
      statusCode: statusCode ?? this.statusCode,
      message: message ?? this.message,
      responseJson: responseJson ?? this.responseJson,
    );
  }
}

@immutable
class ResponseModel2 {
  final String remark;
  final String status;
  final Message message;

  const ResponseModel2({
    required this.remark,
    required this.status,
    required this.message,
  });

  factory ResponseModel2.fromJson(Map<String, dynamic> json) {
    return ResponseModel2(
      remark: json['remark'] as String,
      status: json['status'] as String,
      message: Message.fromJson(json['message'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'remark': remark,
      'status': status,
      'message': message.toJson(),
    };
  }

  @override
  String toString() => 'ResponseModel2(remark: $remark, status: $status, message: $message)';

  ResponseModel2 copyWith({
    String? remark,
    String? status,
    Message? message,
  }) {
    return ResponseModel2(
      remark: remark ?? this.remark,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}

@immutable
class Message {
  final String error;

  const Message({
    required this.error,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      error: json['error'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'error': error,
    };
  }

  @override
  String toString() => 'Message(error: $error)';

  Message copyWith({String? error}) {
    return Message(
      error: error ?? this.error,
    );
  }
}
