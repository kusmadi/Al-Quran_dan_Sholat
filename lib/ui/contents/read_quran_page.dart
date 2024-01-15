import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quran/config/constant.dart';
import 'package:quran/ui/db/interpreter_quran_ayat_model.dart';
import 'package:quran/ui/db/settings.dart';
import 'package:quran/ui/db/sqlite_setting.dart';
import 'package:quran/ui/services/quran_service.dart';
import 'package:quran/ui/widgets/arabic_number.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ReadQuranPage extends StatefulWidget {
  final String surahArabic;
  final String surahLatin;
  final String surahLocation;
  final String surahTranslate;
  final int surahJumAyah;
  final int suratId;
  final int ayatId;
  final String frameBg;
  final String openBg;

  const ReadQuranPage(
      {super.key,
      required this.surahArabic,
      required this.surahLatin,
      required this.surahLocation,
      required this.surahTranslate,
      required this.surahJumAyah,
      required this.suratId,
      required this.frameBg,
      required this.openBg,
      required this.ayatId});

  @override
  State<StatefulWidget> createState() => ReadQuranPageState();
}

class ReadQuranPageState extends State<ReadQuranPage>
    with TickerProviderStateMixin {
  late SqliteSetting db;
  bool boolTerjemahan = true;
  late int selectedAyah = 0;
  late int selectedAudioAyah = 1;
  late int ayatId = 0;
  bool isPlay = false;
  int bookmarkAyah = 0;

  late ItemScrollController _scrollController;
  late ItemPositionsListener _itemPositionsListener;
  late TabController controller;

  String selectedSound = 'Abdullah_Matroud_128kbps';
  List<SoundItems> soundItems = [
    SoundItems(mp3: 'Abdullah_Matroud_128kbps', text: 'Abdullah Matroud'),
    SoundItems(
        mp3: 'Abdul_Basit_Mujawwad_128kbps', text: 'Abdul Basit Mujawwad'),
    SoundItems(
        mp3: 'Abdurrahmaan_As-Sudais_192kbps', text: 'Abdurrahmaan As Sudais'),
    SoundItems(
        mp3: 'Abu Bakr Ash-Shaatree_128kbps', text: 'Abu Bakr Ash Shaatree'),
    SoundItems(mp3: 'Ahmed_Neana_128kbps', text: 'Ahmed Neana'),
    SoundItems(
        mp3: 'Ahmed_ibn_Ali_al-Ajamy_128kbps_ketaballah.net',
        text: 'Ahmed ibn Ali al Ajamy'),
    SoundItems(mp3: 'Akram_AlAlaqimy_128kbps', text: 'Akram AlAlaqimy'),
    SoundItems(mp3: 'Alafasy_128kbps', text: 'Abdullah Matroud'),
    SoundItems(mp3: 'Ali_Hajjaj_AlSuesy_128kbps', text: 'Ali Hajjaj AlSuesy'),
    SoundItems(mp3: 'Hani_Rifai_192kbps', text: 'Hani Rifai'),
    SoundItems(mp3: 'Hudhaify_128kbps', text: 'Hudhaify'),
    SoundItems(mp3: 'Husary_128kbps', text: 'Husary'),
    SoundItems(
        mp3: 'Khaalid_Abdullaah_al-Qahtaanee_192kbps',
        text: 'Khaalid Abdullaah al Qahtaanee'),
    SoundItems(
        mp3: 'Mohammad_al_Tablaway_128kbps', text: 'Mohammad al Tablaway'),
    SoundItems(
        mp3: 'Muhammad_AbdulKareem_128kbps', text: 'Muhammad AbdulKareem'),
    SoundItems(mp3: 'Muhammad_Ayyoub_128kbps', text: 'Muhammad Ayyoub'),
    SoundItems(mp3: 'Muhammad_Jibreel_128kbps', text: 'Muhammad Jibreel'),
    SoundItems(mp3: 'Muhsin_Al_Qasim_192kbps', text: 'Muhsin Al Qasim'),
    SoundItems(mp3: 'Nasser_Alqatami_128kbps', text: 'Nasser Alqatami'),
    SoundItems(
        mp3: 'Salaah_AbdulRahman_Bukhatir_128kbps',
        text: 'Salaah AbdulRahman Bukhatir'),
    SoundItems(mp3: 'Salah_Al_Budair_128kbps', text: 'Salah Al Budair'),
    SoundItems(
        mp3: 'Saood bin Ibraaheem Ash-Shuraym_128kbps',
        text: 'Saood bin Ibraaheem Ash Shuraym'),
    SoundItems(mp3: 'Saood_ash-Shuraym_128kbps', text: 'Saood ash Shuraym'),
    SoundItems(mp3: 'Yaser_Salamah_128kbps', text: 'Yaser Salamah'),
    SoundItems(mp3: 'Yasser_Ad-Dussary_128kbps', text: 'Yasser Ad Dussary'),
    SoundItems(
        mp3: 'ahmed_ibn_ali_al_ajamy_128kbps', text: 'ahmed ibn ali al ajamy'),
    SoundItems(mp3: 'aziz_alili_128kbps', text: 'aziz alili'),
  ];

  final player = AudioPlayer();
  int varJumAyah = 0;

  @override
  void initState() {
    ayatId = widget.suratId;
    bookmarkAyah = widget.ayatId;
    controller = TabController(vsync: this, length: 2);
    _scrollController = ItemScrollController();
    _itemPositionsListener = ItemPositionsListener.create();
    if (_scrollController.isAttached) {
      _scrollController.scrollTo(
          index: bookmarkAyah,
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOutCubic);
    }
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    var surat = FutureBuilder<List<InterpreterQuranAyatModel>>(
      future: QuranServices.getQuranPerSurat(ayatId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.stackTrace.toString());
          return const Center();
        } else if (snapshot.hasData) {
          var ayat = snapshot.requireData;
          varJumAyah = ayat.first.numAyah!;
          return Column(
            children: [
              Container(
                  height: 63,
                  width: size.width - 120,
                  margin: const EdgeInsets.only(top: 97),
                  child: Column(
                    children: [
                      RichText(
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        text: TextSpan(
                          style: const TextStyle(color: kBlackColor),
                          children: [
                            TextSpan(
                              text: ayat.first.surahName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 27,
                              ),
                            ),
                            TextSpan(
                              text: ' (${ayat.first.numAyah!.toArabicNumbers})',
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        transform: Matrix4.translationValues(0, -5, 0),
                        child: Text(
                          ayat.first.location!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  )),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 70),
                padding: const EdgeInsets.all(10),
                width: size.width - 30,
                height: size.height - 240,
                child: ScrollablePositionedList.builder(
                    itemScrollController: _scrollController,
                    itemCount: ayat.length,
                    itemBuilder: (context, i) {
                      return GestureDetector(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ayat[i].surahId == 1 || ayat[i].surahId == 9
                                ? const Center()
                                : ayat[i].ayah != 1
                                    ? const Center()
                                    : Center(
                                        child: Column(
                                          children: [
                                            Container(
                                              transform:
                                                  Matrix4.translationValues(
                                                      0, -15, 0),
                                              child: Image.asset(
                                                '$LOCAL_IMAGES_URL/quran/bismillah.png',
                                                height: 75,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                            boolTerjemahan
                                ? Column(
                                    children: [
                                      Container(
                                        width: size.width - 30,
                                        alignment: Alignment.centerRight,
                                        child: RichText(
                                          textAlign: TextAlign.right,
                                          textDirection: TextDirection.rtl,
                                          text: TextSpan(
                                            style: const TextStyle(
                                                color: kBlackColor),
                                            children: [
                                              TextSpan(
                                                text: ayat[i].arabic!,
                                                style: TextStyle(
                                                    color: ayat[i].ayah ==
                                                            selectedAyah
                                                        ? Colors.greenAccent
                                                        : Colors.white,
                                                    fontSize: 24,
                                                    fontFamily: 'IsepMisbah'),
                                              ),
                                              TextSpan(
                                                text:
                                                    ' ${ayat[i].ayah!.toArabicNumbers} ',
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    color: ayat[i].ayah ==
                                                            selectedAyah
                                                        ? Colors.greenAccent
                                                        : Colors.yellow,
                                                    fontFamily:
                                                        'UthmanicHafs1'),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: size.width - 30,
                                        child: Text(ayat[i].transliteration!,
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              color:
                                                  ayat[i].ayah == selectedAyah
                                                      ? Colors.greenAccent
                                                      : Colors.white,
                                            )),
                                      ),
                                      SizedBox(
                                        width: size.width - 30,
                                        child: Text(
                                          ayat[i].text!,
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                              color:
                                                  selectedAyah == ayat[i].ayah
                                                      ? Colors.greenAccent
                                                      : Colors.amber,
                                              fontSize: 14),
                                        ),
                                      ),
                                      15.height,
                                    ],
                                  )
                                : SizedBox(
                                    width: size.width - 30,
                                    child: RichText(
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                      text: TextSpan(
                                        style:
                                            const TextStyle(color: kBlackColor),
                                        children: [
                                          TextSpan(
                                            text: ayat[i].arabic!,
                                            style: TextStyle(
                                                color:
                                                    ayat[i].ayah == selectedAyah
                                                        ? Colors.greenAccent
                                                        : Colors.white,
                                                fontSize: 24,
                                                fontFamily: 'IsepMisbah'),
                                          ),
                                          TextSpan(
                                            text:
                                                ' ${ayat[i].ayah!.toArabicNumbers} ',
                                            style: TextStyle(
                                                color:
                                                    ayat[i].ayah == selectedAyah
                                                        ? Colors.greenAccent
                                                        : Colors.yellow,
                                                fontSize: 24,
                                                fontFamily: 'UthmanicHafs1'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            selectedAyah = ayat[i].ayah!;
                          });
                          showTafsir(ayat[i].tahlili, ayat[i].wajiz);
                        },
                        onLongPress: () {
                          setState(() {
                            selectedAyah = ayat[i].ayah!;
                          });
                          showSetting(context, ayat[i].surahId, ayat[i].ayah,
                              ayat[i].numAyah);
                        },
                      );
                    }),
              )
            ],
          );
        } else {
          return Center(
            child: Container(
              height: size.height,
              width: size.width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      "$LOCAL_IMAGES_URL/quran/pembuka/${widget.openBg}"),
                  alignment: Alignment.topCenter,
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.surahLocation,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white)),
                    Text(widget.surahArabic,
                        style:
                            const TextStyle(fontSize: 72, color: Colors.white)),
                    Text(widget.surahLatin,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white)),
                    Text('(${widget.surahJumAyah} Ayat)',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.white))
                  ]),
            ),
          );
        }
      },
    );

    return Scaffold(
      body: Stack(children: [
        Positioned(
            left: 0,
            top: 35,
            right: 0,
            bottom: 0,
            child: Image.asset(
              '$LOCAL_IMAGES_URL/quran/bg/${widget.frameBg}',
              fit: BoxFit.fill,
            )),
        Positioned(
            top: 100,
            left: 20,
            right: 20,
            child: SizedBox(
              height: 60,
              width: size.width - 120,
              child: Image.asset(
                '$LOCAL_IMAGES_URL/quran/title/1.png',
                fit: BoxFit.fill,
              ),
            )),
        Positioned(
            top: 36,
            child: SizedBox(
              height: 100,
              width: size.width,
              child: Image.asset(
                '$LOCAL_IMAGES_URL/quran/header.png',
                fit: BoxFit.fill,
              ),
            )),
        surat,
        Positioned(
          left: 20,
          right: 20,
          bottom: 25,
          child: Container(
            width: size.width - 100,
            height: 50,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.blue,
                      offset: Offset(0.75, 0.75),
                      blurRadius: 5)
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    child: Icon(
                      isPlay ? Icons.stop_circle_outlined : Icons.play_circle,
                      size: 30,
                    ),
                    onTap: () async {
                      setState(() {
                        isPlay = isPlay == true ? false : true;
                      });
                      if (ayatId != 1 && ayatId != 9) {
                        try {
                          await player.setAudioSource(AudioSource.uri(
                              Uri.parse('$GLOBAL_AUDIO_URL/bismillah.mp3')));
                        } catch (e) {
                          print("Error loading audio source: $e");
                        }
                        if (player.playing) {
                          player.stop();
                          player.dispose();
                        }
                        player.play();
                        player.playerStateStream.listen((state) async {
                          if (state.processingState ==
                              ProcessingState.completed) {
                            player.stop();
                            player.dispose();
                            playMurotal(selectedAudioAyah, varJumAyah);
                          }
                        });
                      } else {
                        setState(() {
                          selectedAyah = selectedAudioAyah;
                        });
                        playMurotal(selectedAudioAyah, varJumAyah);
                      }
                    }),
                DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: selectedSound,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: soundItems.map((SoundItems items) {
                      return DropdownMenuItem(
                        value: items.mp3,
                        child: SizedBox(
                            width: size.width / 2 - 10,
                            child: Text(items.text!,
                                overflow: TextOverflow.ellipsis)),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedSound = newValue!;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 60,
                  child: Row(
                    children: [
                      GestureDetector(
                        child: const Icon(
                          LineIcons.bookmark,
                          color: Colors.purple,
                          size: 30,
                        ),
                        onTap: () {
                          _scrollController.scrollTo(
                              index: bookmarkAyah,
                              duration: const Duration(seconds: 1),
                              curve: Curves.easeInOutCubic);
                        },
                      ),
                      GestureDetector(
                        child: Icon(
                          boolTerjemahan
                              ? LineIcons.eye_slash_1
                              : LineIcons.language,
                          color: Colors.purple,
                          size: 30,
                        ),
                        onTap: () {
                          if (boolTerjemahan == true) {
                            setState(() {
                              boolTerjemahan = false;
                            });
                          } else {
                            setState(() {
                              boolTerjemahan = true;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  void showTafsir(String? tahlili, String? wajiz) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext buildContext) {
          return Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                image: DecorationImage(
                    image: AssetImage('$LOCAL_IMAGES_URL/top-bg.png'),
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topLeft)),
            child: DefaultTabController(
              length: 2,
              initialIndex: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  36.height,
                  Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'TASFIR',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                                color: Colors.black,
                                offset: Offset(0, 0.75),
                                blurRadius: 3)
                          ]),
                    ),
                  ),
                  36.height,
                  TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    controller: controller,
                    tabs: const <Widget>[
                      Tab(
                        icon: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Icon(Icons.translate), Text('Tahlili')],
                        ),
                      ),
                      Tab(
                          icon: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                            Icon(Icons.translate),
                            Text('Wajiz')
                          ])),
                    ],
                  ),
                  Container(
                    height: 282,
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Colors.grey, width: 0.5))),
                    child: TabBarView(
                        controller: controller,
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Text(tahlili!,
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                      fontFamily: 'IsepMisbah'))),
                          SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Text(wajiz!,
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                      fontFamily: 'IsepMisbah')))
                        ]),
                  ),
                ],
              ),
            ),
          );
        }).then((value) {
      setState(() {
        selectedAyah = 0;
      });
    });
  }

  void showSetting(buildContext, int? surahId, int? ayahId, int? jumAyah) {
    var size = MediaQuery.of(context).size;
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Container(
                alignment: Alignment.center, child: const Text(APP_NAME)),
            content: Container(
              width: size.width - 20,
              height: 100,
              margin: const EdgeInsets.all(0),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Apa yang dikendaki?'),
                  Text('A. Simpan ayat terakhir dibaca?'),
                  Text('B. Mainkan Murotal?')
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.red),
                      foregroundColor: MaterialStatePropertyAll(Colors.white)),
                  child: const Text('Tutup')),
              ElevatedButton(
                  onPressed: () {
                    db = SqliteSetting();
                    db.initializeDB().whenComplete(() async {
                      List<SettingFrame> dbSetting =
                          await db.retrieveSettings();

                      if (dbSetting.isNotEmpty) {
                        List<SettingFrame> setting = [
                          SettingFrame(
                              id: dbSetting.first.id!,
                              frame: dbSetting.first.frame,
                              suratId: surahId,
                              ayatId: ayahId)
                        ];
                        db.updateSetting(setting, dbSetting.first.id!);
                      } else {
                        List<SettingFrame> setting = [
                          SettingFrame(
                              id: dbSetting.first.id!,
                              frame: dbSetting.first.frame,
                              suratId: surahId,
                              ayatId: ayahId)
                        ];
                        db.insertSetting(setting);
                      }
                      setState(() {
                        bookmarkAyah = ayahId!;
                      });
                      Fluttertoast.showToast(
                          msg: '"Ayat Terahkir" dibaca berhasil disimpan');
                      Navigator.pop(buildContext);
                    });
                  },
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.purple),
                      foregroundColor: MaterialStatePropertyAll(Colors.white)),
                  child: const Text('Simpan')),
              ElevatedButton(
                  onPressed: () async {
                    setState(() async {
                      if (isPlay == true) {
                        isPlay = false;
                        player.stop();
                        player.dispose();
                      } else {
                        isPlay = true;
                        if (surahId == 1 || surahId == 9) {
                          try {
                            await player.setAudioSource(AudioSource.uri(
                                Uri.parse('$GLOBAL_AUDIO_URL/bismillah.mp3')));
                          } catch (e) {
                            print("Error loading audio source: $e");
                          }
                          if (player.playing) {
                            player.stop();
                            player.dispose();
                          }
                          player.play();
                          player.playerStateStream.listen((state) {
                            if (state.processingState ==
                                ProcessingState.completed) {
                              AudioPlayer.clearAssetCache();
                              player.stop();
                              player.dispose();
                              playMurotal(ayahId, jumAyah);
                            }
                          });
                        } else {
                          setState(() {
                            selectedAyah = ayahId!;
                          });
                          playMurotal(ayahId, jumAyah);
                        }
                      }
                    });
                    Navigator.pop(context);
                  },
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.green),
                      foregroundColor: MaterialStatePropertyAll(Colors.white)),
                  child: const Text('Murotal')),
            ],
          );
        }).then((value) {
      setState(() {
        selectedAyah = 0;
        selectedAudioAyah = ayahId!;
      });
    });
  }

  playMurotal(int? ayahId, int? jumAyah) async {
    String surahMp3 = ayatId < 10 ? '00$ayatId' : '0$ayatId';
    String ayahMp3 = ayahId! < 10 ? '00$ayahId' : '0$ayahId';
    if (ayatId > 99) {
      surahMp3 = ayatId.toString();
    }
    if (ayahId > 99) {
      ayahMp3 = ayahId.toString();
    }
    String urlMp3 = '';
    setState(() {
      urlMp3 = '$GLOBAL_AUDIO_URL/$selectedSound/$surahMp3$ayahMp3.mp3';
    });

    try {
      await player.setAudioSource(AudioSource.uri(Uri.parse(urlMp3)));
    } on PlayerException catch (e) {
      Fluttertoast.showToast(msg: 'Murotal sudah selesai').then((value) {
        setState(() {
          isPlay = false;
          ayatId++;
          ayahId = 0;
          selectedAyah = 0;
          selectedAudioAyah = 1;
        });
        _scrollController.scrollTo(
            index: ayahId!,
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOutCubic);

        playMurotal(ayahId, jumAyah);
      });
    } on PlayerInterruptedException catch (e) {
      setState(() {
        isPlay = false;
      });
      print("Connection aborted: ${e.message}");
    }

    player.play();
    setState(() {
      isPlay = true;
    });
    player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        setState(() {
          isPlay = false;
          ayahId = ayahId! + 1;
          selectedAyah = ayahId!;
        });
        AudioPlayer.clearAssetCache();
        _scrollController.scrollTo(
            index: ayahId! - 1,
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOutCubic);
        playMurotal(ayahId, varJumAyah);
      }
    });
  }
}

class SoundItems {
  String? mp3;
  String? text;

  SoundItems({required this.mp3, required this.text});
}
