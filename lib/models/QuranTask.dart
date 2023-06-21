class Task {
  final int? id;
  final String? date;
  final String? title;
  final bool? completed;

  Task({this.id, this.date, this.title, this.completed});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'title': title,
      'completed': completed! ? 1 : 0,
    };
  }

  static Task fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      date: map['date'],
      title: map['title'],
      completed: map['completed'] == 1,
    );
  }
}
