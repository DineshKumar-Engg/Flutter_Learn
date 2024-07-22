import 'package:connect_athlete_admin/Screens/Sport/DeletesportController.dart';
import 'package:connect_athlete_admin/Screens/Sport/EditsportController.dart';
import 'package:connect_athlete_admin/Screens/Sport/Getall_sport_Controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../Common/Common Color.dart';
import '../../Common/Common_size.dart';
import '../../Common/Common_textstyle.dart';
import '../../Widget/Loading.dart';
import '../../Widget/appbar_widget.dart';
import '../../Widget/common_textfield.dart';
import 'add_sport.dart';

class add_sport_data extends StatefulWidget {
  const add_sport_data({super.key});

  @override
  State<add_sport_data> createState() => _add_sport_dataState();
}

class _add_sport_dataState extends State<add_sport_data> {
  int?selectedindex;
  int?sportiid;

  final Getall_sport_Controller getall_sport_controller=Get.find<Getall_sport_Controller>();
  final Editsporcontroller editsporcontroller=Get.find<Editsporcontroller>();
  final Deletesporcontroller deletesporcontroller=Get.find<Deletesporcontroller>();

  final TextEditingController sportnamecontroller=TextEditingController();
  final TextEditingController sportdesciptioncontroller=TextEditingController();

getallsport()async{
  showloadingdialog(context);
  await getall_sport_controller.GetSportApi(context);
  Navigator.pop(context);
}
  @override
  void initState() {
  getallsport();
getall_sport_controller.GetSportApi(context);
super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar_widget("Sport"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Sports", style: subscriptiontxt),
                  SizedBox(
                    height: displayheight(context) * 0.05,
                    width: displaywidth(context) * 0.40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Get.to(const add_sport());
                      },
                      child: Text("+ Add Sport", style: subscriptionbtntxtwhite),
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  Container(
                    width: displaywidth(context) * 1.50,
                    decoration: const BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: displaywidth(context) * 0.20,
                              child: Text("Sport Logo", style: listheadingtxt),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: displaywidth(context) * 0.30,
                              child: Center(child: Text("Sport Name", style: listheadingtxt)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: displaywidth(context) * 0.40,
                              child: Center(child: Text("Sport Description", style: listheadingtxt)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: displaywidth(context) * 0.20,
                              child: Center(child: Text("Action", style: listheadingtxt)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: displayheight(context) * 0.75,
                    width: displaywidth(context)*1.50,
                    child: Obx(() {
                      return RefreshIndicator(
                        backgroundColor: Colors.white,
                        color: secondary,
                        onRefresh: () async {
                          showloadingdialog(context);
                          await getall_sport_controller.GetSportApi(context);
                          Navigator.pop(context);
                        },
                        child: ListView.builder(
                          itemCount: getall_sport_controller.getsportdata
                              .length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            var data = getall_sport_controller
                                .getsportdata[index];
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  selectedindex = index;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: selectedindex == index ? const Color(
                                      0XFFD4D5E2) : Colors.white,
                                  border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade200),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: SizedBox(
                                            width: displaywidth(context) * 0.30,
                                            child: data['sportLogo']==null?
                                                const CircleAvatar(
                                                  radius: 25,
                                                  backgroundColor: Colors.grey,
                                                  child: Center(child: Icon(Icons.person,color: Colors.white,),),
                                                )
                                                :CircleAvatar(
                                              radius: 25,
                                              backgroundImage: NetworkImage(data['sportLogo'] ?? ''),
                                            )
                                        ),
                                      ),
                                      SizedBox(
                                        width: displaywidth(context) * 0.40,
                                        child: Center(child: Text(
                                            data['sportName'] ?? '',
                                            style: listsubheadingtxt)),
                                      ),

                                      SizedBox(
                                        width: displaywidth(context) * 0.45,
                                        child: Center(child: Text(
                                            data['sportDescription'] ?? '',
                                            style: listsubheadingtxt)),
                                      ),
                                      SizedBox(
                                        width: displaywidth(context) * 0.25,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .center,
                                          children: [
                                            InkWell(
                                                onTap: () {
                                                  editsportbottom(context, data['sportName']??'',
                                                      data['sportDescription']??'',data['id']??'',data['sportLogo']??'');
                                                },
                                                child: const Icon(
                                                  Icons.edit, color: primary,)),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: InkWell(
                                                  onTap: () {
                                                    logout(data['id']);
                                                  },
                                                  child: const Icon(
                                                    CupertinoIcons.delete,
                                                    color: Colors.red,)),
                                            )

                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  editsportbottom(BuildContext context,String sportname,String descriptiion,int id,img){
    return showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context, builder: (context){
      sportnamecontroller.text=sportname;
      sportdesciptioncontroller.text=descriptiion;
      sportiid=id;
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 150.0),
                  child: Divider(color: secondary,thickness: 3,),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Edit Sport",style:edittxt,),
                ),
                 Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(img),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Sport Name",style: listsubheadingtxt,),
                ),
                common_textfield(sportnamecontroller, "", TextInputType.text),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Sport Name",style: listsubheadingtxt,),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    style: inputtxt,
                    maxLines: 3,
                    maxLength: 500,
                    cursorColor: Colors.black,
                    controller: sportdesciptioncontroller,
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
                ),


                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 8.0),
                  child: SizedBox(
                    height: displayheight(context)*0.06,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: secondary,shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        )),
                        onPressed: (){
                       editsporcontroller.EditSportApi(context, sportnamecontroller.text, sportdesciptioncontroller.text, sportiid);
                        }, child: Center(child: Text("Edit",style: btntxtwhite,))),
                  ),
                )

              ],
            ),
          ),
        ),
      );
    });
  }

  logout(int id){
    return showDialog(context: context, builder: (BuildContext context){
      return  CupertinoAlertDialog(
        title: const Icon(CupertinoIcons.delete,color: Colors.red,size: 40,),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Are you sure you want to Delete the Sport.",style: inputtxt,textAlign: TextAlign.center,),
        ),
        actions: [
          CupertinoButton(onPressed: (){
            setState(() {
             deletesporcontroller.DeleteSportApi(context, id);
             Get.back();
            });
          }, child:  Text("Yes",style: drawertxt,)),
          CupertinoButton(onPressed: (){
            Get.back();
          }, child:  Text("No",style: drawertxt,))
        ],
      );
    });

  }
}
