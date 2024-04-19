import 'dart:convert';

import 'story_model.dart';

class StoryChatModel {
  int? id;
  StoryModel? story;
  int? serialNumber;
  String? text;
  String? mediaUrl;
  String? messageType;
  String? reactionType;
  bool? reactionEnabled;
  String? sender;
  String? chatTimestamp;
  StoryChatModel({
    this.id,
    this.story,
    this.serialNumber,
    this.text,
    this.mediaUrl,
    this.messageType,
    this.reactionType,
    this.reactionEnabled,
    this.sender,
    this.chatTimestamp,
  });

  StoryChatModel copyWith({
    int? id,
    StoryModel? story,
    int? serialNumber,
    String? text,
    String? mediaUrl,
    String? messageType,
    String? reactionType,
    bool? reactionEnabled,
    String? sender,
    String? chatTimestamp,
  }) {
    return StoryChatModel(
      id: id ?? this.id,
      story: story ?? this.story,
      serialNumber: serialNumber ?? this.serialNumber,
      text: text ?? this.text,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      messageType: messageType ?? this.messageType,
      reactionType: reactionType ?? this.reactionType,
      reactionEnabled: reactionEnabled ?? this.reactionEnabled,
      sender: sender ?? this.sender,
      chatTimestamp: chatTimestamp ?? this.chatTimestamp,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (story != null) {
      result.addAll({'story': story!.toMap()});
    }
    if (serialNumber != null) {
      result.addAll({'serialNumber': serialNumber});
    }
    if (text != null) {
      result.addAll({'text': text});
    }
    if (mediaUrl != null) {
      result.addAll({'mediaUrl': mediaUrl});
    }
    if (messageType != null) {
      result.addAll({'messageType': messageType});
    }
    if (reactionType != null) {
      result.addAll({'reactionType': reactionType});
    }
    if (reactionEnabled != null) {
      result.addAll({'reactionEnabled': reactionEnabled});
    }
    if (sender != null) {
      result.addAll({'sender': sender});
    }
    if (chatTimestamp != null) {
      result.addAll({'chatTimestamp': chatTimestamp});
    }

    return result;
  }

  factory StoryChatModel.fromMap(Map<String, dynamic> map) {
    return StoryChatModel(
      id: map['id']?.toInt(),
      story: map['story'] != null ? StoryModel.fromMap(map['story']) : null,
      serialNumber: map['serialNumber']?.toInt(),
      text: map['text'],
      mediaUrl: map['mediaUrl'],
      messageType: map['messageType'],
      reactionType: map['reactionType'],
      reactionEnabled: map['reactionEnabled'],
      sender: map['sender'],
      chatTimestamp: map['chatTimestamp'],
    );
  }

  String toJson() => json.encode(toMap());

  factory StoryChatModel.fromJson(String source) =>
      StoryChatModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StoryChatModel(id: $id, story: $story, serialNumber: $serialNumber, text: $text, mediaUrl: $mediaUrl, messageType: $messageType, reactionType: $reactionType, reactionEnabled: $reactionEnabled, sender: $sender, chatTimestamp: $chatTimestamp)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StoryChatModel &&
        other.id == id &&
        other.story == story &&
        other.serialNumber == serialNumber &&
        other.text == text &&
        other.mediaUrl == mediaUrl &&
        other.messageType == messageType &&
        other.reactionType == reactionType &&
        other.reactionEnabled == reactionEnabled &&
        other.sender == sender &&
        other.chatTimestamp == chatTimestamp;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        story.hashCode ^
        serialNumber.hashCode ^
        text.hashCode ^
        mediaUrl.hashCode ^
        messageType.hashCode ^
        reactionType.hashCode ^
        reactionEnabled.hashCode ^
        sender.hashCode ^
        chatTimestamp.hashCode;
  }
}
