class CurrentUserModel {
  CurrentUserModel({
    required this.code,
    required this.message,
    required this.data,
    required this.format,
    required this.timestamp,
  });

  int code;
  String message;
  Datum data;
  String format;
  String timestamp;

  factory CurrentUserModel.fromJson(Map<String, dynamic> json) =>
      CurrentUserModel(
        code: json["code"] ?? 0,
        message: json["message"] ?? "",
        data: Datum.fromJson(json["data"] ?? DateTime.now()),
        format: json["format"] ?? "",
        timestamp: json["timestamp"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data.toJson(),
        "format": format,
        "timestamp": timestamp,
      };
}

class Datum {
  Datum({
    required this.accessToken,
    required this.user,
  });

  String accessToken;
  User user;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        accessToken: json["accessToken"] ?? "",
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "user": user.toJson(),
      };
}

class User {
  User({
    location,
    this.userType = 0,
    this.verifiedByAdmin = false,
    this.images = const [],
    this.websites = const [],
    this.workingDays = const [],
    this.verified = false,
    this.blocked = false,
    this.deleted = false,
    this.id = "",
    this.email = "",
    this.picture = "",
    createdOn,
    updatedOn,
    this.businessName = "",
    this.description = "",
    endTime,
    this.name = "",
    this.phoneCode = "",
    this.phoneNumber = "",
    startTime,
  })  : this.location = Location(),
        this.createdOn = DateTime.now(),
        this.endTime = DateTime.now(),
        this.updatedOn = DateTime.now(),
        this.startTime = DateTime.now();

  Location location;
  int userType;
  bool verifiedByAdmin;
  List<String> images;
  List<String> websites;
  List<int> workingDays;
  bool verified;
  bool blocked;
  bool deleted;
  String id;
  String email;
  String picture;
  DateTime createdOn;
  DateTime updatedOn;
  String businessName;
  String description;
  DateTime endTime;
  String name;
  String phoneCode;
  String phoneNumber;
  DateTime startTime;

  factory User.fromJson(Map<String, dynamic> json) => User(
        location: Location.fromJson(json["location"]),
        userType: json["userType"] ?? 1,
        verifiedByAdmin: json["verifiedByAdmin"] ?? false,
        images: List<String>.from((json["images"] ?? []).map((x) => x)),
        websites: List<String>.from((json["websites"] ?? []).map((x) => x)),
        workingDays: List<int>.from((json["workingDays"] ?? []).map((x) => x)),
        verified: json["verified"] ?? false,
        blocked: json["blocked"] ?? false,
        deleted: json["deleted"] ?? false,
        id: json["_id"] ?? "",
        email: json["email"] ?? "",
        picture: json["picture"] ?? "",
        createdOn: DateTime.parse(json["createdOn"] ?? DateTime.now()),
        updatedOn: DateTime.parse(json["updatedOn"] ?? DateTime.now()),
        businessName: json["businessName"] ?? "",
        description: json["description"] ?? "",
        endTime: DateTime.parse(json["endTime"] ?? DateTime.now()),
        name: json["name"] ?? "",
        phoneCode: json["phoneCode"] ?? "",
        phoneNumber: json["phoneNumber"] ?? "",
        startTime: DateTime.parse(json["startTime"] ?? DateTime.now()),
      );

  Map<String, dynamic> toJson() => {
        "location": location.toJson(),
        "userType": userType,
        "verifiedByAdmin": verifiedByAdmin,
        "images": List<dynamic>.from(images.map((x) => x)),
        "websites": List<dynamic>.from(websites.map((x) => x)),
        "workingDays": List<dynamic>.from(workingDays.map((x) => x)),
        "verified": verified,
        "blocked": blocked,
        "deleted": deleted,
        "_id": id,
        "email": email,
        "picture": picture,
        "createdOn": createdOn.toIso8601String(),
        "updatedOn": updatedOn.toIso8601String(),
        "businessName": businessName,
        "description": description,
        "endTime": endTime.toIso8601String(),
        "name": name,
        "phoneCode": phoneCode,
        "phoneNumber": phoneNumber,
        "startTime": startTime.toIso8601String(),
      };
}

class Location {
  Location({
    this.address = "",
    this.type = "",
    this.coordinates = const [],
  });

  String address;
  String type;
  List<double> coordinates;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        address: json["address"],
        type: json["type"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}
