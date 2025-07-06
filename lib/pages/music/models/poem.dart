class Poem {
  final String content;
  final String author;
  final String dynasty;

  Poem({required this.content, required this.author, required this.dynasty});

  factory Poem.fromJson(Map<String, dynamic> json) {
    return Poem(
      content: json['content'],
      author: json['author'],
      dynasty: json['dynasty'],
    );
  }
}
