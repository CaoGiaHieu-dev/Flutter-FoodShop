class Cart {
  String id;
  String createAt;
  double  total;
  String userId;
  String productId;
  String phonenumber;
  String address;
  int number;

  Cart(
      {this.id,
      this.createAt,
      this.total,
      this.userId,
      this.productId,
      this.phonenumber,
      this.address,
      this.number});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createAt = json['create_at'];
    total = json['total'];
    userId = json['UserId'];
    productId = json['ProductId'];
    phonenumber = json['phonenumber'];
    address = json['address'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['create_at'] = this.createAt;
    data['total'] = this.total;
    data['UserId'] = this.userId;
    data['ProductId'] = this.productId;
    data['phonenumber'] = this.phonenumber;
    data['address'] = this.address;
    data['number'] = this.number;
    return data;
  }
}