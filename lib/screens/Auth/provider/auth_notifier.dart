// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:eventmobile/logging.dart';
import 'package:eventmobile/models/register_model.dart';
import 'package:eventmobile/models/user_models.dart';
import 'package:eventmobile/screens/Auth/email_sent_dialog.dart';
import 'package:eventmobile/screens/entryPoint/entry_point.dart';
import 'package:eventmobile/screens/onboarding.dart';
import 'package:eventmobile/services/api_service.dart';
import 'package:eventmobile/services/loader.dart';
import 'package:eventmobile/services/snackbar.dart';
import 'package:eventmobile/services/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

class AuthNotifier extends ChangeNotifier {
  ApiService apiService = ApiService();

  Future<void> registerUser(BuildContext context, Register register) async {
    final loader = Loader(context: context);
    Log.i('Register User');

    try {
      loader.show();
      Log.i('trying to register User');
      final response = await apiService.post('/Authentication/Register',
          body: register.toMap());
      Log.i('tried to register User');
      loader.close();

      if (response.statusCode == 200) {
        customSignInDialog(context, register.email, true);
        Log.i('Register User succesfully');
        notifyListeners();
      } else {
        SnackBarHelper.showErrorSnackBar(context, ' ${response.body}', false);
      }
    } on ClientException catch (e) {
      Log.e(' clientException ${e.message}');
      _handleClientException(context, e);
    } on SocketException catch (e) {
      Log.e('socketException ${e.message}');
      _handleSocketException(context, e);
    } catch (e) {
      _handleGenericException(context, e);
    } finally {
      loader.close();
      notifyListeners();
    }
  }

  Future<void> loginUser(
      BuildContext context, String email, String password) async {
    final loader = Loader(context: context);
    Log.i('Login User');

    final Map<String, dynamic> body = {
      'email': email.trim(),
      'password': password.trim(),
    };
    try {
      loader.show();
      Log.i('trying to Login User');
      final response =
          await apiService.post('/Authentication/Login', body: body);
      Log.i('tried to Login User');
      loader.close();

      if (response.statusCode == 200) {
        final Map<String, dynamic> listData = jsonDecode(response.body);

        final UserModel model = UserModel.fromMap(listData);

        await UserStorage.setToken(model.token);
        await UserStorage.setUserid(model.userId);
        await UserStorage.setUsername(model.username);

        Log.i('Login User succesfully');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const EntryPoint(),
          ),
        );
        notifyListeners();
      } else {
        SnackBarHelper.showErrorSnackBar(context, response.body, false);
      }
    } on ClientException catch (e) {
      Log.e(' clientException ${e.message}');
      _handleClientException(context, e);
    } on SocketException catch (e) {
      Log.e('socketException ${e.message}');
      _handleSocketException(context, e);
    } catch (e) {
      _handleGenericException(context, e);
    } finally {
      loader.close();
      notifyListeners();
    }
  }

  Future<void> refreshAccessToken() async {
    try {
      Log.i('getting refreshToken');
      final response =
          await apiService.post('/Authentication/refreshToken', body: {});

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final UserModel model = UserModel.fromMap(responseData);
        final newToken = model.token;

        // Update the token in storage
        await UserStorage.setToken(newToken);
        Log.i('Token refreshed successfully');
      } else {
        // Handle token refresh failure
        Log.e('Token refresh failed: ${response.body}');
      }
    } catch (e) {
      Log.e('Error during token refresh: $e');
    }
  }

  Future<void> resetPassword(BuildContext context, String email) async {
    final loader = Loader(context: context);
    Log.i('reset password');
    final Map<String, dynamic> body = {
      'email': email.trim(),
    };
    try {
      loader.show();
      Log.i('trying to reset password');
      final response = await apiService
          .post('/Authentication/InitiateResetPassword', body: body);
      Log.i('tried to reset password');
      loader.close();

      if (response.statusCode == 200) {
        customSignInDialog(context, email, false);
        Log.i('password reset succesfully');
        notifyListeners();
      } else {
        SnackBarHelper.showErrorSnackBar(context, ' ${response.body}', false);
      }
    } on ClientException catch (e) {
      Log.e(' clientException ${e.message}');
      _handleClientException(context, e);
    } on SocketException catch (e) {
      Log.e('socketException ${e.message}');
      _handleSocketException(context, e);
    } catch (e) {
      _handleGenericException(context, e);
    } finally {
      loader.close();
      notifyListeners();
    }
  }

  Future<void> logout(BuildContext context) async {
    await UserStorage.clear();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const OnboardingScreen(),
      ),
    );
  }

  Future<bool> isLoggedIn() async {
    // Check if there is a token or any other criteria to determine if the user is logged in
    var token = await UserStorage.getUserid();
    if (token == null) {
      return false;
    } else {
      return true;
    }
  }

  void _handleClientException(BuildContext context, ClientException e) {
    SnackBarHelper.showErrorSnackBar(
        context, 'Client exception: ${e.message}', false);
    // Handle client-specific exceptions here
  }

  void _handleSocketException(BuildContext context, SocketException e) {
    SnackBarHelper.showErrorSnackBar(
        context, 'Network error: ${e.message}', false);
    // Handle socket-specific exceptions here
  }

  void _handleGenericException(BuildContext context, dynamic e) {
    SnackBarHelper.showErrorSnackBar(
        context, 'An error occurred: ${e.toString()}', false);
    // Handle other exceptions here
  }
}

final authNotifierProvider =
    ChangeNotifierProvider<AuthNotifier>((ref) => AuthNotifier());
