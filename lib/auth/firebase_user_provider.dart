import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class FaMAFirebaseUser {
  FaMAFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

FaMAFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<FaMAFirebaseUser> faMAFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<FaMAFirebaseUser>((user) => currentUser = FaMAFirebaseUser(user));
