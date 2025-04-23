class TaskModel {
  static const String taskCollection = 'task';
  String? id;
  String? title;
  String? desc;
  DateTime? taskDate;
  bool isDone;

  TaskModel({
    this.id,
    this.desc,
    this.title,
    this.isDone = false,
    this.taskDate,
  });

  TaskModel.fromFireStore(Map<String, dynamic>? data)
      : this(
            id: data?['id'],
            title: data?['title'],
            desc: data?['desc'],
            isDone: data?['isDone'],
            taskDate: DateTime.fromMillisecondsSinceEpoch(data?['taskDate']));

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'title': title,
      'desc': desc,
      'isDone': isDone,
      'taskDate': taskDate?.millisecondsSinceEpoch,
    };
  }
}
