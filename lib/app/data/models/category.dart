import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String title;
  final int icon;
  final String color;
  final List<dynamic>? words;

  const Category({
    required this.title,
    required this.icon,
    required this.color,
    this.words,
  });

  // yukardaki constant olduğundan copyWith kullanılıyor
  Category copyWith({
    String? title,
    int? icon,
    String? color,
    List<dynamic>? words,
  }) =>
      Category(
        title: title ?? this.title,
        icon: icon ?? this.icon,
        color: color ?? this.color,
        words: words ?? this.words,
      );

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        title: json["title"],
        icon: json["icon"],
        color: json["color"],
        words: json["words"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "icon": icon,
        "color": color,
        "words": words,
      };

  // equatible paketinden geliyor obje karşılaştırıken kullanılacak
  @override
  List<Object?> get props => [
        title,
        icon,
        color,
      ];
}
