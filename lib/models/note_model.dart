class NoteModel {
  final String title;
  final String content;

  const NoteModel({
    required this.title,
    required this.content,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
    };
  }

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    // final title = json['title'] as String;
    // final content = json['content'] as String;

    // final obj = NoteModel(
    //   title: title,
    //   content: content,
    // );

    // return obj;

    return NoteModel(
      title: json['title'] as String,
      content: json['content'] as String,
    );
  }

  NoteModel copyWith({
    String? title,
    String? content,
  }) {
    return NoteModel(
      title: title ?? this.title,
      content: content ?? this.content,
    );
  }

  @override
  int get hashCode => title.hashCode ^ content.hashCode;

  @override
  bool operator ==(Object other) => hashCode == other.hashCode;
}
