class UserData {
  String name;
  int id;
  String mobileNo;

  UserData({
    required this.name,
    required this.id,
    required this.mobileNo,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(name: json["name"], id: json["id"], mobileNo: json["mobileNo"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "id": id,
      "mobileNo": mobileNo,
    };
  }
}














//
//
// import 'dart:convert';
//
// List<Model> categoriesFromMap(String str) =>
//     List<Model>.from(json.decode(str).map((x) => Model.fromMap(x)));
//
// String categoriesToMap(List<Model> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
//
// class Model {
//   Model({
//     this.id,
//     this.product,
//   });
//
//   final int? id;
//   final List<Product>? product;
//
//   factory Model.fromMap(Map<String, dynamic> json) => Model(
//     id: json["id"],
//     product: List<Product>.from(json["product"].map((x) => Product.fromMap(x))),
//   );
//
//   Map<String, dynamic> toMap() => {
//     "id": id,
//     "product": List<dynamic>.from(product!.map((x) => x.toMap())),
//   };
// }
//
// class Product {
//   Product({
//     this.id,
//     this.contacts,
//   });
//
//   int? id;
//  String? contacts;
//
//
//   factory Product.fromMap(Map<String, dynamic> json) => Product(
//     id: json["id"],
//     contacts: json["contacts"],
//   );
//
//   Map<String, dynamic> toMap() => {
//     "id": id,
//     "contacts": contacts,
//   };
// }
