import 'dart:convert';

class Task {
  int? id;
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  int? remind;
  String? repeat;

  Task({
    this.id,
    this.title,
    this.note,
    this.isCompleted,
    this.date,
    this.startTime,
    this.endTime,
    this.color,
    this.remind,
    this.repeat,
  });
  Task.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    note = json["note"];
    isCompleted = json["isCompleted"];
    date = json["date"];
    startTime = json["startTime"];
    endTime = json["endTime"];
    color = json["color"];
    remind = json["remind"];
    repeat = json["repeat"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = this.id;
    data["title"] = this.title;
    data["note"] = this.note;
    data["isCompleted"] = this.isCompleted;
    data["date"] = this.date;
    data["startTime"] = this.startTime;
    data["endTime"] = this.endTime;
    data["color"] = this.color;
    data["remind"] = this.remind;
    data["repeat"] = this.repeat;
    return data;
  }

  /* Task copyWith({
    int? id,
    String? title,
    String? note,
    int? isCompleted,
    String? date,
    String? startTime,
    String? endTime,
    int? color,
    int? remind,
    String? repeat,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      note: note ?? this.note,
      isCompleted: isCompleted ?? this.isCompleted,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      color: color ?? this.color,
      remind: remind ?? this.remind,
      repeat: repeat ?? this.repeat,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'note': note,
      'isCompleted': isCompleted,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'color': color,
      'remind': remind,
      'repeat': repeat,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] ?? 1,
      title: map['title'] ?? "null",
      note: map['note'] ?? "null",
      isCompleted: map['isCompleted'] ?? "null",
      date: map['date'] ?? "null",
      startTime: map['startTime'] ?? "null",
      endTime: map['endTime'] ?? "null",
      color: map['color'] ?? 0xFF4e5ae8,
      remind: map['remind'] ?? 5,
      repeat: map['repeat'] ?? "null",
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source)); */

  @override
  String toString() {
    return 'Task(id: $id, title: $title, note: $note, isCompleted: $isCompleted, date: $date, startTime: $startTime, endTime: $endTime, color: $color, remind: $remind, repeat: $repeat)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Task &&
        other.id == id &&
        other.title == title &&
        other.note == note &&
        other.isCompleted == isCompleted &&
        other.date == date &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.color == color &&
        other.remind == remind &&
        other.repeat == repeat;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        note.hashCode ^
        isCompleted.hashCode ^
        date.hashCode ^
        startTime.hashCode ^
        endTime.hashCode ^
        color.hashCode ^
        remind.hashCode ^
        repeat.hashCode;
  }
}
