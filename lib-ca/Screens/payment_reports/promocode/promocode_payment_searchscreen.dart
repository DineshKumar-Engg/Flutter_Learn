import 'package:connect_athlete_admin/Common/Common%20Color.dart';
import 'package:connect_athlete_admin/Screens/payment_reports/promocode/promocode_payments_Controller.dart';
import 'package:connect_athlete_admin/Screens/payment_reports/promocode/promocode_reports.dart';
import 'package:connect_athlete_admin/Widget/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiselect_dropdown_flutter/multiselect_dropdown_flutter.dart';
import '../../../Common/Common_size.dart';
import '../../../Common/Common_textstyle.dart';
import '../../../Widget/Loading.dart';
import '../../Sport/Getall_sport_Controller.dart';

class Promocode_payment_searchscreen extends StatefulWidget {
  const Promocode_payment_searchscreen({super.key});

  @override
  State<Promocode_payment_searchscreen> createState() => _Promocode_payment_searchscreenState();
}

class _Promocode_payment_searchscreenState extends State<Promocode_payment_searchscreen> {

  final Promocode_payment_Controller promocode_payment_controller=Get.find<Promocode_payment_Controller>();
  final Getall_sport_Controller getall_sport_controller=Get.find<Getall_sport_Controller>();

  final TextEditingController promocodevaluecontroller=TextEditingController();
  final TextEditingController accesslimitcontroller=TextEditingController();
  final TextEditingController discountcontroller =TextEditingController();
  final TextEditingController startdatecontroller=TextEditingController();
  final TextEditingController enddatecontroller=TextEditingController();

  final List <String>profiledata=['Athlete','Club and Academy'];

  String?SelectedProfile,Selectedsportid;
  int?profileid;

  Future<void> _selectDate(BuildContext context,controller) async {
    DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      // firstDate: DateTime(2020),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        controller.text = "${selectedDate.month}-${selectedDate.day}-${selectedDate.year}";
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    List sportlist = getall_sport_controller.getsportdata.map((item) =>(item['sportName'].toString())).toList();

    return  Scaffold(
      backgroundColor: background,
      appBar: appbar_widget("Promo Code Report Search"),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Promo Code Value",style: inputtxt,),
                  ),
                  TextFormField(
                    style: inputtxt,
                    cursorColor: Colors.black,
                    controller: promocodevaluecontroller,
                    keyboardType: TextInputType.text,
                    decoration:  InputDecoration(
                        hintText:"",
                        hintStyle:loginhinttxt ,
                        enabledBorder:  OutlineInputBorder(
                            borderSide: const BorderSide(color: textfieldcolor),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        focusedBorder:  OutlineInputBorder(
                            borderSide: const BorderSide(color: textfieldcolor),
                            borderRadius: BorderRadius.circular(10.0)
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Select Sports",style: inputtxt,),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(4.0),
                      child:  MultiSelectDropdown.simpleList(
                        list: sportlist,
                        textStyle: inputtxt,
                        duration:const Duration(microseconds: 0),
                        boxDecoration: BoxDecoration(
                            border: Border.all(color: Colors.black.withOpacity(0.10000000149011612),width: 1),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        whenEmpty: "",
                        listTextStyle: inputtxt,
                        checkboxFillColor:primary,
                        initiallySelected: [],
                        onChange: (newList) async{
                          sportlist=newList;
                          List selectedStateIds = newList.map((name) {
                            var stateItem = getall_sport_controller.getsportdata.firstWhere((item) => item['sportName'] == name);
                            return stateItem['id'];
                          }).toList();
                          String valuestring=selectedStateIds.join(',');
                          Selectedsportid=valuestring;
                          // await updateCityData();
                          print(Selectedsportid);

                        },
                      )
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Select Profile",style: inputtxt,),
                  ),
                  SizedBox(
                    height: displayheight(context)*0.07,
                    child: DropdownButtonFormField(
                      decoration:  InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color:Color(0xFFD9D9D9)),
                        ),
                      ),
                      value: SelectedProfile,
                      items: profiledata.map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item,style: inputtxt,),
                          onTap: (){
                            setState(() {
                              SelectedProfile=item;

                            });
                          },
                        );
                      }).toList(),
                      dropdownColor: Colors.white,
                      onChanged: (newValue) {
                        setState(() {
                          SelectedProfile = newValue as String;
                        });
                        if (SelectedProfile == 'Athlete') {
                          profileid=2;
                        } else if (SelectedProfile == 'Club and Academy') {
                          profileid=4;// or any other action
                        }
                        print(profileid);
                      },

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Start Date",style: inputtxt,),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: displayheight(context)*0.07,
                      child: TextFormField(
                        onTap: ()=>_selectDate(context,startdatecontroller),
                        style: inputtxt,
                        cursorColor: Colors.black,
                        controller: startdatecontroller,
                        readOnly: true,
                        decoration:  InputDecoration(
                            suffixIcon: const Icon(Icons.calendar_month,color: Colors.black,),
                            enabledBorder:  OutlineInputBorder(
                                borderSide: const BorderSide(color: textfieldcolor),
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            focusedBorder:  OutlineInputBorder(
                                borderSide: const BorderSide(color: textfieldcolor),
                                borderRadius: BorderRadius.circular(10.0)
                            )
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("End Date",style: inputtxt,),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: displayheight(context)*0.07,
                      child: TextFormField(
                        onTap: ()=>_selectDate(context,enddatecontroller),
                        style: inputtxt,
                        cursorColor: Colors.black,
                        controller: enddatecontroller,
                        readOnly: true,
                        decoration:  InputDecoration(
                            suffixIcon: const Icon(Icons.calendar_month,color: Colors.black,),
                            enabledBorder:  OutlineInputBorder(
                                borderSide: const BorderSide(color: textfieldcolor),
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            focusedBorder:  OutlineInputBorder(
                                borderSide:const  BorderSide(color: textfieldcolor),
                                borderRadius: BorderRadius.circular(10.0)
                            )
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: displayheight(context)*0.06,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: secondary,shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                        )),
                        onPressed: ()async{
                          showloadingdialog(context);
                          await promocode_payment_controller.PromocodeReportApi(context,Selectedsportid??'', startdatecontroller.text, enddatecontroller.text, profileid??'', promocodevaluecontroller.text);
                          Navigator.pop(context);
                          List<Map<String,dynamic>> data=List<Map<String,dynamic>>.from(promocode_payment_controller.getpromocodereports);
                          Get.to(PromocodeReportsscreen(data:data));
                        },child: Text("Search",style: btntxtwhite,),),
                    ),
                  )

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
