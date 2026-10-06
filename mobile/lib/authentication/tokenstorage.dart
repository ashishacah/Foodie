import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Tokenstorage {
  static const storage = FlutterSecureStorage();
  static Future<void> saveTokens({
    required String access,
    required String refresh,
  }) async {
    await storage.write(key: "refresh_tokens", value: refresh);
    await storage.write(key: "access_tokens", value: access);
  }

  static Future<String?> getAcessToken() async {
    return await storage.read(key: "access_tokens");
  }

  static Future<String?> getRefreahToken() async {
    return await storage.read(key: "refresh_tokens");
  }

  static Future<void> logout() async {
    await storage.delete(key: "access_tokens");
    await storage.delete(key: "refresh_tokens");
  }
}
