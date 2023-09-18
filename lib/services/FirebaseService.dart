
import 'package:demo_fashion_app/classes/Auth.dart';
import 'package:demo_fashion_app/utils/shared_preferences_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // El inicio de sesión fue exitoso, puedes realizar acciones adicionales o navegar a otra página.
      print("Inicio de sesión exitoso: ${userCredential.user!.uid}");

      Account account = Account(
        id: userCredential.user!.uid,
        email: email,
        password: password
      );

      await saveUserLoggedIn(account);
/*      SharedPreferences prefs = await SharedPreferences.getInstance();

      Account loggedInUser = await getUserLoggedIn();
      print(loggedInUser.id); // Acceder a la información del usuari

      print("saddsa ${prefs.getString('user_id')} ");*/
    } catch (e) {
      throw e;
    }
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password, String names, String lastNames, String sex) async {
    try {
      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // print(userCredential);

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'names': names,
        'lastNames': lastNames,
        'email': email,
        'sex': sex,
        'photoUrl': "https://icon-library.com/images/default-profile-icon/default-profile-icon-24.jpg"
      });
    } catch (e) {
      throw e;
    }
  }

  Future<Account> getUserInfo() async {

    Account account = await getUserLoggedIn();
    String userId = account.id;

    try {
      final userDoc = await _firestore.collection('users').doc(userId).get();
      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        return Account(
          id: userId,
          names: userData['names'] ?? '',
          lastNames: userData['lastNames'] ?? '',
          email: userData['email'] ?? '',
          sex: userData['sex'] ?? '',
          photoUrl: userData['photoUrl'] ?? '',
        );
      }
      return Account(); // El usuario no existe en la base de datos.
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<Account> updateUserInfo(
      String names,
      String lastNames,
      String sex,
      ) async {
    try {
      Account account = await getUserLoggedIn();
      String userId = account.id;

      // Actualiza la información del usuario en la base de datos
      await _firestore.collection('users').doc(userId).update({
        'names': names,
        'lastNames': lastNames,
        'sex': sex,
        // 'photoUrl': photoUrl,
      });

      Account? updatedAccount = await getUserInfo();

      if (updatedAccount != null) {
        return updatedAccount;
      } else {
        throw Exception('No se pudo obtener la información actualizada del usuario.');
      }
    } catch (e) {
      throw e;
    }
  }


}
