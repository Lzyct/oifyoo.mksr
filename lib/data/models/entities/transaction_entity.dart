class TransactionEntity {
  final int id;
  final String transactionNumber;
  final int idProduct;
  final int qty;
  final int price;
  final int discount;
  final String productName;
  final String type;
  final String status;
  final String note;
  final String buyer;
  final String createdAt;
  final String updatedAt;
  final int total;

  TransactionEntity({
    this.id,
    this.transactionNumber,
    this.idProduct,
    this.qty,
    this.price,
    this.discount,
    this.productName,
    this.type,
    this.status,
    this.note = "-",
    this.buyer,
    this.createdAt,
    this.updatedAt,
    this.total,
  });
}
