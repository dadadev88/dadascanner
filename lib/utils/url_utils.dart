import 'package:url_launcher/url_launcher.dart';

class URLUtils {
  static Future<void> openURL(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      await launchUrl(uri);
    } catch (_) {
      throw Exception('Could not launch $url');
    }
  }
}
