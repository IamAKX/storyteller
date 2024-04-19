
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'author_model.dart';

class AuthorModelList {
  List<AuthorModel>? data;
  AuthorModelList({
    this.data,
  });

  AuthorModelList copyWith({
    List<AuthorModel>? data,
  }) {
    return AuthorModelList(
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(data != null){
      result.addAll({'data': data!.map((x) => x.toMap()).toList()});
    }
  
    return result;
  }

  factory AuthorModelList.fromMap(Map<String, dynamic> map) {
    return AuthorModelList(
      data: map['data'] != null ? List<AuthorModel>.from(map['data']?.map((x) => AuthorModel.fromMap(x))) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthorModelList.fromJson(String source) => AuthorModelList.fromMap(json.decode(source));

  @override
  String toString() => 'AuthorModelList(data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AuthorModelList &&
      listEquals(other.data, data);
  }

  @override
  int get hashCode => data.hashCode;
}
