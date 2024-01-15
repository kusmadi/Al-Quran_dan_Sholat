import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:share_plus/share_plus.dart';
import 'package:quran/config/constant.dart';

class SharePage extends StatefulWidget {
  const SharePage({super.key});

  @override
  State<StatefulWidget> createState() => SharePageState();
}

class SharePageState extends State<SharePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(children: [
        Positioned(
            top: 30,
            left: 0,
            child: Container(
              height: 120,
              width: size.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('$LOCAL_IMAGES_URL/top-bg.png'),
                      fit: BoxFit.fitWidth)),
            )),
        Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: 120,
              width: size.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('$LOCAL_IMAGES_URL/bottom-bg.png'),
                      fit: BoxFit.fitWidth)),
            )),
        Column(
          children: [
            Container(
              height: size.width / 2,
              width: size.width - 40,
              margin: const EdgeInsets.fromLTRB(20, 60, 20, 20),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.blue,
                        offset: Offset(0, 5),
                        blurRadius: 10)
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
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
                  const Icon(
                    Icons.share,
                    size: 100,
                    color: Colors.blue,
                  ),
                  Text(
                    'BAGIKAN APLIKASI',
                    style: TextStyle(
                        color: Colors.blue.shade800,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        shadows: const [
                          Shadow(
                              color: Colors.blue,
                              offset: Offset(0, 0.75),
                              blurRadius: 2),
                        ]),
                  )
                ],
              ),
            ),
            Container(
              width: size.width - 40,
              margin: const EdgeInsets.all(30),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      alignment: Alignment.center,
                      child: const Text(
                        'Klik Tombol "Bagikan" untuk berbagi ke $FOR_NAME',
                        textAlign: TextAlign.center,
                      )),
                  30.height,
                  ElevatedButton(
                      onPressed: () {
                        Share.share(kataShare + linkShare);
                      },
                      child: SizedBox(
                        width: 200,
                        height: 50,
                        child: Container(
                            alignment: Alignment.center,
                            child: const Text(
                              'Bagikan',
                              textAlign: TextAlign.center,
                            )),
                      ))
                ],
              ),
            )
          ],
        ),
      ]),
    );
  }
}
