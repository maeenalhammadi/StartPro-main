// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BusinessModel {
  final String title;
  final String typeLabel;
  final String content;
  final String? imageUrl;
  final String? description;

  BusinessModel({
    required this.title,
    required this.typeLabel,
    required this.content,
    this.imageUrl,
    this.description,
  });

  BusinessModel copyWith({
    String? title,
    String? type,
    String? content,
    String? imageUrl,
    String? description,
  }) {
    return BusinessModel(
      title: title ?? this.title,
      typeLabel: type ?? this.typeLabel,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'type': typeLabel,
      'content': content,
      'imageUrl': imageUrl,
      'description': description,
    };
  }

  factory BusinessModel.fromMap(Map<String, dynamic> map) {
    return BusinessModel(
      title: map['title'] as String,
      typeLabel: map['type'] as String,
      content: map['content'] as String,
      imageUrl: map['imageUrl'] as String?,
      description: map['description'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory BusinessModel.fromJson(Map<String, dynamic> json) {
    try {
      final attributes = json['attributes'] ?? json;
      return BusinessModel(
        title: attributes['title'] as String,
        typeLabel: attributes['model']['label'] as String,
        content: attributes['content'] as String,
        imageUrl: attributes['image']?['url']?['url'] as String?,
        description: attributes['description'] as String?,
      );
    } catch (e, stack) {
      print('Error parsing BusinessModel: $e');
      print('Stack trace: $stack');
      print('JSON data: $json');
      rethrow;
    }
  }

  @override
  String toString() {
    return 'BusinessModel(title: $title, type: $typeLabel, content: $content, imageUrl: $imageUrl, description: $description)';
  }

  @override
  bool operator ==(covariant BusinessModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.typeLabel == typeLabel &&
        other.content == content &&
        other.imageUrl == imageUrl &&
        other.description == description;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        typeLabel.hashCode ^
        content.hashCode ^
        imageUrl.hashCode ^
        description.hashCode;
  }

  static BusinessModel empty() {
    return BusinessModel(title: '', typeLabel: '', content: '');
  }

  static BusinessModel skeleton() {
    return BusinessModel(
      title: '   ',
      typeLabel: '     ',
      content: '        ',
      description: '                    ',
    );
  }
}
