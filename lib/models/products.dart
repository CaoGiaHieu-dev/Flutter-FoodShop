class Products {
  String id;
  String categoryId;
  String name;
  String image;
  bool hot;
  String price;
  bool discount;

  Products(
      {this.id,
      this.categoryId,
      this.name,
      this.image,
      this.hot,
      this.price,
      this.discount});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['CategoryId'];
    name = json['name'];
    image = json['image'];
    hot = json['hot'];
    price = json['price'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['CategoryId'] = this.categoryId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['hot'] = this.hot;
    data['price'] = this.price;
    data['discount'] = this.discount;
    return data;
  }
}
