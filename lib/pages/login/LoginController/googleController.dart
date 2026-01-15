import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleController extends GetxController{
  Future<void>signInWithGoogle() async{
    FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn=GoogleSignIn();
    final GoogleSignInAccount? googleuser =  await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleuser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final UserCredential userCredential = await auth.signInWithCredential(credential);
  }
}