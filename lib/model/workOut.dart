class Workout {
  int id;
  String type;
  int minute;
  int cal;

  Workout ({
    this.id,
    this.type,
    this.minute,
    this.cal
  });

  Workout.setValue(int id, String type, int minute, int cal){
    this.id = id;
    this.type = type;
    this.minute = minute;
    this.cal = cal;
  }


  factory Workout.fromJson(Map<String, dynamic> parsedJson){
    return Workout(
      id : parsedJson['id'],
      type : parsedJson['type'],
      minute : parsedJson ['minutes'],
      cal : parsedJson['cal']
    );
  }

  void setValue(int id, String type, int minute, int cal){
    this.id = id;
    this.type = type;
    this.minute = minute;
    this.cal = cal;
  }
}