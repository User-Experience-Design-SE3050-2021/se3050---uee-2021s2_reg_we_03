// To parse this JSON data, do
//
//     final paymentDetails = paymentDetailsFromJson(jsonString);

import 'dart:convert';

PaymentDetails paymentDetailsFromJson(String str) => PaymentDetails.fromJson(json.decode(str));

String paymentDetailsToJson(PaymentDetails data) => json.encode(data.toJson());

class PaymentDetails {
  PaymentDetails({
    required this.cardId,
    required this.itemCount,
    required this.totalPrice,
    required this.selectedItems,
    required this.paymentCards,
  });

  String cardId;
  int itemCount;
  int totalPrice;
  List<SelectedItem> selectedItems;
  List<PaymentCard> paymentCards;

  factory PaymentDetails.fromJson(Map<String, dynamic> json) => PaymentDetails(
    cardId: json["cardId"],
    itemCount: json["itemCount"],
    totalPrice: json["totalPrice"],
    selectedItems: List<SelectedItem>.from(json["selectedItems"].map((x) => SelectedItem.fromJson(x))),
    paymentCards: List<PaymentCard>.from(json["paymentCards"].map((x) => PaymentCard.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "cardId": cardId,
    "itemCount": itemCount,
    "totalPrice": totalPrice,
    "selectedItems": List<dynamic>.from(selectedItems.map((x) => x.toJson())),
    "paymentCards": List<dynamic>.from(paymentCards.map((x) => x.toJson())),
  };
}

class PaymentCard {
  PaymentCard({
    required this.id,
    required this.cardNumber,
    required this.expiryDate,
    required this.cardHolderName,
    required this.cvvCode,
    required this.cardHolder,
    required this.v,
  });

  String id;
  String cardNumber;
  String expiryDate;
  String cardHolderName;
  String cvvCode;
  String cardHolder;
  int v;

  factory PaymentCard.fromJson(Map<String, dynamic> json) => PaymentCard(
    id: json["_id"],
    cardNumber: json["cardNumber"],
    expiryDate: json["expiryDate"],
    cardHolderName: json["cardHolderName"],
    cvvCode: json["cvvCode"],
    cardHolder: json["cardHolder"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "cardNumber": cardNumber,
    "expiryDate": expiryDate,
    "cardHolderName": cardHolderName,
    "cvvCode": cvvCode,
    "cardHolder": cardHolder,
    "__v": v,
  };
}

class SelectedItem {
  SelectedItem({
    required this.id,
    required this.size,
    required this.additions,
    required this.count,
    required this.totPrice,
    required this.isSelected,
    required this.pizzaPrice,
    required this.image,
    required this.productName,
    required this.v,
  });

  String id;
  String size;
  List<String> additions;
  int count;
  int totPrice;
  bool isSelected;
  int pizzaPrice;
  String image;
  String productName;
  int v;

  factory SelectedItem.fromJson(Map<String, dynamic> json) => SelectedItem(
    id: json["_id"],
    size: json["size"],
    additions: List<String>.from(json["additions"].map((x) => x)),
    count: json["count"],
    totPrice: json["totPrice"],
    isSelected: json["isSelected"],
    pizzaPrice: json["pizzaPrice"],
    image: json["image"],
    productName: json["productName"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "size": size,
    "additions": List<dynamic>.from(additions.map((x) => x)),
    "count": count,
    "totPrice": totPrice,
    "isSelected": isSelected,
    "pizzaPrice": pizzaPrice,
    "image": image,
    "productName": productName,
    "__v": v,
  };
}
