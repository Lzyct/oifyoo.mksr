import 'package:flutter/cupertino.dart';

class ProductEntity {
  int id;
  String productName;
  String note;
  int qty;
  int price;
  String createdAt;
  String updatedAt;
  bool isSelected = false;
  TextEditingController textEditingController =
      new TextEditingController(text: "1");

  ProductEntity({
    this.id,
    this.productName,
    this.note,
    this.qty = 0,
    this.price,
    this.createdAt,
    this.updatedAt,
  });

  ProductEntity.clone(ProductEntity source) {
    this.id = source.id;
    this.productName = source.productName;
    this.note = source.note;
    this.qty = source.qty;
    this.price = source.price;
    this.createdAt = source.createdAt;
    this.updatedAt = source.updatedAt;
  }
}
