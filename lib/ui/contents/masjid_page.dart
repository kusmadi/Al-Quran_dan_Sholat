import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

class MasjidPage extends StatefulWidget {
  final double latitude;
  final double longitude;
  final String address;

  const MasjidPage(
      {Key? key,
      required this.latitude,
      required this.longitude,
      required this.address})
      : super(key: key);

  @override
  State<MasjidPage> createState() => _MasjidPageState();
}

class _MasjidPageState extends State<MasjidPage> {
  late InAppWebViewController webView;
  String url = "";
  double progress = 0;

  void requestPermission() async {
    Map<Permission, PermissionStatus> statuses =
        await [Permission.location].request();
  }

  @override
  void initState() {
    super.initState();

    requestPermission();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(title: const Text("Masjid Terdekat")),
        body: SafeArea(
      child: InAppWebView(
        initialUrlRequest: URLRequest(
            url: WebUri.uri(Uri.parse(
                "https://www.google.co.id/maps/search/Masjid+Terdekat+${widget.address}/@${widget.latitude},${widget.longitude},15z"))),
        initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
              useShouldOverrideUrlLoading: true,
            ),
            android: AndroidInAppWebViewOptions(useHybridComposition: true)),
        androidOnGeolocationPermissionsShowPrompt:
            (InAppWebViewController controller, String origin) async {
          bool? result = await showDialog<bool>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Lokasi Masjid'),
                content: const SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text('Kamu mengijinkan pencarian masjid disekitarmu?'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Iya, Ijinkan'),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                  TextButton(
                    child: const Text('Tolak'),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                ],
              );
            },
          );
          if (result!) {
            return Future.value(GeolocationPermissionShowPromptResponse(
                origin: origin, allow: true, retain: true));
          } else {
            return Future.value(GeolocationPermissionShowPromptResponse(
                origin: origin, allow: false, retain: false));
          }
        },
        onWebViewCreated: (InAppWebViewController controller) {
          webView = controller;
          print("onWebViewCreated");
        },
        onLoadStart: (controller, url) {
          print("onLoadStart $url");
          setState(() {
            this.url = url.toString();
          });
        },
        shouldOverrideUrlLoading:
            (controller, shouldOverrideUrlLoadingRequest) async {
          var url = shouldOverrideUrlLoadingRequest.request.url;
          var uri = Uri.parse(url.toString());

          if (![
            "http",
            "https",
            "file",
            "chrome",
            "data",
            "javascript",
            "about"
          ].contains(uri.scheme)) {
            if (await canLaunch(url.toString())) {
              // Launch the App
              await launch(
                url.toString(),
              );
              // and cancel the request
              return NavigationActionPolicy.CANCEL;
            }
          }

          return NavigationActionPolicy.ALLOW;
        },
        onLoadStop: (controller, url) async {
          print("onLoadStop $url");
          setState(() {
            this.url = url!.path;
          });
        },
        onProgressChanged: (InAppWebViewController controller, int progress) {
          setState(() {
            this.progress = progress / 100;
          });
        },
        onUpdateVisitedHistory: (controller, url, androidIsReload) {
          setState(() {
            this.url = url.toString();
          });
          print("onUpdateVisitedHistory $url");
        },
        onConsoleMessage: (controller, consoleMessage) {
          print(consoleMessage);
        },
      ),
    ));
  }
}

// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:webview_flutter_plus/webview_flutter_plus.dart';
// import 'package:quran/config/constant.dart';
//
// class MasjidPage extends StatefulWidget {
//
//   const MasjidPage({Key? key})
//       : super(key: key);
//
//   @override
//   State<MasjidPage> createState() => _MasjidPageState();
// }
//
// class _MasjidPageState extends State<MasjidPage> {
//   late Position position;
//   late double long, lat;
//   late GoogleMapController mapController;
//   LatLng? _currentPosition;
//   bool _isLoading = true;
//
//   @override
//   void initState() {
//     _determinePosition().then((value){
//       lat = value.latitude;
//       long = value.longitude;
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _isLoading ?
//       const Center(child:CircularProgressIndicator()) :
//       GoogleMap(
//         onMapCreated: _onMapCreated,
//         initialCameraPosition: CameraPosition(
//           target: _currentPosition!,
//           zoom: 16,
//         ),
//       ),
//     );
//   }
//
//   Future<Position> _determinePosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     // Test if location services are enabled.
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Location services are not enabled don't continue
//       // accessing the position and request users of the
//       // App to enable the location services.
//       return Future.error('Location services are disabled.');
//     }
//
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         // Permissions are denied, next time you could try
//         // requesting permissions again (this is also where
//         // Android's shouldShowRequestPermissionRationale
//         // returned true. According to Android guidelines
//         // your App should show an explanatory UI now.
//         return Future.error('Location permissions are denied');
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately.
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }
//
//     position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//     double latitude = position.latitude;
//     double longitude = position.longitude;
//
//     LatLng latLng = LatLng(latitude, longitude);
//
//     setState(() {
//       _currentPosition = latLng;
//       _isLoading = false;
//     });
//
//     // When we reach here, permissions are granted and we can
//     // continue accessing the position of the device.
//     return position;
//   }
//
//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }
// }
