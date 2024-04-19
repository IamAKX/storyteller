import 'dart:convert';

import 'author_model.dart';
import 'category_model.dart';

class StoryModel {
  int? id;
  CategoryModel? category;
  AuthorModel? author;
  String? name;
  String? image;
  String? tags;
  String? userMe;
  String? userOther;
  StoryModel({
    this.id,
    this.category,
    this.author,
    this.name,
    this.image,
    this.tags,
    this.userMe,
    this.userOther,
  });

  StoryModel copyWith({
    int? id,
    CategoryModel? category,
    AuthorModel? author,
    String? name,
    String? image,
    String? tags,
    String? userMe,
    String? userOther,
  }) {
    return StoryModel(
      id: id ?? this.id,
      category: category ?? this.category,
      author: author ?? this.author,
      name: name ?? this.name,
      image: image ?? this.image,
      tags: tags ?? this.tags,
      userMe: userMe ?? this.userMe,
      userOther: userOther ?? this.userOther,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (category != null) {
      result.addAll({'category': category!.toMap()});
    }
    if (author != null) {
      result.addAll({'author': author!.toMap()});
    }
    if (name != null) {
      result.addAll({'name': name});
    }
    if (image != null) {
      result.addAll({'image': image});
    }
    if (tags != null) {
      result.addAll({'tags': tags});
    }
    if (userMe != null) {
      result.addAll({'userMe': userMe});
    }
    if (userOther != null) {
      result.addAll({'userOther': userOther});
    }

    return result;
  }

  factory StoryModel.fromMap(Map<String, dynamic> map) {
    return StoryModel(
      id: map['id']?.toInt(),
      category: map['category'] != null
          ? CategoryModel.fromMap(map['category'])
          : null,
      author: map['author'] != null ? AuthorModel.fromMap(map['author']) : null,
      name: map['name'],
      image: map['image'],
      tags: map['tags'],
      userMe: map['userMe'],
      userOther: map['userOther'],
    );
  }

  String toJson() => json.encode(toMap());

  factory StoryModel.fromJson(String source) =>
      StoryModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StoryModel(id: $id, category: $category, author: $author, name: $name, image: $image, tags: $tags, userMe: $userMe, userOther: $userOther)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StoryModel &&
        other.id == id &&
        other.category == category &&
        other.author == author &&
        other.name == name &&
        other.image == image &&
        other.tags == tags &&
        other.userMe == userMe &&
        other.userOther == userOther;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        category.hashCode ^
        author.hashCode ^
        name.hashCode ^
        image.hashCode ^
        tags.hashCode ^
        userMe.hashCode ^
        userOther.hashCode;
  }
}
