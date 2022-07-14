import 'dart:convert';

List<BrandsModel> brandsModelFromJson(String str) => List<BrandsModel>.from(
    json.decode(str).map((x) => BrandsModel.fromJson(x)));

String brandsModelToJson(List<BrandsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BrandsModel {
  BrandsModel({
    this.brandId,
    this.brandName,
    this.createdAt,
    this.updatedAt,
    this.brandImg,
    this.translations,
  });

  int brandId;
  String brandName;
  DateTime createdAt;
  DateTime updatedAt;
  String brandImg;
  List<dynamic> translations;

  factory BrandsModel.fromJson(Map<String, dynamic> json) => BrandsModel(
        brandId: json["brand_id"],
        brandName: json["brand_name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        brandImg: json["brand_img"],
        translations: List<dynamic>.from(json["translations"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "brand_id": brandId,
        "brand_name": brandName,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "brand_img": brandImg,
        "translations": List<dynamic>.from(translations.map((x) => x)),
      };
}
