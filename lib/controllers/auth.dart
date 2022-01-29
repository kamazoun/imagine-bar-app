/*
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;

UserCredential userCredential = await FirebaseAuth.instance
    .signInAnonymously(); // Would work if everybody kept using only one phone, but if not will not be able to sum up their sales on the long run. But I could use this for the waiter interface (in case not waiter logs in): it would allow the system to write to firestore and would only require each waiter to make the order at its name.


try {
UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
email: "barry.allen@example.com",
password: "SuperSecretPassword!"
);
} on FirebaseAuthException catch (e) {
if (e.code == 'weak-password') {
print('The password provided is too weak.');
} else if (e.code == 'email-already-in-use') {
print('The account already exists for that email.');
}
} catch (e) {
print(e);
}
// Email is delicate as everyone might not have it and may forget his password

// Phone auth seems to be the best choice as it allows to recognize each waiter across different devices and the sign in is easily done through an sms code received on the phone. The problem with phone auth is that, for web we need to add our application domain under OAuth Redirect Domains

// On native
await FirebaseAuth.instance.verifyPhoneNumber(
phoneNumber: '+44 7123 123 456',
timeout: const Duration(seconds: 60),
verificationCompleted: (PhoneAuthCredential credential) async {
// ANDROID ONLY!

// Sign the user in (or link) with the auto-generated credential
await auth.signInWithCredential(credential);
},
verificationFailed: (FirebaseAuthException e) {
if (e.code == 'invalid-phone-number') {
print('The provided phone number is not valid.');
}

// Handle other errors
},
codeSent: (String verificationId, int? resendToken) async {
// Update the UI - wait for the user to enter the SMS code
String smsCode = 'xxxx';

// Create a PhoneAuthCredential with the code
PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);

// Sign the user in (or link) with the credential
await auth.signInWithCredential(credential);
},
codeAutoRetrievalTimeout: (String verificationId) {},
); //codeAutoRetrievalTimeout: Handle a timeout of when automatic SMS code handling fails.

// Web
FirebaseAuth auth = FirebaseAuth.instance;

// Wait for the user to complete the reCAPTCHA & for an SMS code to be sent.
ConfirmationResult confirmationResult = await auth.signInWithPhoneNumber('+44 7123 123 456');

UserCredential userCredential = await confirmationResult.confirm(receivedSmsCode);

*/

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User user = FirebaseAuth.instance.currentUser;
  UserCredential _userCredential;

  AuthController() {
    if (null == user) {
      signInAnonymously();
    }
  }

  signInAnonymously() async {
    _userCredential = await _auth.signInAnonymously();
  }

  signInWithPhoneNumberOnPhone() {}

  signInWithPhoneNumberOnWeb() {}
}
