import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:flutter/material.dart';
import 'package:quran/config/constant.dart';
import 'package:quran/model/db/youtube/channel_model.dart';
import 'package:quran/model/db/youtube/playlist_populer_model.dart';
import 'package:quran/ui/services/quran_service.dart';
import 'package:quran/ui/widgets/reading_card_list.dart';

import 'details_screen.dart';

class KajianVideo extends StatelessWidget {
  const KajianVideo({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    var channels = FutureBuilder<List<PlaylistPopularModel>>(
      future: QuranServices.getPlaylistPopuler(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.stackTrace.toString());
          return Container();
        } else if (snapshot.hasData) {
          var channel = snapshot.requireData;

          return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: AnimationLimiter(
                child: Row(
                    children: List.generate(
                  channel.length,
                  (index) {
                    return AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 1500),
                      columnCount: channel.length,
                      child: ScaleAnimation(
                        child: FadeInAnimation(
                          child: (channel[index].id! == channel.last.id!)
                              ? Row(
                                  children: [
                                    ReadingListCard(
                                      image: channel[index].photo!,
                                      title: channel[index].name!,
                                      rating: 4.9,
                                      totalPlaylist:
                                          channel[index].playlists!.length,
                                      channelId: channel[index].id!,
                                    ),
                                    const SizedBox(width: 20),
                                  ],
                                )
                              : ReadingListCard(
                                  image: channel[index].photo!,
                                  title: channel[index].name!,
                                  rating: 4.9,
                                  totalPlaylist:
                                      channel[index].playlists!.length,
                                  channelId: channel[index].id!,
                                ),
                        ),
                      ),
                    );
                  },
                )),
              ));
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
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bg.png"),
                  alignment: Alignment.topCenter,
                  fit: BoxFit.fitWidth,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: size.height * .1),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.headlineSmall,
                        children: const [
                          TextSpan(text: "Kajian Ustadz "),
                          TextSpan(
                              text: "Populer",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ))
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  channels,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.headlineSmall,
                            children: const [
                              TextSpan(text: "Daftar "),
                              TextSpan(
                                text: "Kajian",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        bestOfTheDayCard(size, context),
                        const SizedBox(height: 40),
                      ],
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

  FutureBuilder<List<ChannelModel>> bestOfTheDayCard(
      Size size, BuildContext context) {
    return FutureBuilder<List<ChannelModel>>(
      future: QuranServices.getChannels(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.stackTrace.toString());
          return Container();
        } else if (snapshot.hasData) {
          var channel = snapshot.requireData;

          return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: AnimationLimiter(
                child: Column(
                    children: List.generate(
                  channel.length,
                  (index) {
                    return AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 1500),
                      columnCount: channel.length,
                      child: SlideAnimation(
                        child: FadeInAnimation(
                            child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          width: double.infinity,
                          height: channel[index].playlists!.isEmpty ? 150 : 190,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(29)),
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  padding: EdgeInsets.only(
                                    left: 24,
                                    top: channel[index].playlists!.isEmpty
                                        ? 65
                                        : 24,
                                    right: size.width * .35,
                                  ),
                                  height: 190,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEAEAEA)
                                        .withOpacity(.45),
                                    borderRadius: BorderRadius.circular(29),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        channel[index].name!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                      Text(
                                        channel[index].playlists!.isEmpty
                                            ? 'Belum Ada Kajian'
                                            : 'Ada ${channel[index].playlists!.length} kajian',
                                        style: const TextStyle(
                                            color: kLightBlackColor),
                                      ),
                                      channel[index].favorite == 'yes'
                                          ? const Icon(Icons.favorite,
                                              color: Colors.red)
                                          : const Icon(Icons.favorite_border,
                                              color: Colors.blueGrey)
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Image.network(
                                  channel[index].photo!,
                                  width: size.width * .37,
                                ),
                              ),
                              channel[index].playlists!.isEmpty
                                  ? const Center()
                                  : Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: SizedBox(
                                        height: 40,
                                        width: size.width * .7,
                                        child: GestureDetector(
                                          child: Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            decoration: const BoxDecoration(
                                              color: kBlackColor,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(29),
                                                bottomRight:
                                                    Radius.circular(29),
                                              ),
                                            ),
                                            child: const Text(
                                              'Tonton',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return DetailsScreen(
                                                      channelId:
                                                          channel[index].id!);
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        )),
                      ),
                    );
                  },
                )),
              ));
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
