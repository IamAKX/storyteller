import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'category_model.dart';

class CategoryModelList {
  List<CategoryModel>? data;
  CategoryModelList({
    this.data,
  });

  CategoryModelList copyWith({
    List<CategoryModel>? data,
  }) {
    return CategoryModelList(
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (data != null) {
      result.addAll({'data': data!.map((x) => x.toMap()).toList()});
    }

    return result;
  }

  factory CategoryModelList.fromMap(Map<String, dynamic> map) {
    return CategoryModelList(
      data: map['data'] != null
          ? List<CategoryModel>.from(
              map['data']?.map((x) => CategoryModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModelList.fromJson(String source) =>
      CategoryModelList.fromMap(json.decode(source));

  @override
  String toString() => 'CategoryModelList(data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CategoryModelList && listEquals(other.data, data);
  }

  @override
  int get hashCode => data.hashCode;
}
