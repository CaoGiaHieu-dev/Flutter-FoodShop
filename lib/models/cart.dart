class Cart {
  String id;
  int createAt;
  int number;
  String total;
  String userId;
  String productId;
  String phonenumber;
  String address;

  Cart(
      {this.id,
      this.createAt,
      this.number,
      this.total,
      this.userId,
      this.productId,
      this.phonenumber});

  Cart.fromJson(Map<String, dynamic> json) 
  {
    id = json['id'];
    createAt = json['create_at'];
    number = json['number'];
    total = json['total'];
    userId = json['UserId'];
    productId = json['ProductId'];
    phonenumber = json['phonenumber'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() 
  {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['create_at'] = this.createAt;
    data['number'] = this.number;
    data['total'] = this.total;
    data['UserId'] = this.userId;
    data['ProductId'] = this.productId;
    data['phonenumber'] = this.phonenumber;
    data['address'] = this.address;
    return data;
  }
}