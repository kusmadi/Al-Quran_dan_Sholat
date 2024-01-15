import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quran/config/constant.dart';

class DeveloperPage extends StatefulWidget {
  const DeveloperPage({super.key});

  @override
  State<StatefulWidget> createState() => DeveloperPageState();
}

class DeveloperPageState extends State<DeveloperPage> {
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
              height: size.width,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: const Icon(Icons.arrow_back),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      GestureDetector(
                        child: const Icon(Icons.mail_outline),
                        onTap: () async {
                          final Email email = Email(
                            body: "Assalamu 'alaikum Mas Kusmadi\n\n",
                            subject: FOR_NAME,
                            recipients: ['mr.kusmadi@gmail.com'],
                            isHTML: false,
                          );

                          await FlutterEmailSender.send(email);
                        },
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(150),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.blue.shade900,
                              offset: const Offset(0, 0.75),
                              blurRadius: 2)
                        ]),
                    child: ClipOval(
                      child: Image.asset(
                        '$LOCAL_IMAGES_URL/smilecodes.png',
                        width: 150,
                      ),
                    ),
                  ),
                  20.height,
                  const Text(
                    'SmileCodes\nTeknologi Indonesia',
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
                  10.height,
                  const Text(
                    'Software House',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 14, shadows: [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(0.75, 0.75),
                          blurRadius: 2)
                    ]),
                  ),
                  30.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black,
                                  offset: Offset(0, 0.25),
                                  blurRadius: 1)
                            ]),
                        child: const Text(
                          'Website',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              shadows: [
                                Shadow(
                                    color: Colors.black,
                                    offset: Offset(0.75, 0.75),
                                    blurRadius: 2)
                              ]),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black,
                                  offset: Offset(0, 0.25),
                                  blurRadius: 1)
                            ]),
                        child: const Text(
                          'Mobile',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              shadows: [
                                Shadow(
                                    color: Colors.black,
                                    offset: Offset(0.75, 0.75),
                                    blurRadius: 2)
                              ]),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black,
                                  offset: Offset(0, 0.25),
                                  blurRadius: 1)
                            ]),
                        child: const Text(
                          'Network',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              shadows: [
                                Shadow(
                                    color: Colors.black,
                                    offset: Offset(0.75, 0.75),
                                    blurRadius: 2)
                              ]),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black,
                                  offset: Offset(0, 0.25),
                                  blurRadius: 1)
                            ]),
                        child: const Text(
                          'Training',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              shadows: [
                                Shadow(
                                    color: Colors.black,
                                    offset: Offset(0.75, 0.75),
                                    blurRadius: 2)
                              ]),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            10.height,
            Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Overview',
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
                    DateFormat('d MMM yyyy').format(DateTime.now()),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
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
            SizedBox(
              height: size.height - size.width - 120,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.blue.shade900,
                                offset: const Offset(0, 2),
                                blurRadius: 5)
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.blue.shade50,
                                      offset: const Offset(0, 0.5),
                                      blurRadius: 1)
                                ]),
                            child: const Icon(Icons.book,
                                color: SOFT_BLUE, size: 30),
                          ),
                          10.width,
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Yasin dan Tahlil',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                          color: Colors.black,
                                          offset: Offset(0.75, 0.75),
                                          blurRadius: 2)
                                    ]),
                              ),
                              Text(
                                'Arah Kiblat, Jadwal Sholat, Masjid Terdekat dan Kajian',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    shadows: [
                                      Shadow(
                                          color: Colors.black,
                                          offset: Offset(0.75, 0.75),
                                          blurRadius: 2)
                                    ]),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.blue.shade900,
                                offset: const Offset(0, 2),
                                blurRadius: 5)
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.blue.shade50,
                                      offset: const Offset(0, 0.5),
                                      blurRadius: 1)
                                ]),
                            child: const Icon(Icons.book,
                                color: SOFT_BLUE, size: 30),
                          ),
                          10.width,
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tata Cara Sholat',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                          color: Colors.black,
                                          offset: Offset(0.75, 0.75),
                                          blurRadius: 2)
                                    ]),
                              ),
                              Text(
                                'Dzikir Sholat Fardu, Sholawat, Sholat Sunah',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    shadows: [
                                      Shadow(
                                          color: Colors.black,
                                          offset: Offset(0.75, 0.75),
                                          blurRadius: 2)
                                    ]),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.blue.shade900,
                                offset: const Offset(0, 2),
                                blurRadius: 5)
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.blue.shade50,
                                      offset: const Offset(0, 0.5),
                                      blurRadius: 1)
                                ]),
                            child: const Icon(Icons.book,
                                color: SOFT_BLUE, size: 30),
                          ),
                          10.width,
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Juz 'Amma (Surat Juz 30)",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                          color: Colors.black,
                                          offset: Offset(0.75, 0.75),
                                          blurRadius: 2)
                                    ]),
                              ),
                              Text(
                                "Surat Pilihan, Surat Juz 30 dan Doa Khatam",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    shadows: [
                                      Shadow(
                                          color: Colors.black,
                                          offset: Offset(0.75, 0.75),
                                          blurRadius: 2)
                                    ]),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.blue.shade900,
                                offset: const Offset(0, 2),
                                blurRadius: 5)
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.blue.shade50,
                                      offset: const Offset(0, 0.5),
                                      blurRadius: 1)
                                ]),
                            child: const Icon(Icons.book,
                                color: SOFT_BLUE, size: 30),
                          ),
                          10.width,
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Doa Penting Umat Islam',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                          color: Colors.black,
                                          offset: Offset(0.75, 0.75),
                                          blurRadius: 2)
                                    ]),
                              ),
                              Text(
                                "Nadhom Asmaul Husna, Bacaan Bilal dan Doa",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    shadows: [
                                      Shadow(
                                          color: Colors.black,
                                          offset: Offset(0.75, 0.75),
                                          blurRadius: 2)
                                    ]),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.blue.shade900,
                                offset: const Offset(0, 2),
                                blurRadius: 5)
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.blue.shade50,
                                      offset: const Offset(0, 0.5),
                                      blurRadius: 1)
                                ]),
                            child: const Icon(Icons.book,
                                color: SOFT_BLUE, size: 30),
                          ),
                          10.width,
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                FOR_NAME,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                          color: Colors.black,
                                          offset: Offset(0.75, 0.75),
                                          blurRadius: 2)
                                    ]),
                              ),
                              Text(
                                "Sistem Informasi $FOR_NAME",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    shadows: [
                                      Shadow(
                                          color: Colors.black,
                                          offset: Offset(0.75, 0.75),
                                          blurRadius: 2)
                                    ]),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),]
      ),
    );
  }
}
