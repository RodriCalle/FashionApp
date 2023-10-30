
import 'dart:convert';
import 'dart:io';

import 'package:demo_fashion_app/classes/auth.dart';
import 'package:demo_fashion_app/classes/cloth_information.dart';
import 'package:demo_fashion_app/utils/shared_preferences_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../classes/outfit_response.dart';
import '../utils/utils.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

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
      print("errorrrrrrrrrrrriniciando");
      print(e);
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
      print("errorrrrrrrrrrrr");
      print(e);
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

  Future<String> uploadImage(File imageFile) async {
    Account account = await getUserLoggedIn();
    String userId = account.id;

    try {
      final Reference storageRef = _storage.ref().child('profile_images/$userId.jpg');
      final UploadTask uploadTask = storageRef.putFile(imageFile);
      final TaskSnapshot snapshot = await uploadTask;
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } on FirebaseException catch (e) {
      print('Error al cargar la imagen: $e');
      // Manejar el error de Firebase Storage aquí.
      return "https://icon-library.com/images/default-profile-icon/default-profile-icon-24.jpg";
    } catch (e) {
      print('Error desconocido al cargar la imagen: $e');
      // Manejar otros errores aquí.
      return "https://icon-library.com/images/default-profile-icon/default-profile-icon-24.jpg";
    }
  }

  Future<void> updateProfilePhoto(String photoUrl) async {
    Account account = await getUserLoggedIn();
    String userId = account.id;

    try {
      await _firestore.collection('users').doc(userId).update({
        'photoUrl': photoUrl,
      });
    } catch (e) {
      print('Error al actualizar la foto de perfil: $e');
      throw e;
    }
  }

  // outfit images
  Future<bool> uploadOutfitImage(OutfitResponse outfit) async {
    Account account = await getUserLoggedIn();
    String userId = account.id;

    File imageFile = await saveBytesImageToTemporaryFile(base64Decode(outfit.imgB64), outfit.id);

    try {
      final Reference storageRef = _storage.ref().child('outfits/${userId}/${outfit.id}.jpg');
      final UploadTask uploadTask = storageRef.putFile(imageFile);
      final TaskSnapshot snapshot = await uploadTask;
      final String downloadUrl = await snapshot.ref.getDownloadURL();

      outfit.urlImage = downloadUrl;

      final userDoc = await _firestore.collection('users').doc(userId).get();
      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        List<dynamic> favorites = userData['favoritesOutfits'] ?? [];
        outfit.favorite = true;
        favorites.add(outfit.toMapSave());
        await _firestore.collection('users').doc(userId).update({
          'favoritesOutfits': favorites,
        });
      }

      return true;
    } on FirebaseException catch (e) {
      print('Error al cargar la imagen: $e');
      return false;
    } catch (e) {
      print('Error desconocido al cargar la imagen: $e');
      return false;
    }
  }

  Future<bool> deleteOutfitImage(String id) async {
    Account account = await getUserLoggedIn();
    String userId = account.id;

    try {
      final Reference storageRef = _storage.ref().child('outfits/${userId}/$id.jpg');
      await storageRef.delete();

      final userDoc = await _firestore.collection('users').doc(userId).get();
      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        List<dynamic> favorites = userData['favoritesOutfits'] ?? [];
        favorites.removeWhere((element) => element['id'] == id);
        await _firestore.collection('users').doc(userId).update({
          'favoritesOutfits': favorites,
        });
      }

      return true;
    } on FirebaseException catch (e) {
      print('Error al eliminar la imagen: $e');
      return false;
    } catch (e) {
      print('Error desconocido al eliminar la imagen: $e');
      return false;
    }
  }

  Future<List<OutfitResponse>> getAllOutfitsSaved() async {
    Account account = await getUserLoggedIn();
    String userId = account.id;

    try {
      final userDoc = await _firestore.collection('users').doc(userId).get();
      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        List<dynamic> favorites = userData['favoritesOutfits'] ?? [];
        List<OutfitResponse> outfits = [];
        for (var outfit in favorites) {
          outfits.add(OutfitResponse.fromMap(outfit));
        }
        return outfits;
      }
      return [];
    } catch (e) {
      print(e);
      throw e;
    }
  }

  // cloths images
  Future<bool> uploadClothImage(File? image, ClothInformation cloth) async {
    Account account = await getUserLoggedIn();
    String userId = account.id;

    cloth.id = getFormattedCurrentDateTime();

    try {
      final Reference storageRef = _storage.ref().child('cloths/${userId}/${cloth.id}.jpg');
      final UploadTask uploadTask = storageRef.putFile(image!);
      final TaskSnapshot snapshot = await uploadTask;
      final String downloadUrl = await snapshot.ref.getDownloadURL();

      cloth.urlImage = downloadUrl;

      final userDoc = await _firestore.collection('users').doc(userId).get();
      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        List<dynamic> cloths = userData['cloths'] ?? [];
        cloths.add(cloth.toMap());
        await _firestore.collection('users').doc(userId).update({
          'cloths': cloths,
        });
      }

      return true;
    } on FirebaseException catch (e) {
      print('Error al cargar la imagen: $e');
      return false;
    } catch (e) {
      print('Error desconocido al cargar la imagen: $e');
      return false;
    }
  }

  Future<bool> deleteClothImage(String id) async {
    Account account = await getUserLoggedIn();
    String userId = account.id;

    try {
      final Reference storageRef = _storage.ref().child('cloths/${userId}/$id.jpg');
      await storageRef.delete();

      final userDoc = await _firestore.collection('users').doc(userId).get();
      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        List<dynamic> cloths = userData['cloths'] ?? [];
        cloths.removeWhere((element) => element['id'] == id);
        await _firestore.collection('users').doc(userId).update({
          'cloths': cloths,
        });
      }

      return true;
    } on FirebaseException catch (e) {
      print('Error al eliminar la imagen: $e');
      return false;
    } catch (e) {
      print('Error desconocido al eliminar la imagen: $e');
      return false;
    }
  }

  Future<List<ClothInformation>> getAllClothsSaved() async {
    Account account = await getUserLoggedIn();
    String userId = account.id;

    try {
      final userDoc = await _firestore.collection('users').doc(userId).get();
      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        List<dynamic> favorites = userData['favoritesCloths'] ?? [];
        List<ClothInformation> cloths = [];
        for (var cloth in favorites) {
          cloths.add(ClothInformation.fromMap(cloth));
        }
        return cloths;
      }
      return [];
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
