import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:share_plus/share_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DynamicLinkService {
  DynamicLinkService._();
  static final DynamicLinkService instance = DynamicLinkService._();

  // Reemplaza esto con tu URL de Firebase Console (Dynamic Links)
  final String _urlPrefix = 'https://vmflux.page.link';

  /// Genera un link de invitación único para el usuario
  Future<void> shareInviteLink() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final String inviteCode = user.uid.substring(0, 8).toUpperCase();
    
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: _urlPrefix,
      link: Uri.parse('https://vmf-lux.com/invite?code=$inviteCode'),
      androidParameters: const AndroidParameters(
        packageName: 'com.vmf.lux.project',
        minimumVersion: 0,
      ),
      iosParameters: const IOSParameters(
        bundleId: 'com.vmf.lux.project',
        minimumVersion: '0',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: 'Join me on VMF LUX',
        description: 'The most exclusive sanctuary for elite members.',
        imageUrl: Uri.parse('https://vmf-lux.com/assets/images/logo_gold.png'),
      ),
    );

    final ShortDynamicLink shortLink = await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    final Uri url = shortLink.shortUrl;

    await Share.share(
      'Join my inner circle at VMF LUX. Use my invite code: $inviteCode\n\n$url',
      subject: 'VMF LUX Invitation',
    );
  }

  /// Escucha y procesa los links de invitación al abrir la app
  Future<void> initDynamicLinks(Function(String code) onInviteReceived) async {
    // 1. Manejar el link si la app se abre desde un estado cerrado
    final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink();
    _handleDeepLink(data, onInviteReceived);

    // 2. Manejar el link si la app está en segundo plano
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      _handleDeepLink(dynamicLinkData, onInviteReceived);
    }).onError((error) {
      print('Dynamic Link Error: ${error.message}');
    });
  }

  void _handleDeepLink(PendingDynamicLinkData? data, Function(String code) onInviteReceived) {
    final Uri? deepLink = data?.link;
    if (deepLink != null) {
      final code = deepLink.queryParameters['code'];
      if (code != null) {
        onInviteReceived(code);
      }
    }
  }
}
