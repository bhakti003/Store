import 'dart:convert';

ItemData itemDataFromJson(String str) => ItemData.fromJson(json.decode(str));

String itemDataToJson(ItemData data) => json.encode(data.toJson());

class ItemData {
  ItemData(
      {this.itemCategory,
      this.itemName,
      this.itemPrice,
      this.itemurl,
      this.itemId,
      this.quantity});

  String? itemCategory;
  String? itemName;
  int? itemPrice;
  String? itemurl;
  String? itemId;
  int? quantity = 0;

  factory ItemData.fromJson(Map<dynamic, dynamic> json) => ItemData(
      itemCategory: json["itemCategory"],
      itemName: json["itemName"],
      itemPrice: json["itemPrice"],
      itemurl: json["itemUrl"],
      itemId: json["itemId"],
      quantity: json['quantity']);

  Map<dynamic, dynamic> toJson() => {
        "itemCategory": itemCategory,
        "itemName": itemName,
        "itemPrice": itemPrice,
        "itemId": itemId,
        "quantity": quantity
      };
}
