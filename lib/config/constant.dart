import 'package:flutter/material.dart';

const String APP_NAME = "Quran dan Sholat";
const String FOR_NAME = 'Indonesia Beriman';

// color for apps
// const Color PRIMARY_COLOR = Color(0xFF07ac12);
const Color PRIMARY_COLOR = Color(0xFF009FCF);
const Color ASSENT_COLOR = Color(0xFFe75f3f);

const Color CHARCOAL = Color(0xFF515151);
const Color BLACK_GREY = Color(0xff777777);
const Color SOFT_GREY = Color(0xFFaaaaaa);
const Color SOFT_BLUE = Color(0xff01aed6);

const int STATUS_OK = 200;
const int STATUS_BAD_REQUEST = 400;
const int STATUS_NOT_AUTHORIZED = 403;
const int STATUS_NOT_FOUND = 404;
const int STATUS_INTERNAL_ERROR = 500;

const String ERROR_OCCURED = 'Terjadi kesalahan. Silakan ulangi lagi!';

const int LIMIT_PAGE = 8;

const String LOCAL_IMAGES_URL = 'assets/images';
const String LOCAL_HTML_URL = 'assets/html';


const kBlackColor = Color(0xFF393939);
const kLightBlackColor = Color(0xFF8F8F8F);
const kIconColor = Color(0xFFF48A37);
const kProgressIndicator = Color(0xFFBE7066);

final kShadowColor = const Color(0xFFD3D3D3).withOpacity(.84);
const String GLOBAL_URL = 'https://adyatama.smilecodes.id';

const String kataShare = "Assalamu 'alaikum\nMari gunakan aplikasi $FOR_NAME\n\n";
const String linkShare = "https://play.google.com/store/apps/details?id=id.smilecodes.quran";

const String GLOBAL_AUDIO_URL = 'https://www.everyayah.com/data';

String tmpEmail = '';
List<Map<String, dynamic>> listUser = [];