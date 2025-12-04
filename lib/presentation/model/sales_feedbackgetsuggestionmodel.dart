import 'dart:convert';

FeedbackGetSuggestionModel feedbackGetSuggestionModelFromJson(String str) =>
    FeedbackGetSuggestionModel.fromJson(json.decode(str));

class FeedbackGetSuggestionModel {
  bool success;
  String message;
  List<SuggestionList> payload;

  FeedbackGetSuggestionModel({
    required this.success,
    required this.message,
    required this.payload,
  });

  factory FeedbackGetSuggestionModel.fromJson(Map<String, dynamic> json) =>
      FeedbackGetSuggestionModel(
        success: json["success"],
        message: json["message"],
        payload: List<SuggestionList>.from(
            json["payload"].map((x) => SuggestionList.fromJson(x))),
      );
}

class SuggestionList {
  String internalId;
  String name;

  SuggestionList({
    required this.internalId,
    required this.name,
  });

  factory SuggestionList.fromJson(Map<String, dynamic> json) => SuggestionList(
        internalId: json["internalId"].toString(),
        name: json["name"],
      );
}
