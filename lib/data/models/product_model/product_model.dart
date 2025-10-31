class ProductCategoriesModel {
  int? id;
  String? name;
  String? slug;
  String? image;
  DateTime? creationAt;
  DateTime? updatedAt;

  ProductCategoriesModel({
    this.id,
     this.name,
     this.slug,
     this.image,
     this.creationAt,
     this.updatedAt,
  });

  factory ProductCategoriesModel.fromJson(Map <String ,dynamic> json) => ProductCategoriesModel(
      id: json["id"],
      name: json["name"],
      slug: json["slug"],
      image: json["image"],
      creationAt: json["creationAt"] is String ? DateTime.parse(json["creationAt"]) : null,
      updatedAt: json["updatedAt"] is String ? DateTime.parse(json["updatedAt"]) : null,
  );


  Map<String, dynamic> toJson()=>{
    "id":id,
    "name":name,
    "slug":slug,
    "image":image,
    "creationAt":creationAt,
    "updatedAt":updatedAt
  };
}