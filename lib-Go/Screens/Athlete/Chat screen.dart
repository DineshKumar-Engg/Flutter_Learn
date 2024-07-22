import 'dart:async';
import 'package:connect_athelete/Screens/Athlete/ViewChatProfilescreen.dart';
import 'package:connect_athelete/Services/Chat/ChatHistory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../Common/Common Color.dart';
import '../../Common/Common Size.dart';
import '../../Common/Common Textstyle.dart';
import '../../Services/Chat/SendMessage.dart';

class Chatscreen extends StatefulWidget {
  final String name,image,email;
  final int id;
  Chatscreen({super.key, required this.name,required this.id,required this.image,required this.email});

  @override
  State<Chatscreen> createState() => _ChatscreenState();
}

class _ChatscreenState extends State<Chatscreen> {
  final SendMessageController sendMessageController = Get.find<SendMessageController>();
  final ChatHistoyController chatHistoyController = Get.find<ChatHistoyController>();

  final TextEditingController searchcontroller = TextEditingController();
  final ScrollController scrollController=ScrollController();

  late IO.Socket socket;
  List chats = [];
  int? userid;
  Timer ?_timer;

  void _scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(microseconds: 1),
      curve: Curves.easeOut,
    );
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
    _setupSocket();
    _loadUserId();
    chatHistoyController.ChatHistoryApi(context, widget.id);
    _timer=Timer.periodic(const Duration(seconds: 1), (timer)=>chatHistoyController.ChatHistoryApi(context, widget.id));
  }

  void _loadUserId() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userid = sharedPreferences.getInt('userid') ?? 0;
    });
  }

  void _setupSocket() {
    socket = IO.io('ws://api.engageathlete.com:8000',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .setExtraHeaders({'foo': 'bar'}) // Add any required headers
            .build());

    socket.connect();

    socket.onConnect((_) {
      print('Connected to server');
    });

    socket.onConnectError((error) {
      print('Connection Error: $error');
      if (error is Map) {
        print('Error Details: ${error['msg']}, Description: ${error['desc']}');
      }
    });

    socket.onError((error) {
      print('Error: $error');
    });

    socket.onDisconnect((_) {
      print('Disconnected from server');
    });

    socket.on('receive_message', (data) {
      setState(() {
        chatHistoyController.chathistorydata.add(data);
      });
    });
  }

  void _sendMessage(String message) async {
    if (message.isNotEmpty && userid != null) {
      chatHistoyController.ChatHistoryApi(context, widget.id);
      // Emit the message via socket
      socket.emit('send', {
        'content': message,
        'senderId': '$userid',
        'receiverId': widget.id,
        'roleId': '2',
        'room': '$userid-${widget.id}'
      });

      final response = await sendMessageController.SendMessageApi(context, widget.id, message);
      chatHistoyController.ChatHistoryApi(context, widget.id);

      if (response.statusCode == 200) {
        setState(() {
          chats.add({'chat1': message, 'chat2': ''}); // Assuming chat1 is the sent message
        });
      } else {
        print('Failed to send message: ${response.body}');
      }

      // Clear the input field
      searchcontroller.clear();
    }
  }

  @override
  void dispose() {
    socket.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1F1F1),
        leading: IconButton(
          onPressed: () {
            socket.disconnect();
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
        title: InkWell(
          onTap: (){
         // Get.to(Viewchatprofilescreen(
         //   image:widget.image,
         //   name:widget.name,
         // ));
          },
          child: Row(
            children: [
               widget.image.isEmpty?
                   const CircleAvatar(
                     radius: 20,
                     child: Center(child: Icon(Icons.person,color: primary,),),
                   )
                   :CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(widget.image),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(widget.name, style: chatheadingtxtnew),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Obx(() {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: displayheight(context) * 0.89,
                child: chatHistoyController.chathistorydata.isEmpty
                    ? Center(
                  child: Text("Start Your Conversation", style: inputtxt),
                )
                    : RefreshIndicator(
                  backgroundColor: primary,
                  color: Colors.white,
                  onRefresh: () async {
                    await chatHistoyController.ChatHistoryApi(context, widget.id);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 80.0),
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: chatHistoyController.chathistorydata.length,
                      itemBuilder: (BuildContext context, int index) {
                        var chat = chatHistoyController.chathistorydata[index];
                        bool isSender = chat['senderId'] == userid;
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                mainAxisAlignment: isSender
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Flexible(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: isSender ? Colors.white : newyellow,
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 1.0,
                                            spreadRadius: 0.2,
                                          )
                                        ],
                                        borderRadius: isSender
                                            ? const BorderRadius.only(
                                          bottomRight: Radius.circular(20),
                                          topLeft: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                        )
                                            : const BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          topLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Text(
                                          chat['content'] ?? '',
                                          style: isSender ? chattxt1 : chattxt2,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          }),
          Positioned(
            bottom: 10,
            left: 20,
            right: 20,
            child: Container(
              height: displayheight(context) * 0.07,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(2, 4),
                    spreadRadius: 1,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: TextFormField(
                cursorColor: Colors.black,
                style: inputtxt,
                controller: searchcontroller,
                decoration: InputDecoration(
                  hintText: "Text your message",
                  hintStyle: searchhinttxt,
                  suffixIcon: IconButton(
                    onPressed: () {
                      _sendMessage(searchcontroller.text);
                      chatHistoyController.ChatHistoryApi(context, widget.id);
                    },
                    icon: const Icon(Icons.send, color: primary),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}