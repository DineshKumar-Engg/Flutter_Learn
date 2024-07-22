import 'package:connect_athlete_admin/Screens/Billing/AddBillingstate_Controller.dart';
import 'package:connect_athlete_admin/Screens/Billing/DeletebillingstateController.dart';
import 'package:connect_athlete_admin/Screens/Billing/EditbillingstateController.dart';
import 'package:connect_athlete_admin/Screens/Billing/Getall_Billing_Controller.dart';
import 'package:connect_athlete_admin/Screens/Contact/Getall_Contact_Controller.dart';
import 'package:connect_athlete_admin/Screens/Login/login_Controller.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Athlete/AddathleteController.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Athlete/AthleteApproveController.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Athlete/AthleteSearchController.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Athlete/AthletepublishController.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Athlete/EditAthleteController.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Athlete/GetallathleteController.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Athlete/deleteathleteController.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Club/AddclubController.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Club/ClubApproveController.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Club/ClubpublishController.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Club/DeleteclubController.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Club/EditclubController.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Club/GetallClubController.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Coach/AddcoachController.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Coach/CoachApproveController.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Coach/CoachPublishController.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Coach/CoachsearchController.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Coach/DeletecoachController.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Coach/EditcoachController.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Coach/GetallCoachController.dart';
import 'package:connect_athlete_admin/Screens/Speciality/Getspeciality_Controller.dart';
import 'package:connect_athlete_admin/Screens/Speciality/addspeciality_Controller.dart';
import 'package:connect_athlete_admin/Screens/Speciality/deletespeciality_Controller.dart';
import 'package:connect_athlete_admin/Screens/Sport/DeletesportController.dart';
import 'package:connect_athlete_admin/Screens/Sport/EditsportController.dart';
import 'package:connect_athlete_admin/Screens/Sport/Getall_sport_Controller.dart';
import 'package:connect_athlete_admin/Screens/Sport/addsport_Controller.dart';
import 'package:connect_athlete_admin/Screens/password/Changepassword_Controller.dart';
import 'package:connect_athlete_admin/Screens/password/ForgetpasswordController.dart';
import 'package:connect_athlete_admin/Screens/password/changepassword_screen.dart';
import 'package:connect_athlete_admin/Screens/payment_reports/athlete/athlete_payments_Controller.dart';
import 'package:connect_athlete_admin/Screens/payment_reports/club/club_payment_Controller.dart';
import 'package:connect_athlete_admin/Screens/payment_reports/promocode/promocode_payments_Controller.dart';
import 'package:connect_athlete_admin/Screens/profile/EditprofileController.dart';
import 'package:connect_athlete_admin/Screens/profile/GetprofiileController.dart';
import 'package:connect_athlete_admin/Screens/promocode/Addpromocode_Controller.dart';
import 'package:connect_athlete_admin/Screens/promocode/DeletepromocodeController.dart';
import 'package:connect_athlete_admin/Screens/promocode/EditpromocodeController.dart';
import 'package:connect_athlete_admin/Screens/promocode/Getall_proocode_Controller.dart';
import 'package:connect_athlete_admin/Screens/subscription/AddsubscriptionController.dart';
import 'package:connect_athlete_admin/Screens/subscription/DeletesubscriptionController.dart';
import 'package:connect_athlete_admin/Screens/subscription/EditsubscriptionController.dart';
import 'package:connect_athlete_admin/Screens/subscription/Getall_subscription_Controller.dart';
import 'package:connect_athlete_admin/service/CitylistController.dart';
import 'package:connect_athlete_admin/service/Dashboard/GetathleteController.dart';
import 'package:connect_athlete_admin/service/Dashboard/GetclubcountController.dart';
import 'package:connect_athlete_admin/service/Dashboard/GetcoachcountController.dart';
import 'package:connect_athlete_admin/service/Dashboard/OverallprofileController.dart';
import 'package:connect_athlete_admin/service/GetStatelistController.dart';
import 'package:connect_athlete_admin/service/Get_sportlist_Controller.dart';
import 'package:connect_athlete_admin/service/GetallspecialityController.dart';
import 'package:connect_athlete_admin/service/GetcitylistController.dart';
import 'package:connect_athlete_admin/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Screens/Profile_report/Club/ClubsearchController.dart';
import 'Screens/Speciality/editspeciality_Controller.dart';

void main() {
  runApp(const MyApp());
  Get.put(login_Controller());
  Get.put(Getspeciality_Controller());
  Get.put(Get_sport_Controller());
  Get.put(Getall_Billing_Controller());
  Get.put(Getall_sport_Controller());
  Get.put(Getall_promocode_Controller());
  Get.put(Getall_subscription_Controller());
  Get.put(Getall_contact_Controller());
  Get.put(addsport_Controller());
  Get.put(addspeciality_Controller());
  Get.put(deletespeciality_Controller());
  Get.put(Editspeciality_Controller());
  Get.put(AddpromocodeController());
  Get.put(Editsporcontroller());
  Get.put(Deletesporcontroller());
  Get.put(StatelistController());
  Get.put(AddbillingstateController());
  Get.put(EditbillingstateController());
  Get.put(DeletebillingstateController());
  Get.put(EditpromocodeController());
  Get.put(DeletepromocodeController());
  Get.put(AddsubscriptionController());
  Get.put(EditsubscriptionController());
  Get.put(DeletesubscriptionController());
  Get.put(GetallAthleteController());
  Get.put(GetProfileController());
  Get.put(EditprofileController());
  Get.put(AthletepublishController());
  Get.put(CitylistController());
  Get.put(SpecialitylistController());
  Get.put(AthleteRegistrationApi());
  Get.put(DeleteAthleteController());
  Get.put(EditRegistrationController());
  Get.put(GetallClubController());
  Get.put(GetallCoachController());
  Get.put(ClubpublishController());
  Get.put(GetallCitylistController());
  Get.put(ClubRegisrationController());
  Get.put(AthleteapproveController());
  Get.put(CoachpublishController());
  Get.put(CoachapproveController());
  Get.put(ClubapproveController());
  Get.put(DeleteClubController());
  Get.put(DeleteCoachController());
  Get.put(CoachRegistrationApi());
  Get.put(GetAthleteprofileController());
  Get.put(OverallprofileController());
  Get.put(GetCoachprofilecountController());
  Get.put(GetClubprofilecountController());
  Get.put(AthletesearchController());
  Get.put(ClubsearchController());
  Get.put(CoachsearchController());
  Get.put(Athlete_payment_Controller());
  Get.put(Club_payment_Controller());
  Get.put(Promocode_payment_Controller());
  Get.put(ForgetPasswordController());
  Get.put(EditclubController());
  Get.put(EditcoachController());
  Get.put(Changepasswordcontroller());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'Connect Athlete Admin',
      debugShowCheckedModeBanner: false,
      home: splash_screen(),
    );
  }
}


