import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn googleSignIn = GoogleSignIn();

class SignIn {
  String? name;
  String? email;
  String? imageUrl;

  Future<String?> signInWithGoogle() async {
    //google sign-in
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    //google authentication
    final GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount?.authentication;
    //get google account token and id
    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken);
    //sign-in with credential
    UserCredential authResult =
        await FirebaseAuth.instance.signInWithCredential(credential);
    User? user = authResult.user;

    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      // Checking if email and name is null
      assert(user.email != null);
      assert(user.displayName != null);
      assert(user.photoURL != null);

      // Store the retrieved data
      name = user.displayName!;
      email = user.email!;
      imageUrl = user.photoURL!;

      // if (name.contains("")) {
      //   name = name.substring(0, name.indexOf(""));
      // }

      final User? currentUser = FirebaseAuth.instance.currentUser;
      assert(user.uid == currentUser?.uid);

      print('signInWithGoogle succeeded: $user');
      return '$user';
    }
    return null;
  }

  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();

    print("User Signed Out");
  }
}
