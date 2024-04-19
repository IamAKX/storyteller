import 'dart:convert';

import 'package:story_teller/model/subscription_model.dart';

class UserModel {
  int? id;
  String? name;
  String? mobile;
  String? email;
  String? image;
  String? status;
  String? subscribedOn;
  String? subscriptionEndsOn;
  String? subscribtionStatus;
  SubscriptionModel? subscription;
  String? bio;
  String? firebaseAuthId;
  String? createdOn;
  String? updatedOn;
  UserModel({
    this.id,
    this.name,
    this.mobile,
    this.email,
    this.image,
    this.status,
    this.subscribedOn,
    this.subscriptionEndsOn,
    this.subscribtionStatus,
    this.subscription,
    this.bio,
    this.firebaseAuthId,
    this.createdOn,
    this.updatedOn,
  });

  UserModel copyWith({
    int? id,
    String? name,
    String? mobile,
    String? email,
    String? image,
    String? status,
    String? subscribedOn,
    String? subscriptionEndsOn,
    String? subscribtionStatus,
    SubscriptionModel? subscription,
    String? bio,
    String? firebaseAuthId,
    String? createdOn,
    String? updatedOn,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      mobile: mobile ?? this.mobile,
      email: email ?? this.email,
      image: image ?? this.image,
      status: status ?? this.status,
      subscribedOn: subscribedOn ?? this.subscribedOn,
      subscriptionEndsOn: subscriptionEndsOn ?? this.subscriptionEndsOn,
      subscribtionStatus: subscribtionStatus ?? this.subscribtionStatus,
      subscription: subscription ?? this.subscription,
      bio: bio ?? this.bio,
      firebaseAuthId: firebaseAuthId ?? this.firebaseAuthId,
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
    if (mobile != null) {
      result.addAll({'mobile': mobile});
    }
    if (email != null) {
      result.addAll({'email': email});
    }
    if (image != null) {
      result.addAll({'image': image});
    }
    if (status != null) {
      result.addAll({'status': status});
    }
    if (subscribedOn != null) {
      result.addAll({'subscribedOn': subscribedOn});
    }
    if (subscriptionEndsOn != null) {
      result.addAll({'subscriptionEndsOn': subscriptionEndsOn});
    }
    if (subscribtionStatus != null) {
      result.addAll({'subscribtionStatus': subscribtionStatus});
    }
    if (subscription != null) {
      result.addAll({'subscription': subscription!.toMap()});
    }
    if (bio != null) {
      result.addAll({'bio': bio});
    }
    if (firebaseAuthId != null) {
      result.addAll({'firebaseAuthId': firebaseAuthId});
    }
    if (createdOn != null) {
      result.addAll({'createdOn': createdOn});
    }
    if (updatedOn != null) {
      result.addAll({'updatedOn': updatedOn});
    }

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id']?.toInt(),
      name: map['name'],
      mobile: map['mobile'],
      email: map['email'],
      image: map['image'],
      status: map['status'],
      subscribedOn: map['subscribedOn'],
      subscriptionEndsOn: map['subscriptionEndsOn'],
      subscribtionStatus: map['subscribtionStatus'],
      subscription: map['subscription'] != null
          ? SubscriptionModel.fromMap(map['subscription'])
          : null,
      bio: map['bio'],
      firebaseAuthId: map['firebaseAuthId'],
      createdOn: map['createdOn'],
      updatedOn: map['updatedOn'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, mobile: $mobile, email: $email, image: $image, status: $status, subscribedOn: $subscribedOn, subscriptionEndsOn: $subscriptionEndsOn, subscribtionStatus: $subscribtionStatus, subscription: $subscription, bio: $bio, firebaseAuthId: $firebaseAuthId, createdOn: $createdOn, updatedOn: $updatedOn)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.name == name &&
        other.mobile == mobile &&
        other.email == email &&
        other.image == image &&
        other.status == status &&
        other.subscribedOn == subscribedOn &&
        other.subscriptionEndsOn == subscriptionEndsOn &&
        other.subscribtionStatus == subscribtionStatus &&
        other.subscription == subscription &&
        other.bio == bio &&
        other.firebaseAuthId == firebaseAuthId &&
        other.createdOn == createdOn &&
        other.updatedOn == updatedOn;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        mobile.hashCode ^
        email.hashCode ^
        image.hashCode ^
        status.hashCode ^
        subscribedOn.hashCode ^
        subscriptionEndsOn.hashCode ^
        subscribtionStatus.hashCode ^
        subscription.hashCode ^
        bio.hashCode ^
        firebaseAuthId.hashCode ^
        createdOn.hashCode ^
        updatedOn.hashCode;
  }
}
