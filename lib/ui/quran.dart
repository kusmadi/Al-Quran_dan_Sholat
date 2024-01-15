import 'dart:math' as math;

import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quran/config/constant.dart';
import 'package:quran/main.dart';
import 'package:quran/model/drawer_model.dart';
import 'package:quran/reference/utils/AppColors.dart';
import 'package:quran/ui/contents/jadwalsholat/detail_jadwal.dart';
import 'package:quran/ui/contents/jadwalsholat/prayer_times.dart';
import 'package:quran/ui/contents/masjid_page.dart';
import 'package:quran/ui/contents/qiblat/loading_indicator.dart';
import 'package:quran/ui/contents/qiblat/qiblah_compass.dart';
import 'package:quran/ui/contents/qiblat/qiblah_maps.dart';
import 'package:quran/ui/contents/quran_page.dart';
import 'package:quran/ui/contents/read_quran_page.dart';
import 'package:quran/ui/contents/video/kajian_video.dart';
import 'package:quran/ui/db/quran_surat_model.dart';
import 'package:quran/ui/db/settings.dart';
import 'package:quran/ui/db/sqlite_setting.dart';
import 'package:quran/ui/services/quran_service.dart';

class MainQuranPage extends StatefulWidget {
  const MainQuranPage({super.key});

  @override
  State<MainQuranPage> createState() => _MainQuranPageState();
}

class _MainQuranPageState extends State<MainQuranPage> {
  final _deviceSupport = FlutterQiblah.androidDeviceSensorSupport();
  double expandHeight = 290;

  //gps
  late Position position;
  late double long = 0, lat = 0;
  late GoogleMapController mapController;
  LatLng? _currentPosition;
  bool _isLoading = true;
  String? _currentAddress;
  String? _currentArea;

  //DRAWER
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  double angle = 0;

  bool d1Open = false;

  late int isSelected = 0;

  closeDrawer() {
    xOffset = 0;
    yOffset = 0;
    angle = 0;
    scaleFactor = 1;
    d1Open = false;
  }

  openDrawer() {
    xOffset = 200;
    yOffset = 80;
    scaleFactor = 0.8;
    angle = 6.18;
    d1Open = true;
    setStatusBarColor(const Color(0xFF6A66BB));
    setState(() {});
  }

  setStateX() {
    setState(() {});
  }
  //end of drawer

  @override
  void initState() {
    _determinePosition().then((position) {
      lat = position.latitude;
      long = position.longitude;
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialApp(
        home: AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              statusBarColor: Color(0xff263238),
              systemNavigationBarColor: Colors.white,
              statusBarIconBrightness: Brightness.light,
              systemNavigationBarIconBrightness: Brightness.light,
            ),
            child: SafeArea(
              child: Scaffold(
                body: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image:
                              AssetImage("$LOCAL_IMAGES_URL/background.jpeg"),
                          alignment: Alignment.topCenter,
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              40.height,
                              Image.asset("$LOCAL_IMAGES_URL/logo.png",
                                  width: 146),
                              8.height,
                              Text(APP_NAME,
                                  style: boldTextStyle(
                                      color: Colors.white, size: 20)),
                            ],
                          ).paddingLeft(16),
                          40.height,
                          Column(
                            children: [
                              ...List.generate(
                                drawerModelData.length,
                                (index) {
                                  return SettingItemWidget(
                                    title:
                                        drawerModelData[index].title.validate(),
                                    decoration: BoxDecoration(
                                        color: isSelected == index
                                            ? Colors
                                                .pinkAccent //const Color(0xFF513AAF)
                                            : Colors.transparent),
                                    titleTextStyle:
                                        primaryTextStyle(color: Colors.white),
                                    leading: Icon(
                                      drawerModelData[index].icon,
                                      color: Colors.white,
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  drawerModelData[index]
                                                      .launchWidget));
                                      isSelected = index;
                                      closeDrawer();
                                      setState(() {});
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        closeDrawer();
                        setState(() {});
                      },
                      onPanUpdate: (d) {
                        closeDrawer();
                        setState(() {});
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: boxDecorationDefault(
                          color: context.scaffoldBackgroundColor,
                          borderRadius: d1Open ? radius(16) : radius(0),
                        ),
                        transform:
                            Matrix4.translationValues(xOffset, yOffset, 0)
                              ..scale(scaleFactor)
                              ..rotateZ(angle),

                        ///MainPage
                        child: SizedBox(
                          height: size.height,
                          child: CustomScrollView(
                            slivers: [
                              SliverPersistentHeader(
                                delegate: CustomSliverAppBarDelegate(
                                    expandedHeight: expandHeight,
                                    isOpen: d1Open,
                                    context: setStateX,
                                    closeDrawer: closeDrawer,
                                    openDrawer: openDrawer,
                                    buildContext: context,
                                    latLng: LatLng(lat, long)),
                                pinned: false,
                              ),
                              SliverList(
                                delegate: SliverChildListDelegate(
                                  [
                                    40.height,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            await showQiblat(context);
                                          },
                                          child: Card(
                                            elevation: 5,
                                            margin: const EdgeInsets.all(5),
                                            color: Colors.white,
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons
                                                        .compass_calibration),
                                                    10.height,
                                                    Text('Arah Kiblat')
                                                  ]),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            await showJadwalSholat(
                                                context, _currentArea);
                                          },
                                          child: Card(
                                            elevation: 5,
                                            margin: const EdgeInsets.all(5),
                                            color: Colors.white,
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.schedule),
                                                    10.height,
                                                    Text('Jadwal')
                                                  ]),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (ctx) => MasjidPage(
                                                        latitude: lat,
                                                        longitude: long,
                                                        address:
                                                            _currentAddress!)));
                                          },
                                          child: Card(
                                            elevation: 5,
                                            margin: const EdgeInsets.all(5),
                                            color: Colors.white,
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.mosque),
                                                    10.height,
                                                    Text('Masjid')
                                                  ]),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (ctx) =>
                                                        KajianVideo()));
                                          },
                                          child: Card(
                                            elevation: 5,
                                            margin: const EdgeInsets.all(5),
                                            color: Colors.white,
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                        Icons.video_collection),
                                                    10.height,
                                                    Text('Kajian')
                                                  ]),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    _suratQuran(),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),

                        ///End Of Main Page
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }

  _suratQuran() {
    var size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.all(10),
      child: FutureBuilder<List<QuranSuratModel>>(
        future: QuranServices.getQuranAllSurat(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.stackTrace.toString());
            return Container();
          } else if (snapshot.hasData) {
            var surat = snapshot.requireData;
            return AnimationLimiter(
              child: SizedBox(
                  height: surat.length * 70,
                  child: ListView.builder(
                      itemCount: surat.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (ctx, i) {
                        return AnimationConfiguration.staggeredGrid(
                            position: i,
                            duration: const Duration(milliseconds: 1500),
                            columnCount: surat.length,
                            child: ScaleAnimation(
                              child: FadeInAnimation(
                                child: Container(
                                  width: size.width / 2 - 30,
                                  height: 60,
                                  margin: const EdgeInsets.fromLTRB(5, 1, 5, 9),
                                  padding:
                                      const EdgeInsets.only(bottom: 3, top: 3),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: radius(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.shade400,
                                            offset: const Offset(0, 2),
                                            blurRadius: 3)
                                      ]),
                                  child: GestureDetector(
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 6, 10, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                transform:
                                                    Matrix4.translationValues(
                                                        0, -5, 0),
                                                child: Text(
                                                  surat[i].arabic!,
                                                  style: const TextStyle(
                                                      color: Colors.purple,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                      fontFamily: 'IsepMisbah'),
                                                ),
                                              ),
                                              Container(
                                                transform:
                                                    Matrix4.translationValues(
                                                        0, -10, 0),
                                                child: Text(
                                                  "  ${surat[i].location!}",
                                                  style: const TextStyle(
                                                      color: Colors.brown,
                                                      fontSize: 12),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "${surat[i].surahName!} (${surat[i].numAyah!} ayat)",
                                                style: const TextStyle(
                                                    color: Colors.purple,
                                                    fontSize: 14,
                                                    fontFamily: 'IsepMisbah'),
                                              ),
                                              SizedBox(
                                                width: size.width / 2,
                                                child: Text(
                                                  surat[i].translate!,
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                      color: Colors.brown,
                                                      fontSize: surat[i]
                                                                  .translate!
                                                                  .length >
                                                              15
                                                          ? 8
                                                          : 12),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      SqliteSetting db = SqliteSetting();
                                      db.initializeDB().whenComplete(() async {
                                        List<SettingFrame> dbSetting =
                                            await db.retrieveSettings();

                                        if (dbSetting.isEmpty) {
                                          db.insertSetting([
                                            SettingFrame(
                                                id: 1,
                                                frame: '15.jpeg',
                                                openbg: 'purple.jpeg',
                                                suratId: surat[i].rowid,
                                                ayatId: 1)
                                          ]);
                                        } else {
                                          db.updateSetting([
                                            SettingFrame(
                                                id: 1,
                                                frame: dbSetting.first.frame,
                                                openbg: dbSetting.first.openbg,
                                                suratId: surat[i].rowid,
                                                ayatId: dbSetting.first.ayatId)
                                          ], dbSetting.first.id!);
                                        }
                                        List<SettingFrame> s =
                                            await db.retrieveSettings();

                                        navKey.currentState?.push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ReadQuranPage(
                                                      surahJumAyah:
                                                          surat[i].numAyah!,
                                                      surahArabic:
                                                          surat[i].arabic!,
                                                      surahLatin:
                                                          surat[i].surahName!,
                                                      surahLocation:
                                                          surat[i].location!,
                                                      surahTranslate:
                                                          surat[i].translate!,
                                                      suratId: s.first.suratId!,
                                                      ayatId: s.first.ayatId!,
                                                      frameBg: s.first.frame!,
                                                      openBg: s.first.openbg!,
                                                    )));
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ));
                      })),
            );
          } else {
            return Center(
              child: Column(
                children: [
                  Image.asset('$LOCAL_IMAGES_URL/allah.png', width: 150),
                  5.height,
                  const SizedBox(
                    width: 130,
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.yellow,
                      color: Colors.blue,
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Future showQiblat(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Container(
            height: 480,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                  Colors.purple,
                  BlendMode.srcIn,
                ),
                image: AssetImage("$LOCAL_IMAGES_URL/top-bg.png"),
                alignment: Alignment.topCenter,
                fit: BoxFit.fitWidth,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: FutureBuilder(
              future: _deviceSupport,
              builder: (_, AsyncSnapshot<bool?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return LoadingIndicator();
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Error: ${snapshot.error.toString()}"),
                  );
                }

                if (snapshot.data!) {
                  return const QiblahCompass();
                } else {
                  return QiblahMaps();
                }
              },
            ),
          ),
        );
      },
    );
  }

  Future showJadwalSholat(BuildContext context, area) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Container(
            height: 530,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("$LOCAL_IMAGES_URL/top-bg.png"),
                alignment: Alignment.topCenter,
                fit: BoxFit.fitWidth,
                colorFilter: ColorFilter.mode(
                  Colors.purple,
                  BlendMode.srcIn,
                ),
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : DetailJadwal(lat: lat, long: long, area: area),
          ),
        );
      },
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    double latitude = position.latitude;
    double longitude = position.longitude;

    LatLng latLng = LatLng(latitude, longitude);

    setState(() {
      _currentPosition = latLng;
      _isLoading = false;
    });

    _getAddressFromLatLng(position);
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return position;
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street} ${place.subLocality}, ${place.subAdministrativeArea}';
        _currentArea = '${place.subLocality}, ${place.subAdministrativeArea}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }
}

class CustomSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  late bool isOpen;
  late int xOffset = 200;
  late int yOffset = 80;
  late double scaleFactor = 0.8;
  late double angle = 6.18;
  final Function() closeDrawer;
  final Function() openDrawer;
  final Function() context;
  final BuildContext buildContext;
  final LatLng latLng;

  CustomSliverAppBarDelegate({
    required this.expandedHeight,
    required this.isOpen,
    required this.context,
    required this.openDrawer,
    required this.closeDrawer,
    required this.buildContext,
    required this.latLng,
  });

  String hourBetween(String to) {
    var now = DateTime.now();
    int hour = to.split(":")[0].toInt();
    int minute = to.split(":")[1].toInt();
    var two = DateTime(now.year, now.month, now.day, hour, minute);

    return two.difference(now).toString().split(".")[0];
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    const size = 120;
    final top = expandedHeight - shrinkOffset - size / 0.5;
    final width = context.width();

    final myCoordinates = Coordinates(latLng.latitude, latLng.longitude);
    final params = CalculationMethod.karachi.getParameters();
    params.madhab = Madhab.hanafi;
    final prayerTimes = PrayerTimes.today(myCoordinates, params);

    List<String> _prayerTimes = [];
    List<String> _prayerNames = [];

    PrayerTime prayers = PrayerTime();
    prayers.setTimeFormat(prayers.getTime24());
    prayers.setCalcMethod(prayers.getMWL());
    prayers.setAsrJuristic(prayers.getShafii());
    prayers.setAdjustHighLats(prayers.getAdjustHighLats());

    List<int> offsets = [-6, 0, 3, 2, 0, 3, 6];

    var currentTime = DateTime.now();
    String strTimeZone = currentTime.timeZoneOffset.toString().split(":")[0];
    prayers.tune(offsets);

    _prayerTimes = prayers.getPrayerTimes(
        currentTime, latLng.latitude, latLng.longitude, strTimeZone.toDouble());
    _prayerNames = prayers.getTimeNames();
    int position = prayerTimes.currentPrayer().index;

    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        buildBackground(shrinkOffset, width),
        Positioned(
          top: 0,
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  isOpen ? Icons.arrow_back : Icons.menu,
                  size: 24,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (isOpen) {
                    closeDrawer();
                  } else {
                    xOffset = 200;
                    yOffset = 80;
                    scaleFactor = 0.8;
                    angle = 6.18;
                    openDrawer();
                    setStatusBarColor(const Color(0xff263238));
                  }
                  context;
                  // setState(() {});
                },
              ),
              8.width,
              Row(
                children: [
                  Column(
                    children: [
                      Text(_prayerNames[position],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          )),
                      Text(_prayerTimes[position],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                  20.width,
                  Column(
                    children: [
                      Text(_prayerNames[position == 6 ? 0 : ++position],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          )),
                      Text(_prayerTimes[position == 6 ? 0 : position],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                  20.width,
                  Column(
                    children: [
                      Text(_prayerNames[position == 6 ? 1 : ++position],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          )),
                      Text(_prayerTimes[position == 6 ? 1 : position],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: top,
          left: 16,
          right: 16,
          child: buildFloating(shrinkOffset),
        ),
      ],
    );
  }

  double appear(double shrinkOffset) => shrinkOffset / expandedHeight;

  double disappear(double shrinkOffset) => 1 - shrinkOffset / expandedHeight;

  Widget buildAppBar(double shrinkOffset) {
    return Opacity(
      opacity: appear(shrinkOffset),
      child: AppBar(
        title: const Text(APP_NAME),
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
    );
  }

  Widget buildBackground(double shrinkOffset, double width) {
    return Opacity(
      opacity: disappear(shrinkOffset),
      child: Stack(
        children: [
          Image.asset("$LOCAL_IMAGES_URL/quran.jpeg",
              width: width, fit: BoxFit.cover),
          Container(
            padding: const EdgeInsets.only(bottom: 16, top: 32),
            alignment: Alignment.topCenter,
            height: 278,
            decoration: boxDecorationWithRoundedCorners(
                borderRadius: radius(0),
                backgroundColor: appColorPrimary.withOpacity(0.3)),
          ),
        ],
      ),
    );
  }

  Widget buildFloating(double shrinkOffset) {
    return Opacity(
      opacity: disappear(shrinkOffset),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            transform: Matrix4.translationValues(115, 80, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Al Qur 'an",
                    style: boldTextStyle(size: 40, color: white)),
                SizedBox(
                  width: MediaQuery.of(buildContext).size.width / 2 + 50,
                  child: Text("Petunjuk Bagi Mereka yang Bertaqwa",
                      style: boldTextStyle(size: 16, color: white)),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  SqliteSetting db = SqliteSetting();
                  db.initializeDB().whenComplete(() async {
                    List<SettingFrame> dbSetting = await db.retrieveSettings();

                    if (dbSetting.isEmpty) {
                      db.insertSetting([
                        SettingFrame(
                            id: 1,
                            frame: '15.jpeg',
                            openbg: 'purple.jpeg',
                            suratId: 1,
                            ayatId: 1)
                      ]);
                    } else {
                      db.updateSetting([
                        SettingFrame(
                            id: 1,
                            frame: dbSetting.first.frame,
                            openbg: dbSetting.first.openbg,
                            suratId: dbSetting.first.suratId,
                            ayatId: dbSetting.first.ayatId)
                      ], dbSetting.first.id!);
                    }
                    List<SettingFrame> s = await db.retrieveSettings();
                    navKey.currentState?.push(MaterialPageRoute(
                        builder: (context) => QuranPage(
                              suratId: s.first.suratId!,
                              ayatId: s.first.ayatId!,
                              frameBg: s.first.frame!,
                              openBg: s.first.openbg!,
                            )));
                  });
                },
                child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(math.pi),
                    child: Image.asset('$LOCAL_IMAGES_URL/quran/quran.png',
                        width: 100)),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: boxDecorationWithShadow(
                    borderRadius: radius(10),
                    backgroundColor: white,
                    offset: const Offset(0, 5)),
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          buildContext,
                          MaterialPageRoute(
                              builder: (context) => const ChangeOpened()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image_search,
                          size: 42,
                          color: Colors.pink.shade800,
                        ),
                        8.height,
                        Text('Opening', style: secondaryTextStyle(size: 12)),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: boxDecorationWithShadow(
                    borderRadius: radius(10),
                    backgroundColor: white,
                    offset: const Offset(0, 5)),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        buildContext,
                        MaterialPageRoute(
                            builder: (context) => const ChangeSettings()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.imagesearch_roller,
                        size: 42,
                        color: Colors.pink.shade800,
                      ),
                      8.height,
                      Text('Frame', style: secondaryTextStyle(size: 12)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + 30;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

class ChangeSettings extends StatefulWidget {
  const ChangeSettings({super.key});

  @override
  State<ChangeSettings> createState() => _ChangeSettingsState();
}

class _ChangeSettingsState extends State<ChangeSettings> {
  List<FrameBackground> frame = [
    const FrameBackground('1.jpeg', '', 'Bingkai Quran 1'),
  ];

  @override
  void initState() {
    for (int a = 2; a < 35; a++) {
      frame.add(FrameBackground("$a.jpeg", '', "Bingkai Quran $a"));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return MaterialApp(
      home: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Stack(children: [
            Positioned(
                top: 36,
                left: 0,
                child: Image.asset(
                  '$LOCAL_IMAGES_URL/top-bg.png',
                  fit: BoxFit.fitWidth,
                )),
            Positioned(
                right: 0,
                bottom: 0,
                child: Image.asset(
                  '$LOCAL_IMAGES_URL/bottom-bg.png',
                  fit: BoxFit.fitWidth,
                )),
            Container(
              width: size.width,
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  60.height,
                  const Text(
                    'Bingkai Quran',
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                              color: Colors.black,
                              offset: Offset(0, 0),
                              blurRadius: 3)
                        ]),
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    'Pilih bingkai dengan meng-klik gambar',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                              color: Colors.black,
                              offset: Offset(0, 0),
                              blurRadius: 3)
                        ]),
                    textAlign: TextAlign.center,
                  ),
                  30.height,
                  SizedBox(
                    width: size.width - 20,
                    height: size.height - 150,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: AnimationLimiter(
                        child: StaggeredGrid.count(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 0,
                            children: List.generate(frame.length, (i) {
                              return AnimationConfiguration.staggeredGrid(
                                  position: i,
                                  duration: const Duration(milliseconds: 1500),
                                  columnCount: frame.length,
                                  child: ScaleAnimation(
                                    child: FadeInAnimation(
                                      child: Container(
                                        width: size.width / 2 - 10,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        padding:
                                            const EdgeInsets.only(bottom: 5),
                                        decoration: boxDecorationWithShadow(
                                            borderRadius: radius(10),
                                            backgroundColor: white,
                                            offset: const Offset(5, 5)),
                                        child: GestureDetector(
                                          onTap: () {
                                            saveToDb(frame[i]);
                                          },
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                '$LOCAL_IMAGES_URL/quran/bg/${frame[i].image}',
                                                width: size.width / 2 - 10,
                                                fit: BoxFit.cover,
                                              ).cornerRadiusWithClipRRectOnly(
                                                  topLeft: 12, bottomLeft: 12),
                                              Text(
                                                frame[i].title,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ));
                            })),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  saveToDb(FrameBackground frame) {
    SqliteSetting db = SqliteSetting();
    db.initializeDB().whenComplete(() async {
      List<SettingFrame> dbSetting = await db.retrieveSettings();

      if (dbSetting.isNotEmpty) {
        List<SettingFrame> setting = [
          SettingFrame(
              id: dbSetting.first.id!,
              frame: frame.image,
              openbg: dbSetting.first.openbg,
              suratId: dbSetting.first.suratId,
              ayatId: dbSetting.first.ayatId)
        ];
        db.updateSetting(setting, dbSetting.first.id!);
      } else {
        List<SettingFrame> setting = [
          SettingFrame(
              id: 1,
              frame: frame.image,
              openbg: 'blue.jpeg',
              suratId: 0,
              ayatId: 0)
        ];
        db.insertSetting(setting);
      }
      Fluttertoast.showToast(msg: '${frame.title} berhasil disimpan');
    });
  }
}

class ChangeOpened extends StatefulWidget {
  const ChangeOpened({super.key});

  @override
  State<ChangeOpened> createState() => _ChangeOpenedState();
}

class _ChangeOpenedState extends State<ChangeOpened> {
  List<FrameBackground> frame = [
    const FrameBackground('', 'blue.jpeg', ''),
    const FrameBackground('', 'brown.jpeg', ''),
    const FrameBackground('', 'gold.jpeg', ''),
    const FrameBackground('', 'green.jpeg', ''),
    const FrameBackground('', 'pink.jpeg', ''),
    const FrameBackground('', 'purple.jpeg', ''),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return MaterialApp(
      home: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Stack(children: [
            Positioned(
                top: 36,
                left: 0,
                child: Image.asset(
                  '$LOCAL_IMAGES_URL/top-bg.png',
                  fit: BoxFit.fitWidth,
                )),
            Positioned(
                right: 0,
                bottom: 0,
                child: Image.asset(
                  '$LOCAL_IMAGES_URL/bottom-bg.png',
                  fit: BoxFit.fitWidth,
                )),
            Container(
              width: size.width,
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  60.height,
                  const Text(
                    'Layar Pembuka Quran',
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                              color: Colors.black,
                              offset: Offset(0, 0),
                              blurRadius: 3)
                        ]),
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    'Pilih Layar Pembuka dengan meng-klik gambar',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                              color: Colors.black,
                              offset: Offset(0, 0),
                              blurRadius: 3)
                        ]),
                    textAlign: TextAlign.center,
                  ),
                  30.height,
                  SizedBox(
                    width: size.width - 20,
                    height: size.height - 150,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: AnimationLimiter(
                        child: StaggeredGrid.count(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 0,
                            children: List.generate(frame.length, (i) {
                              return AnimationConfiguration.staggeredGrid(
                                  position: i,
                                  duration: const Duration(milliseconds: 1500),
                                  columnCount: frame.length,
                                  child: ScaleAnimation(
                                    child: FadeInAnimation(
                                      child: Container(
                                        width: size.width / 2 - 10,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        padding:
                                            const EdgeInsets.only(bottom: 5),
                                        decoration: boxDecorationWithShadow(
                                            borderRadius: radius(10),
                                            backgroundColor: white,
                                            offset: const Offset(5, 5)),
                                        child: GestureDetector(
                                          onTap: () {
                                            saveToDb(frame[i]);
                                          },
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                '$LOCAL_IMAGES_URL/quran/pembuka/${frame[i].openbg}',
                                                width: size.width / 2 - 10,
                                                fit: BoxFit.cover,
                                              ).cornerRadiusWithClipRRectOnly(
                                                  topLeft: 12, bottomLeft: 12),
                                              Text(
                                                frame[i].title,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ));
                            })),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  saveToDb(FrameBackground frame) {
    SqliteSetting db = SqliteSetting();
    db.initializeDB().whenComplete(() async {
      List<SettingFrame> dbSetting = await db.retrieveSettings();

      if (dbSetting.isNotEmpty) {
        List<SettingFrame> setting = [
          SettingFrame(
              id: dbSetting.first.id!,
              frame: dbSetting.first.frame,
              openbg: frame.openbg,
              suratId: dbSetting.first.suratId,
              ayatId: dbSetting.first.ayatId)
        ];
        db.updateSetting(setting, dbSetting.first.id!);
      } else {
        List<SettingFrame> setting = [
          SettingFrame(
              id: 1,
              frame: frame.image,
              openbg: frame.openbg,
              suratId: 0,
              ayatId: 0)
        ];
        db.insertSetting(setting);
      }
      Fluttertoast.showToast(
          msg:
              '${frame.openbg.replaceAll(".jpeg", "").capitalizeFirstLetter()} berhasil disimpan');
    });
  }
}

class FrameBackground {
  const FrameBackground(this.image, this.openbg, this.title);

  final String image;
  final String openbg;
  final String title;
}
