import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class Helpers {
  // Share text using the share_plus package.
  static void shareApp() {
    Share.share('Flutter Package Demo');
  }

  // Launch a URL in the default browser using url_launcher.
  static Future<void> openFlutterSite() async {
    final uri = Uri.parse('https://flutter.dev');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }
}
