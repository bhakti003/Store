// To parse this JSON data, do
//
//     final userdata = userdataFromJson(jsonString);

import 'dart:convert';

Userdata userdataFromJson(String str) => Userdata.fromJson(json.decode(str));

String userdataToJson(Userdata data) => json.encode(data.toJson());

class Userdata {
  Userdata({
    this.fullName,
    this.email,
    this.dob,
    this.phone,
    this.profileUrl,
    this.favoriteItemData,
  });

  String? fullName;
  String? email;
  String? dob;
  String? phone;
  String? profileUrl;
  List? favoriteItemData;
  // String? favList;

  factory Userdata.fromJson(Map<String, dynamic> json) => Userdata(
      fullName: json["fullName"],
      email: json["email"],
      dob: json["dob"],
      phone: json["phone"],
      profileUrl: json["profileUrl"],
      favoriteItemData: json["favList"]);

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "email": email,
        "favList": favoriteItemData,
        "dob": dob,
        "phone": phone,
        "profileUrl": profileUrl,
      };
}
