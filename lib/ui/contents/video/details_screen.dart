import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quran/config/constant.dart';
import 'package:quran/model/db/youtube/banner_model.dart';
import 'package:quran/model/db/youtube/playlist_modal.dart';
import 'package:quran/ui/contents/video/youtube_player.dart';
import 'package:quran/ui/services/quran_service.dart';

class DetailsScreen extends StatelessWidget {
  final int channelId;

  const DetailsScreen({Key? key, required this.channelId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    var playlists = FutureBuilder<List<PlaylistModel>>(
      future: QuranServices.getPlaylists(channelId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.stackTrace.toString());
          return Container();
        } else if (snapshot.hasData) {
          var playlist = snapshot.requireData;

          return Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.only(
                      top: size.height * .12,
                      left: size.width * .1,
                      right: size.width * .02),
                  height: size.height * .48,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                  child: InfoChannel(
                    channelName: playlist[0].channelName!,
                    channelPhoto: playlist[0].channelPhoto!,
                    videoSize: playlist.length,
                    size: size,
                  )),
              Padding(
                padding: EdgeInsets.only(top: size.height * .48 - 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AnimationLimiter(
                      child: StaggeredGrid.count(
                          crossAxisCount: 1,
                          mainAxisSpacing: 0,
                          crossAxisSpacing: 0,
                          children: List.generate(playlist.length, (index) {
                            return AnimationConfiguration.staggeredGrid(
                                position: index,
                                duration: const Duration(milliseconds: 1500),
                                columnCount: playlist.length,
                                child: SlideAnimation(
                                  child: FadeInAnimation(
                                    child: ChapterCard(
                                      channelId: channelId,
                                      title: playlist[index].title!,
                                      channelName: playlist[index].channelName!,
                                      channelPhoto:
                                          playlist[index].channelPhoto!,
                                      press: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return YoutubePlayerApp(
                                                  url: playlist[index].link!);
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ));
                          })),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              )
            ],
          );
        } else {
          return Center(
            child: Column(
              children: [
                50.height,
                const Text("Tunggu, Sedang Terhubung ke Server"),
                const CircularProgressIndicator(),
                50.height,
              ],
            ),
          );
        }
      },
    );
    var banners = FutureBuilder<List<BannerModel>>(
      future: QuranServices.getBanners(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.stackTrace.toString());
          return Container();
        } else if (snapshot.hasData) {
          var b = snapshot.requireData;

          return Stack(
            children: <Widget>[
              const SizedBox(
                height: 180,
                width: double.infinity,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.only(left: 24, top: 24, right: 150),
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(b[0].photo!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            playlists,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.headline5,
                      children: const [
                        TextSpan(text: "Kamu tertarik "),
                        TextSpan(
                          text: "Video",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: " ini?"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  banners,
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class ChapterCard extends StatelessWidget {
  final int channelId;
  final String title;
  final String channelName;
  final String channelPhoto;
  final Function press;

  const ChapterCard({
    Key? key,
    required this.channelId,
    required this.title,
    required this.channelName,
    required this.channelPhoto,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            margin: const EdgeInsets.all(16),
            width: size.width - 48,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 10),
                  blurRadius: 33,
                  color: const Color(0xFFD3D3D3).withOpacity(.84),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 30),
                height: 100,
                child: Image.network(channelPhoto, fit: BoxFit.cover),
              ),
              // const Spacer(),
              Container(
                padding: const EdgeInsets.only(top: 30, right: 35),
                width: size.width - 150,
                child: Text(
                  title,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
          onTap: () {
            press();
          },
        ),
      ],
    );
  }
}

class InfoChannel extends StatelessWidget {
  final String channelName;
  final String channelPhoto;
  final int videoSize;
  final Size size;

  const InfoChannel({
    Key? key,
    required this.channelName,
    required this.channelPhoto,
    required this.videoSize,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flex(
      crossAxisAlignment: CrossAxisAlignment.start,
      direction: Axis.horizontal,
      children: <Widget>[
        Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: size.height * .005),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top: 0),
                  child: Text(
                    channelName,
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: size.width * .3,
                          padding: EdgeInsets.only(top: size.height * .02),
                          child: Text(
                            "$videoSize video tersedia\nSemoga meningkat iman kita kepada Allah SWT.",
                            maxLines: 5,
                            style: const TextStyle(
                                fontSize: 12, color: kLightBlackColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            )),
        Expanded(
            flex: 1,
            child: Container(
              color: Colors.transparent,
              child: Image.network(
                channelPhoto,
                height: double.infinity,
                alignment: Alignment.topRight,
                fit: BoxFit.fitWidth,
              ),
            )),
      ],
    );
  }
}
