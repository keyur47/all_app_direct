import 'dart:developer';

import 'package:all_app_direct/modules/controller/controller.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

// DatabaseReference databaseReference = FirebaseDatabase.instance.ref(‘users’);
class BannerAds extends StatefulWidget {
  static bool isLoaded = false;

  const BannerAds({Key? key}) : super(key: key);

  @override
  _BannerAdsState createState() => _BannerAdsState();
}

class _BannerAdsState extends State<BannerAds> {
  BannerAd? _ad;
  Controller controller = Get.find();

  // String bannerAd = FirebaseRemoteConfigUtils.bannerAdId;
  @override
  void initState() {
    // clearBannerAdData();
    // CustomBanners();
    adsFunction();
    super.initState();
  }

  // clearBannerAdData() {
  //   setState(() {
  //     AdConstants.url = ‘’;
  //     AdConstants.id = 0;
  //     AdConstants.redirectionLink = ‘’;
  //   });
  void adsFunction() async {
     // controller.ads.value = true;
    final firebaseRef = FirebaseDatabase(
            databaseURL:
                "https://direct-whatsapp-408df-default-rtdb.firebaseio.com")
        .reference()
        .child("Bannerid");
    DataSnapshot bannerId = await firebaseRef.get();
    log("banner-id----->${bannerId.value} \n ");
    _ad = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: bannerId.value.toString(),
      // adUnitId: bannerAd,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          setState(() {
            BannerAds.isLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          log("$BannerAd failedToLoad: $error");
          ad.dispose();
        },
        onAdOpened: (Ad ad) {
          print('$BannerAd onAdOpened.');
        },
        onAdClosed: (Ad ad) {
          print('$BannerAd onAdClosed.');
        },
      ),
      request: const AdRequest(),
    );
    _ad?.load();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _ad == null
          ? SizedBox()
          : AdWidget(
              ad: _ad!,
            ),
      width: _ad?.size.width.toDouble(),
      height: _ad?.size.height.toDouble(),
      alignment: Alignment.center,
    );
  }
}
