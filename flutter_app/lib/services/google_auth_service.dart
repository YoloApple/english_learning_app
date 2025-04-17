
import 'dart:io';
import 'package:googleapis_auth/auth_io.dart';

class GoogleAuthService {
  static Future<AutoRefreshingAuthClient> getAuthClientFromServiceAccount() async {
    final accountCredentials = ServiceAccountCredentials.fromJson(
      File('assets/your_service_account.json').readAsStringSync(),
    );

    final scopes = ['https://www.googleapis.com/auth/cloud-platform'];
    final client = await clientViaServiceAccount(accountCredentials, scopes);
    return client;
  }
}
