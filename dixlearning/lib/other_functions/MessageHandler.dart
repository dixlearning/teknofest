import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class Result<T> {
  final T? data;
  final String? error;

  Result({this.data, this.error});
}

class ResultQuestion {
  int? questionId;
  int? status;
  String? user_id;

  ResultQuestion({this.questionId, this.status});

  ResultQuestion.fromJson(Map<String, dynamic> json) {
    questionId = json['questionId'];
    status = json['status'];
    user_id = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questionId'] = this.questionId;
    data['status'] = this.status;
    data['user_id'] = this.user_id;
    return data;
  }
}

void ResultHandler(BuildContext context, ContentType contentType,
    String ErrorTitle, String ErrorContext) {
  final errorHandler = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: ErrorTitle,
      message: ErrorContext,
      contentType: contentType,
    ),
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(errorHandler);
}
