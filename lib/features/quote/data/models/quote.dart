import 'package:hive/hive.dart';

part 'quote.g.dart';

@HiveType(typeId: 0)
class Quote {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String text;
  @HiveField(2)
  final String author;
  @HiveField(3)
  bool isLiked;

  Quote({
    required this.id,
    required this.text,
    required this.author,
    this.isLiked = false,
  });

  Quote copyWith({bool? isLiked}) => Quote(
        id: id,
        text: text,
        author: author,
        isLiked: isLiked ?? this.isLiked,
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'author': author,
      'isLiked': isLiked,
    };
  }

  factory Quote.fromMap(Map<String, dynamic> map) {
    return Quote(
      id: map['id'],
      text: map['text'],
      author: map['author'],
      isLiked: map['isLiked'] ?? false,
    );
  }
}
