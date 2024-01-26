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

  factory StoriesModel.fromMap(Map<String, dynamic> map) {
    return StoriesModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      photoUrl: map['photoUrl'],
      createdAt: map['createdAt'],
      lat: map['lat'],
      lon: map['lon'],
    );
  }

  String? id;
  String? name;
  String? description;
  String? photoUrl;
  String? createdAt;
  double? lat;
  double? lon;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'photoUrl': photoUrl,
      'createdAt': createdAt,
      'lat': lat,
      'lon': lon,
    };
  }

  @override
  String toString() {
    return 'StoriesModel(id: $id, name: $name, description: $description, photoUrl: $photoUrl, createdAt: $createdAt, lat: $lat, lon: $lon)';
  }
}
