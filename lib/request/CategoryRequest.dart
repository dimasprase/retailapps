class CategoryRequest{
  List<Kategori> category;

  CategoryRequest({this.category});

  factory CategoryRequest.fromJson(Map<String, dynamic> parsedJson){

    var list = parsedJson['data'] as List;
    List<Kategori> category = list.map((i) => Kategori.fromJson(i)).toList();

    return CategoryRequest(
        category: category,

    );
  }
}

class Kategori{
  final String id;
  final String type;
  final String status;
  final String name;
  final String slug;
  final String description;

  Kategori({
    this.id,
    this.type,
    this.status,
    this.name,
    this.slug,
    this.description,
  }) ;

  factory Kategori.fromJson(Map<String, dynamic> json){

    return new Kategori(
      id: json['id'],
      type: json['type'],
      status: json['status'],
      name: json['name'],
      slug: json['slug'],
      description: json['description']
    );
  }

}