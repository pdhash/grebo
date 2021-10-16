// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

class NotificationModel {
  NotificationModel({
    required this.code,
    required this.message,
    required this.data,
    required this.page,
    required this.limit,
    required this.size,
    required this.hasMore,
    required this.format,
    required this.timestamp,
  });

  int code;
  String message;
  List<Datum> data;
  int page;
  int limit;
  int size;
  bool hasMore;
  String format;
  String timestamp;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        code: json["code"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        page: json["page"],
        limit: json["limit"],
        size: json["size"],
        hasMore: json["hasMore"],
        format: json["format"],
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "page": page,
        "limit": limit,
        "size": size,
        "hasMore": hasMore,
        "format": format,
        "timestamp": timestamp,
      };
}

class Datum {
  Datum({
    required this.id,
    required this.seen,
    required this.userRef,
    required this.type,
    required this.sourceRef,
    required this.text,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.deleted,
  });

  String id;
  bool seen;
  String userRef;
  int type;
  String sourceRef;
  String text;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  bool deleted;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        seen: json["seen"],
        userRef: json["userRef"],
        type: json["type"],
        sourceRef: json["sourceRef"],
        text: json["text"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        deleted: json["deleted"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "seen": seen,
        "userRef": userRef,
        "type": type,
        "sourceRef": sourceRef,
        "text": text,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "deleted": deleted,
      };
}
