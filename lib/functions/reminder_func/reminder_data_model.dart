import 'package:aio_mobile/extensions/string_ext.dart';

class ReminderData {
  final String title;
  final String description;
  final DateTime date;
  final Duration time;
  final Duration repeatTime;
  final int repeatInterval;
  final String id;
  final int index;
  final DateTime createdAt;

  ReminderData({
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.repeatTime,
    required this.repeatInterval,
    required this.id,
    required this.index,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.toString(),
      'time': time.toString(),
      'repeatTime': repeatTime.toString(),
      'repeatInterval': repeatInterval,
      'index': index,
      'createdAt': createdAt.toString(),
    };
  }

  factory ReminderData.fromJson(Map<dynamic, dynamic> json) {
    return ReminderData(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      time: json['time'].toString().toDurationHHmmss(),
      repeatTime: json['repeatTime'].toString().toDurationHHmmss(),
      repeatInterval: json['repeatInterval'],
      index: json['index'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
