import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayFilm extends StatefulWidget {
  String url;
  PlayFilm({Key? key, required this.url}) : super(key: key);

  @override
  _PlayFilmState createState() => _PlayFilmState();
}

class _PlayFilmState extends State<PlayFilm>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late VideoPlayerController videoPlayerControler =
      VideoPlayerController.network(widget.url);
  late ChewieController chewieController;

  @override
  void initState() {
    videoPlayerControler.addListener(() {
      setState(() {});
    });
    chewieController = ChewieController(
        videoPlayerController: videoPlayerControler,
        autoInitialize: false,
        showControls: true,
        autoPlay: true);
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    videoPlayerControler.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: chewieController.videoPlayerController.value.isInitialized
          ? Chewie(controller: chewieController)
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
