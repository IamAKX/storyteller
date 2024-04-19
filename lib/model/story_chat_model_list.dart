import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'story_chat_model.dart';

class StoryChatModelList {
  List<StoryChatModel>? data;
  StoryChatModelList({
    this.data,
  });

  StoryChatModelList copyWith({
    List<StoryChatModel>? data,
  }) {
    return StoryChatModelList(
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

  factory StoryChatModelList.fromMap(Map<String, dynamic> map) {
    return StoryChatModelList(
      data: map['data'] != null
          ? List<StoryChatModel>.from(
              map['data']?.map((x) => StoryChatModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory StoryChatModelList.fromJson(String source) =>
      StoryChatModelList.fromMap(json.decode(source));

  @override
  String toString() => 'StoryChatModelList(data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StoryChatModelList && listEquals(other.data, data);
  }

  @override
  int get hashCode => data.hashCode;
}
