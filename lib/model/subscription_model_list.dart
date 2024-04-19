import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'subscription_model.dart';

class SubscriptionModelList {
  List<SubscriptionModel>? data;
  SubscriptionModelList({
    this.data,
  });

  SubscriptionModelList copyWith({
    List<SubscriptionModel>? data,
  }) {
    return SubscriptionModelList(
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

  factory SubscriptionModelList.fromMap(Map<String, dynamic> map) {
    return SubscriptionModelList(
      data: map['data'] != null
          ? List<SubscriptionModel>.from(
              map['data']?.map((x) => SubscriptionModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubscriptionModelList.fromJson(String source) =>
      SubscriptionModelList.fromMap(json.decode(source));

  @override
  String toString() => 'SubscriptionModelList(data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SubscriptionModelList && listEquals(other.data, data);
  }

  @override
  int get hashCode => data.hashCode;
}
