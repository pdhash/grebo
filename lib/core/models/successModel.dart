class SuccessModel {
  SuccessModel({
    required this.code,
    required this.message,
    required this.format,
    required this.timestamp,
  });

  int code;
  String message;
  String format;
  String timestamp;

  factory SuccessModel.fromJson(Map<String, dynamic> json) => SuccessModel(
      code: json["code"] ?? -1,
      message: json["message"] ?? "",
      format: json["format"] ?? "",
      timestamp: json["timestamp"] ?? "");
}
