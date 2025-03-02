class UserModel {
  final String? email;
  final String? pass;
  final String? uid;

  UserModel({this.email, this.pass, this.uid});
  // Optionally, create a factory to initialize from a map if needed later
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'],
      pass: map['pass'],
      uid: map['uid'],
    );
  }

  // Convert UserModel to a map
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'pass': pass,
      'uid': uid,
    };
  }
}
