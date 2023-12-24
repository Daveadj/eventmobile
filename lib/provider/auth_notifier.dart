// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:eventmobile/logging.dart';
import 'package:eventmobile/models/register_model.dart';
import 'package:eventmobile/screens/Auth/email_sent_dialog.dart';
import 'package:eventmobile/services/api_service.dart';
import 'package:eventmobile/services/loader.dart';
import 'package:eventmobile/services/snackbar.dart';
import 'package:flutter/cupertino.dart';
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
        customSignInDialog(context);
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
