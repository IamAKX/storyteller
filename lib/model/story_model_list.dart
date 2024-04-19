import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'story_model.dart';

class StoryModelList {
  List<StoryModel>? data;
  StoryModelList({
    this.data,
  });

  StoryModelList copyWith({
    List<StoryModel>? data,
  }) {
    return StoryModelList(
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

  factory StoryModelList.fromMap(Map<String, dynamic> map) {
    return StoryModelList(
      data: map['data'] != null
          ? List<StoryModel>.from(
              map['data']?.map((x) => StoryModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory StoryModelList.fromJson(String source) =>
      StoryModelList.fromMap(json.decode(source));

  @override
  String toString() => 'StoryModelList(data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StoryModelList && listEquals(other.data, data);
  }

  @override
  int get hashCode => data.hashCode;
}
