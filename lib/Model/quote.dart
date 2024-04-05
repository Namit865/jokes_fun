class Quote {
  final int id;
  final String content;
  final String author;
  final bool isFavorite;

  Quote({required this.id, required this.content, required this.author, required this.isFavorite});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'author': author,
      'isFavorite': isFavorite ? 1 : 0,
    };
  }
}
