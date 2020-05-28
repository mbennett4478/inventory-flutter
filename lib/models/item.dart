class Item {
  final String id;
  final String description;
  final String name;
  final String typename;

  Item({this.id, this.description, this.name, this.typename});

  Item.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        description = json['description'],
        name = json['name'],
        typename = json['__typename'];
  
  Map<String, Object> toMap() {
    return {
      '__typename': typename,
      'id': id,
      'description': description,
      'name': name,
    };
  }
}