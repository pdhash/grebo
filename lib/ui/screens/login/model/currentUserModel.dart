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
    this.profileCompleted = false,
    this.id = "",
    this.email = "",
    this.picture = "",
    this.categories = const [],
    createdOn,
    updatedOn,
    this.businessName = "",
    this.description = "",
    this.endTime = "",
    this.name = "",
    this.phoneCode = "",
    this.phoneNumber = "",
    this.startTime = "",
    this.services = const [],
  })  : this.location = Location(),
        this.createdOn = DateTime.now(),
        this.updatedOn = DateTime.now();

  Location location;
  List<Category> categories;
  int userType;
  bool verifiedByAdmin;
  List<String> images;
  bool profileCompleted;
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
  String endTime;
  String name;
  String phoneCode;
  String phoneNumber;
  String startTime;
  List<ServiceList> services;

  factory User.fromJson(Map<String, dynamic> json) => User(
        location: Location.fromJson(json["location"]),
        userType: json["userType"] ?? 1,
        verifiedByAdmin: json["verifiedByAdmin"] ?? false,
        images: List<String>.from((json["images"] ?? []).map((x) => x)),
        websites: List<String>.from((json["websites"] ?? []).map((x) => x)),
        workingDays: List<int>.from((json["workingDays"] ?? []).map((x) => x)),
        verified: json["verified"] ?? false,
        profileCompleted: json["profileCompleted"] ?? false,
        blocked: json["blocked"] ?? false,
        deleted: json["deleted"] ?? false,
        id: json["_id"] ?? "",
        email: json["email"] ?? "",
        picture: json["picture"] ?? "",
        createdOn: DateTime.parse(json["createdOn"] ?? DateTime.now()),
        updatedOn: DateTime.parse(json["updatedOn"] ?? DateTime.now()),
        businessName: json["businessName"] ?? "",
        description: json["description"] ?? "",
        endTime: json["endTime"] ?? "",
        name: json["name"] ?? "",
        phoneCode: json["phoneCode"] ?? "",
        phoneNumber: json["phoneNumber"] ?? "",
        startTime: json["startTime"] ?? "",
        categories: List<Category>.from(
            (json["categories"] ?? []).map((x) => Category.fromJson(x))),
        services: List<ServiceList>.from(
            (json["services"] ?? []).map((x) => ServiceList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "location": location.toJson(),
        "userType": userType,
        "verifiedByAdmin": verifiedByAdmin,
        "images": List<dynamic>.from(images.map((x) => x)),
        "websites": List<dynamic>.from(websites.map((x) => x)),
        "workingDays": List<dynamic>.from(workingDays.map((x) => x)),
        "categories": List<dynamic>.from(categories.map((e) => e.toJson())),
        "services": List<dynamic>.from(services.map((x) => x.toJson())),
        "verified": verified,
        "blocked": blocked,
        "deleted": deleted,
        "_id": id,
        "profileCompleted": profileCompleted,
        "email": email,
        "picture": picture,
        "createdOn": createdOn.toIso8601String(),
        "updatedOn": updatedOn.toIso8601String(),
        "businessName": businessName,
        "description": description,
        "endTime": endTime,
        "name": name,
        "phoneCode": phoneCode,
        "phoneNumber": phoneNumber,
        "startTime": startTime,
      };
}

class ServiceList {
  ServiceList({
    this.image = "",
    this.name = "",
  });

  String image;
  String name;

  factory ServiceList.fromJson(Map<String, dynamic> json) => ServiceList(
        image: json["image"] ?? "",
        name: json["name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "name": name,
      };
}

class Category {
  Category({
    this.id = "",
    this.name = "",
    this.categoryRef = "",
  });

  String id;
  String name;
  String categoryRef;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"] ?? "",
        name: json["name"] ?? "",
        categoryRef: json["categoryRef"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "categoryRef": categoryRef,
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
        address: json["address"] ?? "",
        type: json["type"] ?? "",
        coordinates: List<double>.from(
            (json["coordinates"] ?? []).map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}
