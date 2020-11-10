import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/general/view/loginPage.dart';
import 'package:flutter_app/member/view/memberHomeScreen.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User> _firebaseUser = Rx<User>();

  String get user => _firebaseUser.value?.email;

  @override
  onInit() {
    _firebaseUser.bindStream(_auth.authStateChanges());
  }

  void createUser(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password);
      Get.back();
    } catch (e) {
      Get.snackbar(
        "Error signing up",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email.trim(), password: password);
      Get.offAll(MemberHomeScreen());
    } catch (e) {
      Get.snackbar(
        "Error signing in",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void signOut() async {
    try {
      await _auth.signOut();
      Get.offAll(LoginPage());
    } catch (e) {
      Get.snackbar(
        "Error signing out",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
