class Category
{
  String id;
  String name;
  String title;
  String image;

  Category({this.id, this.title, this.name, this.image});

  Category.fromJSON(Map<String, dynamic> json)
  {
    id= json['id'];
    name = json['name'];
    title = json['title'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() 
  {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['title'] = this.title;
    data['image'] = this.image;
    return data;
  }
}
