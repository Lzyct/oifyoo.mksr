class SpendingEntity {
  int? id;
  String? name;
  int? price;
  String? note;
  String? createdAt;
  String? updatedAt;

  SpendingEntity({
    this.id,
    this.name,
    this.price,
    this.note,
    this.createdAt,
    this.updatedAt,
  });

  SpendingEntity.clone(SpendingEntity source) {
    this.id = source.id;
    this.name = source.name;
    this.price = source.price;
    this.note = source.note;
    this.createdAt = source.createdAt;
    this.updatedAt = source.updatedAt;
  }
}
