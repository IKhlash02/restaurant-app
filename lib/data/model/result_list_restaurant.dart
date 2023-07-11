import 'dart:convert';

class ResultListRestauran {
  final bool error;
  final String message;
  final int count;

  ResultListRestauran({
    required this.error,
    required this.message,
    required this.count,
  });

  factory ResultListRestauran.fromRawJson(String str) =>
      ResultListRestauran.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResultListRestauran.fromJson(Map<String, dynamic> json) =>
      ResultListRestauran(
        error: json["error"],
        message: json["message"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
      };
}
