// import 'dart:developer';
// import 'dart:io';
//
// import 'package:google_mobile_ads/google_mobile_ads.dart';
//
// class AppOpenAdManager {
//   static AppOpenAd? appOpenAd;
//   static bool isShowingAd = false;
//   static bool isLoaded = false;
//
//   static Future<void> loadAd() async {
//     AppOpenAd.load(
//       adUnitId: Platform.isAndroid
//           ? 'ca-app-pub-3940256099942544/3419835294'
//           : 'ca-app-pub-3940256099942544/5662855259',
//       orientation: AppOpenAd.orientationPortrait,
//       request: const AdRequest(),
//       adLoadCallback: AppOpenAdLoadCallback(
//         onAdLoaded: (ad) {
//           print("Open Ad Loaded........");
//           appOpenAd = ad;
//           isLoaded = true;
//         },
//         onAdFailedToLoad: (e) {
//           log("open ad Error--->${e.toString()}");
//           loadAd();
//         },
//       ),
//     );
//   }
//
//   // Whether an ad is available to be shown.
//   static bool get isAdAvailable {
//     return appOpenAd != null;
//   }
//
//   static void showOpenAdIfAvailable() {
//     log("Open add Called=============");
//     if (appOpenAd == null) {
//       log('Tried to show ad before available.');
//       loadAd();
//       return;
//     }
//     if (isShowingAd) {
//       log('Tried to show ad while already showing an ad.');
//       return;
//     }
//     appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
//       onAdShowedFullScreenContent: (ad) {
//         isShowingAd = true;
//         appOpenAd = ad;
//         print('$ad onAdShowedFullScreenContent');
//       },
//       onAdFailedToShowFullScreenContent: (ad, error) {
//         print('$ad onAdFailedToShowFullScreenContent: $error');
//         isShowingAd = false;
//         ad.dispose();
//         appOpenAd = null;
//         loadAd();
//       },
//       onAdDismissedFullScreenContent: (ad) {
//         print('$ad onAdDismissedFullScreenContent');
//         isShowingAd = false;
//         ad.dispose();
//         appOpenAd = null;
//         loadAd();
//       },
//     );
//     appOpenAd!.show();
//     appOpenAd = null;
//   }
// }


import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AppOpenAdManager {
  final Duration maxCacheDuration = Duration(hours: 4);
  DateTime? _appOpenLoadTime;
  AppOpenAd? _appOpenAd;
  bool _isShowingAd = false;
  String adUnitId = Platform.isAndroid
      ? "ca-app-pub-3940256099942544/3419835294"
      : "ca-app-pub-3940256099942544/5662855259";

  // String openAdId = FirebaseRemoteConfigUtils.appOpenId;
  /// Load an [AppOpenAd].
  Future<void> loadAd() async {
    // final firebaseRef = FirebaseDatabase(
    //     databaseURL: “https://e-shrm-default-rtdb.firebaseio.com/”)
    //     .reference()
    //     .child(“appopen_id”);
    // DataSnapshot appopenId = await firebaseRef.get();
    // log(“AppOpenAd------>${appopenId.value} \n “);
    AppOpenAd.load(
      // adUnitId: openAdId,
      adUnitId: adUnitId,
      orientation: AppOpenAd.orientationPortrait,
      request: AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          print("$ad loaded");
          _appOpenLoadTime = DateTime.now();
          _appOpenAd = ad;
        },
        onAdFailedToLoad: (error) {
          print("AppOpenAd failed to load: $error");
        },
      ),
    );
  }
  bool get isAdAvailable {
    return _appOpenAd != null;
  }
  void showAdIfAvailable() {
    if (!isAdAvailable) {
      print("Tried to show ad before available.");
      loadAd();
      return;
    }
    if (_isShowingAd) {
      print("Tried to show ad while already showing an ad.");
      return;
    }
    if (DateTime.now().subtract(maxCacheDuration).isAfter(_appOpenLoadTime!)) {
      print("Maximum cache duration exceeded. Loading another ad.");
      _appOpenAd!.dispose();
      _appOpenAd = null;
      loadAd();
      return;
    }
    // Set the fullScreenContentCallback and show the ad.
    _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        _isShowingAd = true;
        print("$ad onAdShowedFullScreenContent");
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        print("$ad onAdFailedToShowFullScreenContent: $error");
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
      },
      onAdDismissedFullScreenContent: (ad) {
        print("$ad onAdDismissedFullScreenContent");
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        loadAd();
      },
    );
    _appOpenAd!.show();
  }
}


class AppLifecycleReactor {
  final AppOpenAdManager appOpenAdManager;
  AppLifecycleReactor({required this.appOpenAdManager});
  void listenToAppStateChanges() {
    AppStateEventNotifier.startListening();
    AppStateEventNotifier.appStateStream
        .forEach((state) => _onAppStateChanged(state));
  }
  void _onAppStateChanged(AppState appState) {
    print("New AppState state: $appState");
    if (appState == AppState.foreground) {
      appOpenAdManager.showAdIfAvailable();
    }
  }
}

