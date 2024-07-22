import 'package:connect_athelete/Common/Common%20Color.dart';
import 'package:connect_athelete/Screens/Contact%20Us/Contact%20us%20Api.dart';
import 'package:connect_athelete/Screens/Login/LoginController.dart';
import 'package:connect_athelete/Screens/Payment/Checkout%20Controller.dart';
import 'package:connect_athelete/Screens/Payment/Payment%20Controller.dart';
import 'package:connect_athelete/Screens/Subscription/ActivatePlanController.dart';
import 'package:connect_athelete/Services/Announcement/Announcementbyrole.dart';
import 'package:connect_athelete/Services/Announcement/commonAnnouncement.dart';
import 'package:connect_athelete/Services/CMS%20Service/Announcement_Api.dart';
import 'package:connect_athelete/Services/CMS%20Service/BannerImage_Controller.dart';
import 'package:connect_athelete/Services/CMS%20Service/Terms_api.dart';
import 'package:connect_athelete/Services/CMS%20Service/cms_api.dart';
import 'package:connect_athelete/Services/CMS%20Service/parent_contest_api.dart';
import 'package:connect_athelete/Services/Chat/ChatHistory.dart';
import 'package:connect_athelete/Services/Chat/GetChatList.dart';
import 'package:connect_athelete/Services/Chat/SendMessage.dart';
import 'package:connect_athelete/Services/Favourite/Favourite_list.dart';
import 'package:connect_athelete/Services/Favourite/delete_Favourite.dart';
import 'package:connect_athelete/Services/Favourite/get_favourite_list.dart';
import 'package:connect_athelete/Services/Favourite/getclub_favourite_list.dart';
import 'package:connect_athelete/Services/Promocode%20Api/Promocode%20Controller.dart';
import 'package:connect_athelete/Screens/Registration%20screens/Athlete%20Registration/Athlete%20Registration%20Controller.dart';
import 'package:connect_athelete/Screens/Registration%20screens/Club%20Registration/Club%20Registration%20Controller.dart';
import 'package:connect_athelete/Screens/Subscription/Get%20Subscription%20Controller.dart';
import 'package:connect_athelete/Services/Athlete%20Service/Profile%20Details%20Api.dart';
import 'package:connect_athelete/Services/Athlete%20Service/Profile%20Edit%20Api.dart';
import 'package:connect_athelete/Services/Club%20Service/Club%20Details%20Api.dart';
import 'package:connect_athelete/Services/Club%20Service/Club%20Profile%20Edit%20Api.dart';
import 'package:connect_athelete/Services/Coach%20Service/Coach%20Profile%20Edit%20Api.dart';
import 'package:connect_athelete/Screens/Subscription/Subscription%20Controller.dart';
import 'package:connect_athelete/Services/Search%20service/Coach%20search.dart';
import 'package:connect_athelete/Services/Search%20service/academy_search_api.dart';
import 'package:connect_athelete/Services/Search%20service/athlete_search_api.dart';
import 'package:connect_athelete/Services/Transaction%20service/CurrentplanController.dart';
import 'package:connect_athelete/Services/Transaction%20service/Subscription_Api.dart';
import 'package:connect_athelete/Services/get%20data/City_list.dart';
import 'package:connect_athelete/Services/get%20data/Speciality_list.dart';
import 'package:connect_athelete/Services/get%20data/getall_cities.dart';
import 'package:connect_athelete/Services/get%20data/setting_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'Screens/Registration screens/Coach Registration/Coach Registration Controller.dart';
import 'Screens/Splash screen/splash.dart';
import 'Services/Coach Service/Coach Details Api.dart';
import 'Services/Payment service/Payment Api.dart';
import 'Services/Transaction service/Transaction_History_Api.dart';
import 'Services/Upload Image/DeleteimageController.dart';
import 'Services/Upload Image/Upload File Api.dart';
import 'Services/get data/List Sports.dart';
import 'Services/get data/state_list.dart';
import 'Services/password_service/Change password Api.dart';
import 'Services/password_service/forget_password_api.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey="pk_test_51PT4BW2NgzuLDBvzqGIKTSqR7ER1gVJsiTia2euX83XKG5LVUQYl9LN6nuSlmaY2q7LH2kTruefOU5sTZVnA2Mqp00PkCdFHuG";
  runApp(const MyApp());
  Get.put(LoginApi());
  Get.put(CoachRegistrationApi());
  Get.put(AthleteRegistrationApi());
  Get.put(Sportslistcontroller());
  Get.put(ClubRegisrationController());
  Get.put(Changepasswordcontroller());
  Get.put(ContactUscontroller());
  Get.put(ProfiledetailsController());
  Get.put(ProfileEditController());
  Get.put(CoachProfileController());
  Get.put(CoachEditProfileController());
  Get.put(ClubProfileDetailsController());
  Get.put(ClubProfileEditController());
  Get.put(ImageuploadController());
  Get.put(SubscriptionController());
  Get.put(PaymentController());
  Get.put(CheckoutController());
  Get.put(GetSubscriptionByid());
  Get.put(PromoCodeController());
  Get.put(SquarePaymentController());
  Get.put(TransactionHistoryController());
  Get.put(ForgetPasswordController());
  Get.put(SpecialitylistController());
  Get.put(SettingController());
  Get.put(CitylistController());
  Get.put(StatelistController());
  Get.put(GetSubscriptionPlanController());
  Get.put(AcademySearchController());
  Get.put(AthleteSearchController());
  Get.put(CoachSearchController());
  Get.put(GetallCitiesController());
  Get.put(CMSController());
  Get.put(Favourite_add_Controller());
  Get.put(Getallfavourite_Controller());
  Get.put(CMSTermsController());
  Get.put(CMSParentcontestController());
  Get.put(Deletefavourite_Controller());
  Get.put(GetClubfavourite_Controller());
  Get.put(Announcement_Controller());
  Get.put(BannerImageController());
  Get.put(Currentplancontroller());
  Get.put(CommonAnnouncementController());
  Get.put(AnnouncementController());
  Get.put(Deleteimagecontroller());
  Get.put(GetChatlistController());
  Get.put(SendMessageController());
  Get.put(ChatHistoyController());
  Get.put(ActivatePlanController());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Connect Athlete',
      scrollBehavior: const ScrollBehavior(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor:primary),
        useMaterial3: true,
        canvasColor: Colors.transparent,
        focusColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      debugShowCheckedModeBanner: false,
      home: const splash(),
    );
  }
}


