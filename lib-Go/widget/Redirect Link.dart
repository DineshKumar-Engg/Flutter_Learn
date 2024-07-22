import 'package:url_launcher/url_launcher.dart';

 Future <void>urllauncher(String link)async{
   final Uri uri=Uri.parse(link);
   if(!await launchUrl(uri,mode: LaunchMode.inAppWebView));
  }
