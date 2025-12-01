// note.dart
class Note {
  String title;
  bool isDone;

  Note({
    required this.title,
    this.isDone = false,
  });

  // Convert Note object to Map for SharedPreferences
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isDone': isDone,
    };
  }

  // Create Note object from Map
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      title: map['title'] ?? '',
      isDone: map['isDone'] ?? false,
    );
  }
}
