import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<UserCredential> registerUserWithProfile({
    required String email,
    required String password,
    required String name,
    required File profilePhoto,
  }) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        String photoUrl = await _uploadProfilePhoto(user.uid, profilePhoto);
        await _updateUserDocument(user.uid, name, photoUrl);
        await user.updateDisplayName(name);
        await user.updatePhotoURL(photoUrl);
        await user.reload();

        print(photoUrl);
        return userCredential;
      }

      throw Exception('Failed to register user.');
    } catch (error) {
      throw error;
    }
  }

  Future<String> _uploadProfilePhoto(String userId, File profilePhoto) async {
    try {
      Reference storageReference =
          _firebaseStorage.ref().child('profile_photos/$userId.jpg');
      UploadTask uploadTask = storageReference.putFile(profilePhoto);
      TaskSnapshot taskSnapshot = await uploadTask;
      String photoUrl = await taskSnapshot.ref.getDownloadURL();
      return photoUrl;
    } catch (error) {
      throw error;
    }
  }

  Future<void> _updateUserDocument(
      String userId, String name, String photoUrl) async {
    try {
      await _firebaseFirestore.collection('users').doc(userId).set({
        'name': name,
        'role': "admin",
        'photoUrl': photoUrl,
      });
    } catch (error) {
      throw error;
    }
  }

  Future<UserCredential> signWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('User not found');
      } else {
        throw Exception('Error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> SignOut() async {
    await _firebaseAuth.signOut();
    notifyListeners();
  }
}
