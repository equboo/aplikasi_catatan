class Note {
  final int? id;
  final String title;
  final String content;
  final String color;
  final String dateTime;

  Note({
    this.id,
    required this.title,
    required this.content,
    required this.color,
    required this.dateTime,
  }) {
    if (title.isEmpty) {
      throw ArgumentError('Title cannot be empty');
    }
    if (content.isEmpty) {
      throw ArgumentError('Content cannot be empty');
    }
    if (color.isEmpty) {
      throw ArgumentError('Color cannot be empty');
    }
    if (dateTime.isEmpty) {
      throw ArgumentError('DateTime cannot be empty');
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'color': color,
      'dateTime': dateTime,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] as int?,
      title: map['title'] as String,
      content: map['content'] as String,
      color: map['color'] as String,
      dateTime: map['dateTime'] as String,
    );
  }

  @override
  String toString() {
    return 'Note{id: $id, title: $title, content: $content, color: $color, dateTime: $dateTime}';
  }
}
