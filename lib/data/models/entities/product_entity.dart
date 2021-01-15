class ProductEntity {
  int id;
  String productName;
  String note;
  int stock;
  int capitalPrice;
  int sellingPrice;
  String createdAt;
  String updatedAt;

  ProductEntity({
    this.id,
    this.productName,
    this.note,
    this.stock,
    this.capitalPrice,
    this.sellingPrice,
    this.createdAt,
    this.updatedAt,
  });
}
