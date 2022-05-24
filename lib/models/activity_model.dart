final String tableActivites = 'activities';

class ActivityFields {
  static final List<String> values = [id, workoutId, name, time];

  static final String id = '_id';
  static final String workoutId = 'workoutId';
  static final String name = 'name';
  static final String time = 'time';
}

class Activity {
  final int? id;
  final int workoutId;
  final String name;
  final int time;

  Activity({
    this.id,
    required this.workoutId,
    required this.name,
    required this.time,
  });

  static Activity fromJSON(json) {
    return Activity(
      id: json[ActivityFields.id] as int?,
      workoutId: json[ActivityFields.workoutId] as int,
      name: json[ActivityFields.name] as String,
      time: json[ActivityFields.time] as int,
    );
  }

  Map<String, Object?> toJSON() {
    return {
      ActivityFields.id: id,
      ActivityFields.workoutId: workoutId,
      ActivityFields.name: name,
      ActivityFields.time: time,
    };
  }

  Activity copy(
    int? id,
    int? workoutId,
    String? name,
    int? time,
  ) =>
      Activity(
        id: id ?? this.id,
        workoutId: workoutId ?? this.workoutId,
        name: name ?? this.name,
        time: time ?? this.time,
      );
}
