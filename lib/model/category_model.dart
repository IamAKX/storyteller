import 'dart:convert';

class CategoryModel {
  int? id;
  String? name;
  String? description;
  String? icon;
  String? createdOn;
  String? updatedOn;
  CategoryModel({
    this.id,
    this.name,
    this.description,
    this.icon,
    this.createdOn,
    this.updatedOn,
  });

  CategoryModel copyWith({
    int? id,
    String? name,
    String? description,
    String? icon,
    String? createdOn,
    String? updatedOn,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
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
    if (description != null) {
      result.addAll({'description': description});
    }
    if (icon != null) {
      result.addAll({'icon': icon});
    }
    if (createdOn != null) {
      result.addAll({'createdOn': createdOn});
    }
    if (updatedOn != null) {
      result.addAll({'updatedOn': updatedOn});
    }

    return result;
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id']?.toInt(),
      name: map['name'],
      description: map['description'],
      icon: map['icon'],
      createdOn: map['createdOn'],
      updatedOn: map['updatedOn'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CategoryModel(id: $id, name: $name, description: $description, icon: $icon, createdOn: $createdOn, updatedOn: $updatedOn)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CategoryModel &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.icon == icon &&
        other.createdOn == createdOn &&
        other.updatedOn == updatedOn;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        icon.hashCode ^
        createdOn.hashCode ^
        updatedOn.hashCode;
  }
}
