import 'dart:io';

class AddServicesModel {
  File? image;
  String? title;

  AddServicesModel({this.image, this.title});
  Map<String, dynamic> toJson() => {
        "image": image,
        "title": title,
      };
}
