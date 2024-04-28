import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class AuthService extends ChangeNotifier {
  // instance d'auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //firestore Instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //sign in user
  Future<UserCredential> signInWithEmailandPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      
      // Verifier que l'email n'existe déja
      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email

      }, SetOptions(merge:true ));
      return userCredential;
    }

    // catch any Erorrs
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //Creer un Utilisateur

  Future<UserCredential> signUpWithEmailandPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      //after creating the user , L'ajout dans le DB (collection)
      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email

      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // déconnecter
  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}
