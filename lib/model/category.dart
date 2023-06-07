class Category {
  String? name;
  String? imgPath;

  Category({this.name, this.imgPath});

  Map<String, dynamic> tojson(String? name, String? imgPath) {
    return {
      'name': name,
      'imgPath': imgPath,
    };
  }

  static Category fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'] as String?,
      imgPath: json['imgPath'] as String?,
    );
  }
}
