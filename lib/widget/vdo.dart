import 'package:flutter/material.dart';
import 'package:gold247/constant/constant.dart';
import 'package:video_player/video_player.dart';

class VideoDemo2 extends StatefulWidget {
  VideoDemo2({this.videolink});
  final String videolink;
  final String title = "Video Demo";

  @override
  VideoDemo2State createState() => VideoDemo2State();
}

class VideoDemo2State extends State<VideoDemo2> {
  //
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.network(widget.videolink);
    //_controller = VideoPlayerController.asset("videos/sample_video.mp4");
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.pause();
    // _controller.setLooping(true);
    // _controller.setVolume(1.0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: AspectRatio(
                  aspectRatio: 3 / 2,
                  child: VideoPlayer(_controller),
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     setState(() {
      //       if (_controller.value.isPlaying) {
      //         _controller.pause();
      //       } else {
      //         _controller.play();
      //       }
      //     });
      //   },
      //   child:
      //   Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
      // ),
    );
  }
}
