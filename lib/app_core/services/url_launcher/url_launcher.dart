import 'package:alsurrah/app_core/app_core.dart';
import 'package:url_launcher/url_launcher.dart';

openURL(urlLink) async {
  var url = urlLink;
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  } else {
    locator<ToastTemplate>().show('Could not launch $url');
  }
}

class MapUtils {
  MapUtils._();

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}
