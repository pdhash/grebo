// class FBAuth {
//   Future<Resource?> signInWithFacebook() async {
//     try {
//       final LoginResult result = await FacebookAuth.instance.login();
//       switch (result.status) {
//         case LoginStatus.success:
//           final AuthCredential facebookCredential =
//               FacebookAuthProvider.credential(result.accessToken!.token);
//           final userCredential =
//               await _auth.signInWithCredential(facebookCredential);
//           return Resource(status: Status.Success);
//         case LoginStatus.cancelled:
//           return Resource(status: Status.Cancelled);
//         case LoginStatus.failed:
//           return Resource(status: Status.Error);
//         default:
//           return null;
//       }
//     } on FirebaseAuthException catch (e) {
//       throw e;
//     }
//   }
// }
