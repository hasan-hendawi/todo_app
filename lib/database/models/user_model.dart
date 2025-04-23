class UserModel{
  static const userCollectionName="users";
  String? id;
  String? name;
  String? email;
  UserModel({this.id,this.email,this.name});

  UserModel.fromFireStore( Map<String,dynamic>? data):this(email: data?['email'],id:data?['id'],name: data?['name'] );

  Map<String,dynamic> toFireStore(){
    return {
      'id': id,
      'name':name,
      'email':email,
    };

  }
}