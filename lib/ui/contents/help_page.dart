import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quran/config/constant.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<StatefulWidget> createState() => HelpPageState();
}

class HelpPageState extends State<HelpPage> {
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
                        color: Colors.blue, offset: Offset(0, 5), blurRadius: 10)
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
                    Icons.live_help_outlined,
                    size: 100,
                    color: Colors.blue,
                  ),
                  Text(
                    'BANTUAN',
                    style: TextStyle(
                        color: Colors.blue.shade800,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                              color: Colors.blue,
                              offset: Offset(0, 0.75),
                              blurRadius: 2),
                        ]),
                  )
                ],
              ),
            ),
            SizedBox(
              height: size.height - 265,
              child: ListView(
                children: [
                  Container(
                    transform: Matrix4.translationValues(0, -60, 0),
                    height: 300,
                    width: size.width - 40,
                    margin: const EdgeInsets.all(30),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.blue,
                              offset: Offset(0, 0),
                              blurRadius: 2)
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Yasin dan Doa',
                            style: TextStyle(
                              color: Colors.blue.shade800,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                        const Divider(),
                        SizedBox(
                          height: 240,
                          child: ListView(
                            children: [
                              ///Kiblat
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Kiblat',
                                        style: TextStyle(
                                          color: Colors.blue.shade800,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Row(
                                      children: [
                                        Text('1. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text('Klik tombol kiblat',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text('2. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text(
                                              'Letakan HP ditempat yang datar',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text('3. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text(
                                              'Perhatikan gambar panah kabah',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text('4. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text(
                                              'Pastikan ijin lokasi diterima',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ]),
                              10.height,
                              ///Sholat
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Jadwal Sholat',
                                        style: TextStyle(
                                          color: Colors.blue.shade800,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('1. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text('Klik tombol Sholat',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('2. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text(
                                              'Tertera jadwal sholat sesuai tempat Anda tinggal',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('3. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text(
                                              'Teks berwarna merah menandakan waktu sholat akan datang',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('4. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text('Pastikan ijin lokasi diterima',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ]),
                              10.height,
                              ///Masjid
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Lokasi Masjid',
                                        style: TextStyle(
                                          color: Colors.blue.shade800,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('1. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text('Klik tombol Masjid',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('2. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text('Terlihat masjid yang disekitar Anda',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ]),
                              10.height,
                              ///Kajian
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Kajian',
                                        style: TextStyle(
                                          color: Colors.blue.shade800,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('1. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text('Klik tombol Kajian',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('2. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text(
                                              'Pilih ustadz yang tertera dalam layar kemudian klik tombol tonton',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('3. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text(
                                              'Terlihat materi kajian. Klik materi tersebut untuk menonton',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ]),
                              10.height,
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Surat Yasin dah Tahlil',
                                        style: TextStyle(
                                          color: Colors.blue.shade800,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('1. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text('Klik tombol yang tersedia, misalnya "Surat Yasin"',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('2. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text('Baca teks yang terlihat',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('3. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text('Jika ingin mengubah huruf besar/kecil, klik tombol titk 3 dipojok kanan atas, kemudian pilih Perbesar/perkecil huruf',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('4. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text('Jika ingin menampilkan latin/terjemahan, klik tombol titk 3 dipojok kanan atas, kemudian pilih sembuyikan/tampilkan terjemahan',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('5. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text('Jika ingin mengubah warna gelap/terang, klik tombol titk 3 dipojok kanan atas, kemudian pilih Tampilkan Gelap',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ]),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    transform: Matrix4.translationValues(0, -90, 0),
                    height: 300,
                    width: size.width - 40,
                    margin: const EdgeInsets.all(30),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.blue,
                              offset: Offset(0, 0),
                              blurRadius: 2)
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Sholat dan Sholawat',
                            style: TextStyle(
                              color: Colors.blue.shade800,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                        const Divider(),
                        SizedBox(
                          height: 240,
                          child: ListView(
                            children: [
                              ///Dzikir
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Dzikir Setelah Sholat Fardu',
                                        style: TextStyle(
                                          color: Colors.blue.shade800,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('1. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text('Klik tombol "Dzikir Setelah Sholat Fardu"',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('2. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text(
                                              'Baca atau dengarkan audio yang tersedia',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ]),
                              10.height,
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Sholawat',
                                        style: TextStyle(
                                          color: Colors.blue.shade800,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('1. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text('Klik tombol sholawat yang tersedia',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('2. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text('Baca teks yang terlihat',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('3. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text('Klil tombol play (>) untuk memainkan audi',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('4. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text('Jika ingin mengubah huruf besar/kecil, klik tombol titk 3 dipojok kanan atas, kemudian pilih Perbesar/perkecil huruf',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('5. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text('Jika ingin menampilkan latin/terjemahan, klik tombol titk 3 dipojok kanan atas, kemudian pilih sembuyikan/tampilkan terjemahan',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('6. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text('Jika ingin mengubah warna gelap/terang, klik tombol titk 3 dipojok kanan atas, kemudian pilih Tampilkan Gelap',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ]),
                              10.height,
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Tuntunan Sholat Lengkap',
                                        style: TextStyle(
                                          color: Colors.blue.shade800,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('1. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text('Klik tombol tuntunan sholat yang tersedia',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('2. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text('Baca teks yang terlihat',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('3. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text('Klil tombol play (>) untuk memainkan audi',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('4. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text('Jika ingin mengubah huruf besar/kecil, klik tombol titk 3 dipojok kanan atas, kemudian pilih Perbesar/perkecil huruf',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('5. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text('Jika ingin menampilkan latin/terjemahan, klik tombol titk 3 dipojok kanan atas, kemudian pilih sembuyikan/tampilkan terjemahan',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('6. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text('Jika ingin mengubah warna gelap/terang, klik tombol titk 3 dipojok kanan atas, kemudian pilih Tampilkan Gelap',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ]),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    transform: Matrix4.translationValues(0, -120, 0),
                    height: 300,
                    width: size.width - 40,
                    margin: const EdgeInsets.all(30),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.blue,
                              offset: Offset(0, 0),
                              blurRadius: 2)
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Juz 'Amma",
                            style: TextStyle(
                              color: Colors.blue.shade800,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                        const Divider(),
                        SizedBox(
                          height: 240,
                          child: ListView(
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Surat Al-Fatikhah (7 ayat)',
                                        style: TextStyle(
                                          color: Colors.blue.shade800,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('1. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text('Klik tombol "Surat Al-Fatikhah (7 ayat)"',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('2. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text(
                                              'Baca atau dengarkan audio yang tersedia',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ]),
                              10.height,
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Surat Pilihan',
                                        style: TextStyle(
                                          color: Colors.blue.shade800,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('1. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text('Klik tombol surat yang tersedia',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('2. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text('Baca teks yang terlihat',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('3. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text('Klil tombol play (>) untuk memainkan audi',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('4. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text('Jika ingin mengubah huruf besar/kecil, klik tombol titk 3 dipojok kanan atas, kemudian pilih Perbesar/perkecil huruf',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('5. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text('Jika ingin menampilkan latin/terjemahan, klik tombol titk 3 dipojok kanan atas, kemudian pilih sembuyikan/tampilkan terjemahan',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('6. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text('Jika ingin mengubah warna gelap/terang, klik tombol titk 3 dipojok kanan atas, kemudian pilih Tampilkan Gelap',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ]),
                              10.height,
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Juz 'Amma",
                                        style: TextStyle(
                                          color: Colors.blue.shade800,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('1. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text('Klik tombol surat yang tersedia',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('2. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text('Baca teks yang terlihat',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('3. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text('Klil tombol play (>) untuk memainkan audi',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('4. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text('Jika ingin mengubah huruf besar/kecil, klik tombol titk 3 dipojok kanan atas, kemudian pilih Perbesar/perkecil huruf',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('5. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text('Jika ingin menampilkan latin/terjemahan, klik tombol titk 3 dipojok kanan atas, kemudian pilih sembuyikan/tampilkan terjemahan',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('6. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text('Jika ingin mengubah warna gelap/terang, klik tombol titk 3 dipojok kanan atas, kemudian pilih Tampilkan Gelap',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ]),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    transform: Matrix4.translationValues(0, -150, 0),
                    height: 300,
                    width: size.width - 40,
                    margin: const EdgeInsets.all(30),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.blue,
                              offset: Offset(0, 0),
                              blurRadius: 2)
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Doa',
                            style: TextStyle(
                              color: Colors.blue.shade800,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                        const Divider(),
                        SizedBox(
                          height: 240,
                          child: ListView(
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Nadhom Asmaul Husna',
                                        style: TextStyle(
                                          color: Colors.blue.shade800,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('1. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text('Klik tombol "Nadhom Asmaul Husna"',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('2. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text(
                                              'Baca atau dengarkan audio yang tersedia',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ]),
                              10.height,
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Bacaan Bilal',
                                        style: TextStyle(
                                          color: Colors.blue.shade800,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('1. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text('Klik tombol bacaan bilal yang tersedia',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('2. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text('Baca teks yang terlihat',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('3. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text('Klil tombol play (>) untuk memainkan audi',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('4. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text('Jika ingin mengubah huruf besar/kecil, klik tombol titk 3 dipojok kanan atas, kemudian pilih Perbesar/perkecil huruf',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('5. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text('Jika ingin menampilkan latin/terjemahan, klik tombol titk 3 dipojok kanan atas, kemudian pilih sembuyikan/tampilkan terjemahan',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('6. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text('Jika ingin mengubah warna gelap/terang, klik tombol titk 3 dipojok kanan atas, kemudian pilih Tampilkan Gelap',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ]),
                              10.height,
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Kumpulan Doa',
                                        style: TextStyle(
                                          color: Colors.blue.shade800,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('1. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text('Klik tombol doa yang tersedia',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('2. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text('Baca teks yang terlihat',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('3. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text('Klil tombol play (>) untuk memainkan audi',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('4. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text('Jika ingin mengubah huruf besar/kecil, klik tombol titk 3 dipojok kanan atas, kemudian pilih Perbesar/perkecil huruf',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('5. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text('Jika ingin menampilkan latin/terjemahan, klik tombol titk 3 dipojok kanan atas, kemudian pilih sembuyikan/tampilkan terjemahan',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('6. ',
                                            style: TextStyle(
                                              color: Colors.blue.shade800,
                                              fontSize: 12,
                                            )),
                                        10.width,
                                        SizedBox(
                                          width: size.width - 105,
                                          child: Text('Jika ingin mengubah warna gelap/terang, klik tombol titk 3 dipojok kanan atas, kemudian pilih Tampilkan Gelap',
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontSize: 12,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ]),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),]
      ),
    );
  }
}
