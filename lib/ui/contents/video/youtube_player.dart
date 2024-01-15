import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pod_player/pod_player.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerApp extends StatefulWidget {
  final String url;

  const YoutubePlayerApp({Key? key, required this.url}) : super(key: key);

  @override
  State<StatefulWidget> createState() => YoutubePlayerAppState();
}

class YoutubePlayerAppState extends State<YoutubePlayerApp> {
  late final PodPlayerController controller;

  @override
  void initState() {
    controller = PodPlayerController(
        playVideoFrom: PlayVideoFrom.youtube(widget.url),
        podPlayerConfig: const PodPlayerConfig(
          autoPlay: true,
          forcedVideoFocus: true,
        ))
      ..initialise();
    controller.enableFullScreen();
    controller.toggleVolume();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
      if (orientation == Orientation.landscape) {
        return Scaffold(
          body: PodVideoPlayer(controller: controller),
        );
      } else {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xff263238),
            title: const Text("Kajian Islami"),
          ),
          body: PodVideoPlayer(controller: controller),
        );
      }
    });
  }
}

// class YoutubePlayerAppState extends State<YoutubePlayerApp> {
//   @override
//   void dispose() {
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//     ]);
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return OrientationBuilder(
//         builder: (BuildContext context, Orientation orientation) {
//       if (orientation == Orientation.landscape) {
//         return Scaffold(
//           body: youtubeHierarchy(),
//         );
//       } else {
//         return Scaffold(
//           appBar: AppBar(
//             backgroundColor: const Color(0xff263238),
//             title: const Text("Kajian Islami"),
//           ),
//           body: youtubeHierarchy(),
//         );
//       }
//     });
//   }
//
//   youtubeHierarchy() {
//     YoutubePlayerController controller = YoutubePlayerController(
//       initialVideoId: widget.url.split("https://www.youtube.com/watch?v=")[1],
//       flags: const YoutubePlayerFlags(
//         autoPlay: true,
//         mute: false,
//         controlsVisibleAtStart: true,
//         hideThumbnail: true,
//         hideControls: false,
//       ),
//     );
//
//     return Align(
//       alignment: Alignment.center,
//       child: FittedBox(
//         fit: BoxFit.fill,
//         child: YoutubePlayer(
//           controller: controller,
//           showVideoProgressIndicator: true,
//           progressIndicatorColor: Colors.cyanAccent,
//           onReady: () {
//             setState(() {
//               Timer(const Duration(milliseconds: 100), () {
//                 controller.toggleFullScreenMode();
//               });
//             });
//           },
//         ),
//       ),
//     );
//   }
// }
