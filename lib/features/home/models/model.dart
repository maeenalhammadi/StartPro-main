// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Model {
  final String label;
  final String slug;

  Model({
    required this.label,
    required this.slug,
  });

  Model copyWith({
    String? label,
    String? slug,
  }) {
    return Model(
      label: label ?? this.label,
      slug: slug ?? this.slug,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'label': label,
      'slug': slug,
    };
  }

  factory Model.fromMap(Map<String, dynamic> map) {
    return Model(
      label: map['label'] as String,
      slug: map['slug'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Model.fromJson(String source) => Model.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Model(label: $label, slug: $slug)';

  @override
  bool operator ==(covariant Model other) {
    if (identical(this, other)) return true;
  
    return 
      other.label == label &&
      other.slug == slug;
  }

  @override
  int get hashCode => label.hashCode ^ slug.hashCode;
}
