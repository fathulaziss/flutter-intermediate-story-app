import 'package:json_annotation/json_annotation.dart';

part 'stories_model.g.dart';

@JsonSerializable()
class StoriesModel {
  StoriesModel({
    this.id,
    this.name,
    this.description,
    this.photoUrl,
    this.createdAt,
    this.lat,
    this.lon,
  });

  factory StoriesModel.fromJson(Map<String, dynamic> json) =>
      _$StoriesModelFromJson(json);

  String? id;
  String? name;
  String? description;
  String? photoUrl;
  String? createdAt;
  double? lat;
  double? lon;

  Map<String, dynamic> toJson() => _$StoriesModelToJson(this);

  @override
  String toString() {
    return 'StoriesModel(id: $id, name: $name, description: $description, photoUrl: $photoUrl, createdAt: $createdAt, lat: $lat, lon: $lon)';
  }
}
