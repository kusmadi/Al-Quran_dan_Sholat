import 'package:carousel_slider/carousel_slider.dart';
import 'package:drop_shadow_image/drop_shadow_image.dart';
import 'package:flutter/material.dart';
import 'package:quran/model/db/youtube/banner_model.dart';
import 'package:quran/ui/contents/video/youtube_player.dart';

class BannerList extends StatefulWidget {
  final List<BannerModel> list;

  const BannerList({super.key, required this.list});

  @override
  State<BannerList> createState() => _BannerListState();
}

class _BannerListState extends State<BannerList> {
  int index = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      transform: Matrix4.translationValues(0.0, -30.0, 0.0),
      // padding: const EdgeInsets.only(left: 10,right: 10),
      child: CarouselSlider(
        items: widget.list
            .map((item) => GestureDetector(
                  child: DropShadowImage(
                    offset: const Offset(0.7, 0.7),
                    scale: 1,
                    blurRadius: 0.3,
                    borderRadius: 5,
                    image: Image.network(item.photo!,
                        width: MediaQuery.of(context).size.width),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              YoutubePlayerApp(url: item.url!),
                        ));
                  },
                ))
            .toList(),
        options: CarouselOptions(
            aspectRatio: 3,
            viewportFraction: 0.7,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 6),
            autoPlayAnimationDuration: const Duration(milliseconds: 300),
            enlargeCenterPage: true,
            clipBehavior: Clip.antiAlias,
            onPageChanged: (index, reason) {
              setState(() {});
            }),
      ),
    );
  }
}
