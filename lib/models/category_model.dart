class CategoryModel {
  int id;
  String name;

  CategoryModel({
    required this.id,
    required this.name,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json['id'],
    name: json['name'],
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class UninitializedCategoryModel extends CategoryModel {
  UninitializedCategoryModel() : super(
    id: 0, 
    name: ''
  );
}
