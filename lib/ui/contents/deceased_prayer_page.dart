import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quran/config/constant.dart';
import 'package:quran/model/prayer_model.dart';
import 'package:quran/ui/services/quran_service.dart';

class DeceasedPrayerPage extends StatefulWidget {
  const DeceasedPrayerPage({super.key});

  @override
  State<StatefulWidget> createState() => DeceasedPrayerPageState();
}

class DeceasedPrayerPageState extends State<DeceasedPrayerPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 30,
              left: 0,
              child: Container(
                height: 120,
                width: size.width,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('$LOCAL_IMAGES_URL/top-bg.png'), fit: BoxFit.fitWidth)),
              )),
          Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                height: 120,
                width: size.width,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('$LOCAL_IMAGES_URL/bottom-bg.png'), fit: BoxFit.fitWidth)),
              )),
          Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 250,
              width: size.width - 20,
              margin: const EdgeInsets.fromLTRB(10, 50, 10, 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.blue.shade900,
                        offset: const Offset(0, 10),
                        blurRadius: 5)
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      child: const Icon(Icons.arrow_back),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  ClipOval(
                    child: Image.asset(
                      '$LOCAL_IMAGES_URL/logo.png',
                      width: 150,
                    ),
                  ),
                  20.height,
                  const Text(
                    'Doa Almarhum',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                              color: Colors.black,
                              offset: Offset(0.75, 0.75),
                              blurRadius: 2)
                        ]),
                  ),
                ],
              ),
            ),
            10.height,
            Container(
              margin: const EdgeInsets.all(10),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Orangtua dan Saudara',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                              color: Colors.black,
                              offset: Offset(0.75, 0.75),
                              blurRadius: 2)
                        ]),
                  ),
                  Text(
                    'Pengembang',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 14, shadows: [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(0.75, 0.75),
                          blurRadius: 2)
                    ]),
                  ),
                ],
              ),
            ),
            Container(
              width: size.width - 20,
              height: size.height - size.width - 25,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.blue.shade900,
                        offset: const Offset(0, 2),
                        blurRadius: 5)
                  ]),
              child: FutureBuilder<List<PrayerModel>>(
                future: QuranServices.getPrayer(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print(snapshot.stackTrace.toString());
                    return Center();
                  } else if (snapshot.hasData) {
                    var prayer = snapshot.requireData;
                    return ListView.builder(
                        itemCount: prayer.length,
                        itemBuilder: (BuildContext buildContext, int i) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 30,child: Text("${i + 1}. ")),
                              10.width,
                              Text(prayer[i].payerName!),
                            ],
                          );
                        });
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),]
      ),
    );
  }
}
