import 'dart:convert';

class SubscriptionModel {
  int? id;
  int? amount;
  int? duration;
  String? title;
  String? description;
  String? logo;
  String? otherInfo;
  SubscriptionModel({
    this.id,
    this.amount,
    this.duration,
    this.title,
    this.description,
    this.logo,
    this.otherInfo,
  });

  SubscriptionModel copyWith({
    int? id,
    int? amount,
    int? duration,
    String? title,
    String? description,
    String? logo,
    String? otherInfo,
  }) {
    return SubscriptionModel(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      duration: duration ?? this.duration,
      title: title ?? this.title,
      description: description ?? this.description,
      logo: logo ?? this.logo,
      otherInfo: otherInfo ?? this.otherInfo,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(id != null){
      result.addAll({'id': id});
    }
    if(amount != null){
      result.addAll({'amount': amount});
    }
    if(duration != null){
      result.addAll({'duration': duration});
    }
    if(title != null){
      result.addAll({'title': title});
    }
    if(description != null){
      result.addAll({'description': description});
    }
    if(logo != null){
      result.addAll({'logo': logo});
    }
    if(otherInfo != null){
      result.addAll({'otherInfo': otherInfo});
    }
  
    return result;
  }

  factory SubscriptionModel.fromMap(Map<String, dynamic> map) {
    return SubscriptionModel(
      id: map['id']?.toInt(),
      amount: map['amount']?.toInt(),
      duration: map['duration']?.toInt(),
      title: map['title'],
      description: map['description'],
      logo: map['logo'],
      otherInfo: map['otherInfo'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SubscriptionModel.fromJson(String source) => SubscriptionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SubscriptionModel(id: $id, amount: $amount, duration: $duration, title: $title, description: $description, logo: $logo, otherInfo: $otherInfo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SubscriptionModel &&
      other.id == id &&
      other.amount == amount &&
      other.duration == duration &&
      other.title == title &&
      other.description == description &&
      other.logo == logo &&
      other.otherInfo == otherInfo;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      amount.hashCode ^
      duration.hashCode ^
      title.hashCode ^
      description.hashCode ^
      logo.hashCode ^
      otherInfo.hashCode;
  }
}
