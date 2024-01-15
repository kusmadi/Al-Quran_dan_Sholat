import 'package:flutter/material.dart';
import 'package:quran/ui/contents/read_quran_per_ayat_page.dart';
import 'package:quran/ui/db/quran_surat_model.dart';
import 'package:quran/ui/services/quran_service.dart';

class QuranPage extends StatefulWidget {
  final int suratId;
  final int ayatId;
  final String frameBg;
  final String openBg;

  const QuranPage(
      {Key? key,
      required this.suratId,
      required this.frameBg,
      required this.openBg,
      required this.ayatId})
      : super(key: key);

  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    controller = TabController(vsync: this, length: 114);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        body: DefaultTabController(
      length: 114,
      initialIndex: widget.suratId,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: size.height,
            decoration: const BoxDecoration(
                border:
                    Border(top: BorderSide(color: Colors.grey, width: 0.5))),
            child: FutureBuilder<List<QuranSuratModel>>(
              future: QuranServices.getQuranAllSurat(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.stackTrace.toString());
                  return Container();
                } else if (snapshot.hasData) {
                  var surat = snapshot.requireData;
                  List<Widget> surah = List<Widget>.generate(
                      surat.length,
                      (i) => ReadQuranPerAyatPage(
                            suratId: surat[i].rowid!,
                            ayatId: widget.ayatId,
                            frameBg: widget.frameBg,
                            openBg: widget.openBg,
                          ));

                  return Directionality(
                      textDirection: TextDirection.rtl,
                      child:
                          TabBarView(controller: controller, children: surah));
                } else {
                  return const Center();
                }
              },
            ),
          ),
        ],
      ),
    ));
  }
}
