// ignore_for_file: use_build_context_synchronously

import 'package:bloomi_web/models/auth/user_model.dart';
import 'package:bloomi_web/utils/util_constant.dart';
import 'package:bloomi_web/utils/util_method.dart';
import 'package:bloomi_web/utils/util_method_forgot_password.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class AuthController {
  //-----------------------To SignUp user---------------------
  Future<void> signUpUser(
    String email,
    String password,
    String name,
    String phone,
    String department,
    String faculty,
    String year,
    String userType,
    BuildContext context,
  ) async {
    try {
      //create user with email and password
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        saveUserData(
          credential.user!.uid,
          name,
          email,
          phone,
          department,
          faculty,
          year,
          userType, //save user data in cloud firestore
        );
      }
      Logger().i(credential.user);
    } on FirebaseAuthException catch (e) {
      UtilMethod.customDialogBox(context, "Error", e.code);
      Logger().e(e);
    } catch (e) {
      Logger().e(e);
    }
  }

  //----------------------saving user data in cloud firestore---------------------
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> saveUserData(String uid, String name, String email, String phone,
      String department, String faculty, String year, String userType) {
    return users
        .doc(uid)
        .set({
          'uid': uid,
          'name': name,
          'email': email,
          'phone': phone,
          'department': department,
          'faculty': faculty,
          'year': year,
          'userType': userType,
          'imgUrl': UtilConstants.dummyProfileUrl,
        })
        .then((value) => Logger().i("User Added"))
        .catchError((error) => Logger().e("Failed to add user: $error"));
  }

  //-----------------------fetch user data from database---------------------
  Future<UserModel?> fetchUserData(String uid) async {
    try {
      //-------firebase quary to fetch user data from database--------
      DocumentSnapshot documentSnapshot = await users.doc(uid).get();

      //-------mapping user data to user model--------
      UserModel user =
          UserModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);

      Logger().i(user.email);

      return user;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  //-----------------------To SignOut user---------------------
  static Future<void> signOutUser() async {
    try {
      //sign out user
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      Logger().e(e);
    } catch (e) {
      Logger().e(e);
    }
  }

  //-----------------------To SignIn user---------------------
  static Future<void> signInUser(
      String email, String password, BuildContext context) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Logger().i(credential.user);
    } on FirebaseAuthException catch (e) {
      Logger().e(e);
      UtilMethod.customDialogBox(context, "Error", e.code);
    } catch (e) {
      Logger().e(e);
    }
  }

  //-----------------------To Reset Password---------------------
  static Future<void> resetPassword(String email, BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email).then(
          (value) => UtilMethodForgotPassword.customDialogBox(
              context, "Email sent", "Please check your email"));
    } on FirebaseAuthException catch (e) {
      UtilMethod.customDialogBox(context, "Error", e.code);
      Logger().e(e);
    } catch (e) {
      Logger().e(e);
    }
  }
}
