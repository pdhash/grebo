class PostModel {
  PostModel({
    required this.code,
    required this.message,
    required this.postData,
    required this.page,
    required this.limit,
    required this.size,
    required this.hasMore,
    required this.format,
    required this.timestamp,
  });

  int code;
  String message;
  List<PostData> postData;
  int page;
  int limit;
  int size;
  bool hasMore;
  String format;
  String timestamp;

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        code: json["code"],
        message: json["message"],
        postData:
            List<PostData>.from(json["data"].map((x) => PostData.fromJson(x))),
        page: json["page"],
        limit: json["limit"],
        size: json["size"],
        hasMore: json["hasMore"],
        format: json["format"],
        timestamp: json["timestamp"],
      );
}

class PostData {
  PostData({
    required this.id,
    required this.deleted,
    required this.userRef,
    required this.text,
    required this.thumbnail,
    required this.video,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.postUserDetail,
    required this.comment,
    required this.like,
    required this.isLike,
  });

  String id;
  bool deleted;
  String userRef;
  String text;
  String thumbnail;
  String image;

  String video;
  DateTime createdAt;
  DateTime updatedAt;
  PostUserDetail postUserDetail;
  int comment;
  int like;
  bool isLike;

  factory PostData.fromJson(Map<String, dynamic> json) => PostData(
        id: json["_id"],
        deleted: json["deleted"],
        userRef: json["userRef"],
        image: json["image"] ?? "",
        text: json["text"],
        thumbnail: json["thumbnail"],
        video: json["video"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        postUserDetail: PostUserDetail.fromJson(json["user"]),
        comment: json["comment"],
        like: json["like"],
        isLike: json["isLike"],
      );
}

class PostUserDetail {
  PostUserDetail({
    required this.id,
    required this.name,
    required this.picture,
    required this.verifiedByAdmin,
  });

  String id;
  String name;
  String picture;
  bool verifiedByAdmin;

  factory PostUserDetail.fromJson(Map<String, dynamic> json) => PostUserDetail(
        id: json["_id"],
        name: json["name"],
        picture: json["picture"],
        verifiedByAdmin: json["verifiedByAdmin"],
      );
}
