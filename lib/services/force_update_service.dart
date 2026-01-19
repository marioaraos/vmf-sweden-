import 'package:firebase_core/firebase_core.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ForceUpdateService {
  static Future<bool> isUpdateRequired() async {
    // Aquí consultarías tu versión mínima desde Firestore/RemoteConfig
    // Por ahora, simulamos una validación:
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String currentVersion = packageInfo.version;

    // Si la versión mínima requerida es mayor a la actual, retorna true
    return false;
  }
}