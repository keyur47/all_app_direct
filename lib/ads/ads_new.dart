import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsADs  extends StatefulWidget {
  const AdsADs({Key? key}) : super(key: key);

  @override
  _AdsADsState createState() => _AdsADsState();
}

class _AdsADsState extends State<AdsADs> {
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _showRewardedAd();
}

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _rewardedAd?.dispose();
  }
  RewardedAd? _rewardedAd;
  int _numRewardedLoadAttempts = 0;
  bool _isRewardedAdLoaded = false;
  int maxFailedLoadAttempts = 5 ;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
          onTap: (){
            _showRewardedAd();
          },
          child: Icon(Icons.add_circle)),
    );
  }
  void _createRewardedAd() {
    RewardedAd.load(
      adUnitId:"ca-app-pub-3940256099942544/5224354917",
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          log('$ad loaded.');
          _rewardedAd = ad;
          _numRewardedLoadAttempts = 0;
          _rewardedAd!.setImmersiveMode(true);
          _isRewardedAdLoaded = true;
        },
        onAdFailedToLoad: (LoadAdError error) {
          log('RewardedAd failed to load: $error');
          _rewardedAd = null;
          _numRewardedLoadAttempts += 1;
          if (_numRewardedLoadAttempts < maxFailedLoadAttempts) {
            _createRewardedAd();
          }
        },
      ),
    );
  }
  void _showRewardedAd() {
    if (_rewardedAd == null) {
      log('Warning: attempt to show rewarded before loaded.');
      _createRewardedAd();
      return;
    }
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) {
        _isRewardedAdLoaded = true;
        log('ad onAdShowedFullScreenContent.');
      },
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        log('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        log('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createRewardedAd();
      },
    );
    _rewardedAd!
        .show(onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {});
    _rewardedAd = null;
  }
}
