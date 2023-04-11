
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final user = FirebaseAuth.instance.currentUser;

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("user");

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();


  //sign in account
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  // create user
  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }


 
  // saving the userdata
  Future savingUserData({ required String name, required String password, required String ConfirmPassword, required String email}) async {
    return await userCollection.doc(email).set({
      'name' : name,
      "password": password,
      "ConfirmPassword": ConfirmPassword,
      "email": email,
      "uid": email,
    });
  }


  // getting user data
  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }


  //update password
   updatePassword({ required String uid, required String password, required String ConfirmPassword}) async {
    try {
        await FirebaseFirestore.instance.collection('user').doc(uid).update({'password': password, 'ConfirmPassword' : ConfirmPassword});
        print("Mật khẩu đã được thay đổi thành công");
    } catch (e) {
        print(e);
        print("Lỗi khi cập nhật mật khẩu: $e");
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData(String userId) async {
    final docRef = FirebaseFirestore.instance.collection('user').doc(userId);
    final docSnapshot = await docRef.get();
    return docSnapshot;
  }
  
  // log out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }


}