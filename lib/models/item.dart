class Item {
  final String id;
  final String description;
  final String name;

  Item({this.id, this.description, this.name});

  Item.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        description = json['description'],
        name = json['name'];
}