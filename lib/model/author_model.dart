import 'dart:convert';

class AuthorModel {
  int? id;
  String? name;
  String? image;
  String? createdOn;
  String? updatedOn;
  AuthorModel({
    this.id,
    this.name,
    this.image,
    this.createdOn,
    this.updatedOn,
  });

  AuthorModel copyWith({
    int? id,
    String? name,
    String? image,
    String? createdOn,
    String? updatedOn,
  }) {
    return AuthorModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      createdOn: createdOn ?? this.createdOn,
      updatedOn: updatedOn ?? this.updatedOn,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (name != null) {
      result.addAll({'name': name});
    }
    if (image != null) {
      result.addAll({'image': image});
    }
    if (createdOn != null) {
      result.addAll({'createdOn': createdOn});
    }
    if (updatedOn != null) {
      result.addAll({'updatedOn': updatedOn});
    }

    return result;
  }

  factory AuthorModel.fromMap(Map<String, dynamic> map) {
    return AuthorModel(
      id: map['id']?.toInt(),
      name: map['name'],
      image: map['image'],
      createdOn: map['createdOn'],
      updatedOn: map['updatedOn'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthorModel.fromJson(String source) =>
      AuthorModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AuthorModel(id: $id, name: $name, image: $image, createdOn: $createdOn, updatedOn: $updatedOn)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthorModel &&
        other.id == id &&
        other.name == name &&
        other.image == image &&
        other.createdOn == createdOn &&
        other.updatedOn == updatedOn;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        image.hashCode ^
        createdOn.hashCode ^
        updatedOn.hashCode;
  }
}
