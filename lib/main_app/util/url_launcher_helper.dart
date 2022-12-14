import 'package:url_launcher/url_launcher.dart';

class UrlLauncherHelper{
  Future<void> launchFacebookUrl(String profileUrl) async {
    String fbWebUrl = 'https://facebook.com/$profileUrl';
    String fbUrl = 'fb://facewebmodal/f?href=$fbWebUrl';

    try {
      bool launched = await launch(fbUrl, forceSafariVC: false);
      print("Launched Native app $launched");

      if (!launched) {
        await launch(fbWebUrl, forceSafariVC: false);
        print("Launched browser $launched");
      }
    } catch (e) {
      await launch(fbWebUrl, forceSafariVC: false);
      print("Inside catch");
    }
  }

  Future<void> launchInstagramUrl(String profileUrl) async{
    String instaUrl = 'https://www.instagram.com/$profileUrl/';
    if (await canLaunch(instaUrl)) {
    await launch(
      instaUrl,
      universalLinksOnly: true,
      );
    } else {
    throw 'There was a problem to open the url: $instaUrl';
    }
  }

  Future<void> sendEmail(String url) async {
    if (await canLaunch('mailto:$url')) {
      await launch('mailto:$url');
    } else {
      throw 'Could not email $url';
    }
  }

  Future<void> makePhoneCall(String url) async {
    if (await canLaunch('tel:$url')) {
      await launch('tel:$url');
    } else {
      throw 'Could not launch $url';
    }
  }
}