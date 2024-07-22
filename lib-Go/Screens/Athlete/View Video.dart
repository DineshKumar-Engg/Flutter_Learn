import 'package:connect_athelete/Common/Common%20Size.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../Common/Common Color.dart';
import '../../widget/Appbar.dart';

class Viewvideoscreen extends StatefulWidget {
   String? image;
   Viewvideoscreen({super.key, required this.image});

  @override
  State<Viewvideoscreen> createState() => _ViewvideoscreenState();
}

class _ViewvideoscreenState extends State<Viewvideoscreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    print(widget.image);
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse("${widget.image??''}"))
      ..initialize().then((_) {
        setState(() {});
      });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor:background,
      appBar: appbarwidget("Videos"),
      body: _controller.value.isInitialized
          ? Stack(
            clipBehavior: Clip.none,
            children: [
              Center(
                child: Container(
                 height: displayheight(context)*0.40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller),
                          ),
                ),
              ),
              Positioned(
                left: 150,
                top: 150,
                right: 150,
                bottom: 150,
                child: IconButton(onPressed: (){
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                }, icon: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow,color: _controller.value.isPlaying?Colors.transparent:Colors.white,size: 50,)),
              )
            ],
          )
          : Container(),

    );
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
