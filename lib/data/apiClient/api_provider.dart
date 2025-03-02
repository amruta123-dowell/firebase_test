import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/data/apiClient/api_result.dart';

import '../../core/utils/progress_dialog_utils.dart';

class ApiProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<ApiResult<UserCredential>> signup(
      {required String email, required String password}) async {
    try {
      ProgressDialogUtils.showProgressDialog();

      UserCredential response = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseFirestore.instance.databaseId;
      response.user;
      String? token = await response.user?.getIdToken();

      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(error.toString());
    } finally {
      ProgressDialogUtils.hideProgressDialog();
    }
  }

  Future<ApiResult<UserCredential>> signIn(
      {required String email, required String password}) async {
    try {
      ProgressDialogUtils.showProgressDialog();
      UserCredential response = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      response.user;
      String? token = await response.user?.getIdToken();

      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(error.toString());
    } finally {
      ProgressDialogUtils.hideProgressDialog();
    }
  }

  /// Adding the task to the firestore respective user
  /// (This method adds a task inside users/{uid}/tasks/{taskId}.)
  ///
  Future<ApiResult<String>> addTask({
    required String taskName,
    required String description,
    required String date,
  }) async {
    try {
      ProgressDialogUtils.showProgressDialog();

      User? user = _auth.currentUser;
      if (user == null) {
        return ApiResult.failure("User not logged in");
      }

      DocumentReference documentReference = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .collection("tasks")
          .add({
        "task": taskName,
        "description": description,
        "date": date,
        "createdAt": FieldValue.serverTimestamp(),
      });

      return ApiResult.success(
          documentReference.id); // Return generated task ID
    } catch (error) {
      return ApiResult.failure(error.toString());
    } finally {
      ProgressDialogUtils.hideProgressDialog();
    }
  }

  /// fetching the tasks of user

  Future<ApiResult<List<Map<String, dynamic>>>> getTasks() async {
    try {
      ProgressDialogUtils.showProgressDialog();

      User? user = _auth.currentUser;
      if (user == null) {
        return ApiResult.failure("User not logged in");
      }

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .collection("tasks")
          .orderBy("createdAt", descending: true)
          .get();

      List<Map<String, dynamic>> tasks = querySnapshot.docs.map((doc) {
        return {"id": doc.id, ...doc.data() as Map<String, dynamic>};
      }).toList();

      return ApiResult.success(tasks);
    } catch (error) {
      return ApiResult.failure(error.toString());
    } finally {
      ProgressDialogUtils.hideProgressDialog();
    }
  }

  /// Editing the task of user
  /// (This method updates the task inside users/{uid}/tasks/{taskId}.)
  Future<ApiResult<void>> updateTask({
    required String taskId,
    required String taskName,
    required String description,
    required String date,
  }) async {
    try {
      ProgressDialogUtils.showProgressDialog();

      User? user = _auth.currentUser;
      if (user == null) {
        return ApiResult.failure("User not logged in");
      }

      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .collection("tasks")
          .doc(taskId)
          .update({
        "task": taskName,
        "description": description,
        "date": date,
      });

      return ApiResult.success(null);
    } catch (error) {
      return ApiResult.failure(error.toString());
    } finally {
      ProgressDialogUtils.hideProgressDialog();
    }
  }

  ///Deleting the task of user
  Future<ApiResult<void>> deleteTask({required String taskId}) async {
    try {
      ProgressDialogUtils.showProgressDialog();

      User? user = _auth.currentUser;
      if (user == null) {
        return ApiResult.failure("User not logged in");
      }

      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .collection("tasks")
          .doc(taskId)
          .delete();

      return ApiResult.success(null);
    } catch (error) {
      return ApiResult.failure(error.toString());
    } finally {
      ProgressDialogUtils.hideProgressDialog();
    }
  }
}
