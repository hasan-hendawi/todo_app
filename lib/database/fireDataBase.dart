import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/database/models/task_model.dart';
import 'package:todo_app/database/models/user_model.dart';

class FireDataBase {
  static CollectionReference<UserModel> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(UserModel.userCollectionName)
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) =>
              UserModel.fromFireStore(snapshot.data()),
          toFirestore: (user, options) => user.toFireStore(),
        );
  }

  static Future<void> addUser(UserModel user) {
    var collection = getUserCollection();
    return collection.doc(user.id).set(user);
  }
  static Future<UserModel?> getUser(String userId) async{
    var collection = getUserCollection();
    var doc=await collection.doc(userId).get();
    var user=doc.data();
    return user ;
  }
  static CollectionReference<TaskModel> getTaskCollection(String userId) {
    return getUserCollection()
        .doc(userId)
        .collection(TaskModel.taskCollection)
        .withConverter<TaskModel>(
          fromFirestore: (snapshot, _) =>
              TaskModel.fromFireStore(snapshot.data()),
          toFirestore: (task, options) => task.toFireStore(),
        );
  }

  static Future<void> addTask(TaskModel task, String userId) {
    var newTask = getTaskCollection(userId).doc();
    task.id = newTask.id;
    return newTask.set(task);
  }

  static Future<QuerySnapshot<TaskModel>> getTask( String userId) {
  return getTaskCollection(userId).get();
  }
  static Stream<QuerySnapshot<TaskModel>> getRealTimeTask( String userId,int selectedDate) {
    return getTaskCollection(userId).where('taskDate',isEqualTo:selectedDate).snapshots();
  }

  static Future<void> deleteTask(String taskId, String userId) {
    return getTaskCollection(userId).doc(taskId).delete();

  }

  static updateTask(String taskId, String userId,bool isDone){
    getTaskCollection(userId).doc(taskId).update({'isDone': isDone});
  }
}
