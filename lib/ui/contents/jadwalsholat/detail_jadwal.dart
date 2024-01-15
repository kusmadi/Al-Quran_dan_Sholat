import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quran/config/constant.dart';
import 'package:quran/ui/contents/jadwalsholat/prayer_times.dart';

class DetailJadwal extends StatefulWidget {
  final double lat;
  final double long;
  final String area;

  const DetailJadwal(
      {Key? key, required this.lat, required this.long, required this.area})
      : super(key: key);

  @override
  State<DetailJadwal> createState() => _DetailJadwalState();
}

class _DetailJadwalState extends State<DetailJadwal> {
  List<String> _prayerTimes = [];
  List<String> _prayerNames = [];

  @override
  void initState() {
    getPrayerTimes();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final myCoordinates = Coordinates(
        widget.lat, widget.long); // Replace with your own location lat, lng.
    final params = CalculationMethod.karachi.getParameters();
    params.madhab = Madhab.hanafi;
    final prayerTimes = PrayerTimes.today(myCoordinates, params);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 100,
            height: 8,
            decoration: const BoxDecoration(
                color: Colors.white60,
                borderRadius: BorderRadius.all(Radius.circular(8))),
          ),
          30.height,
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const Text(
                  'WAKTU SHOLAT',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: SOFT_BLUE),
                ),
                Text(
                  widget.area,
                  style: const TextStyle(fontSize: 16, color: SOFT_BLUE),
                ),
              ],
            ),
          ),
          const Divider(),
          SizedBox(
            height: 360,
            child: ListView.builder(
              itemCount: _prayerNames.length,
              itemBuilder: (context, position) {
                int payerTime = prayerTimes.currentPrayer().index;

                return Container(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _prayerNames[position],
                            style: TextStyle(
                              color: payerTime == position
                                  ? ASSENT_COLOR
                                  : SOFT_BLUE,
                              fontSize: payerTime == position ? 20 : 16,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          Text(
                            payerTime == position && payerTime != 4
                                ? "Waktu Sholat ${_prayerNames[position]} ${hourBetween(_prayerTimes[position])} lagi"
                                : "",
                            style: TextStyle(
                              color: payerTime == position
                                  ? ASSENT_COLOR
                                  : SOFT_BLUE,
                              fontSize: 13,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      Text(
                        _prayerTimes[position],
                        style: TextStyle(
                            color: payerTime == position
                                ? ASSENT_COLOR
                                : SOFT_BLUE,
                            fontSize: payerTime == position ? 20 : 16,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  getPrayerTimes() {
    PrayerTime prayers = PrayerTime();
    prayers.setTimeFormat(prayers.getTime24());
    prayers.setCalcMethod(prayers.getMWL());
    prayers.setAsrJuristic(prayers.getShafii());
    prayers.setAdjustHighLats(prayers.getAdjustHighLats());

    List<int> offsets = [-6, 0, 3, 2, 0, 3, 6];

    var currentTime = DateTime.now();
    String strTimeZone = currentTime.timeZoneOffset.toString().split(":")[0];
    prayers.tune(offsets);

    setState(() {
      _prayerTimes = prayers.getPrayerTimes(
          currentTime, widget.lat, widget.long, strTimeZone.toDouble());
      _prayerNames = prayers.getTimeNames();
    });
  }

  String hourBetween(String to) {
    var now = DateTime.now();
    int hour = to.split(":")[0].toInt();
    int minute = to.split(":")[1].toInt();
    var two = DateTime(now.year, now.month, now.day, hour, minute);

    return two.difference(now).toString().split(".")[0];
  }
}
