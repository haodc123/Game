import 'package:nations_league_soccer/ad_helper.dart';
import 'package:nations_league_soccer/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
// COMPLETE: Import google_mobile_ads.dart
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GameRoute extends StatefulWidget {
  const GameRoute({Key? key}) : super(key: key);

  @override
  State<GameRoute> createState() => _GameRouteState();
}

class _GameRouteState extends State<GameRoute> {
  late final WebViewController controller;

  // COMPLETE: Add _bannerAd
  BannerAd? _bannerAd;

  @override
  void initState() {
    _createInterstitialAd();
    super.initState();
    
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse('https://en.tflash.online/game_m/nations-league-soccer'),
      );

    // COMPLETE: Load a banner ad
    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          debugPrint('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    ).load();

  }

  // For Button click Ads
  // bool _canShowButton = true;
  // void toggleWidget() {
  //   setState(() {
  //     _canShowButton = !_canShowButton;
  //   });
  // }

  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;
  int maxFailedLoadAttempts = 3;

  void _createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: "ca-app-pub-7188489268015540/4226700485",
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _numInterstitialLoadAttempts = 0;
          _showInterstitialAd();
        },
        onAdFailedToLoad: (LoadAdError error) {
          _numInterstitialLoadAttempts += 1;
          _interstitialAd = null;
          if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
            _createInterstitialAd();
          }
        },
      ),
    );
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        ad.dispose();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primary,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(
              controller: controller,
            ),
            // For Button click Ads
            // SizedBox(height: 20.0),
            // // if the show button is false
            // !_canShowButton
            //     ? const SizedBox.shrink() :
            //   Center(
            //     // heightFactor: 3,
            //     // widthFactor: 0.8,
            //     child: ElevatedButton(
            //         style: ElevatedButton.styleFrom(
            //           backgroundColor: Colors.transparent,
            //           minimumSize: const Size.fromHeight(1000),
            //         ),
            //         onPressed: () {
            //           if (_interstitialAd != null) {
            //             _interstitialAd?.show();
            //           }
            //           toggleWidget();
            //         },
            //         child: const Text(
            //           '',
            //           style: TextStyle(fontSize: 22),
            //         ),
            //       ),
            //   ),
            // COMPLETE: Display a banner when ready
            if (_bannerAd != null)
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: _bannerAd!.size.width.toDouble(),
                  height: _bannerAd!.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAd!),
                ),
              ),
          ],
        ),
      ),
    );

    // return Column(
    //   // bố trí widget theo chiều dọc
    //   children: [
    //     // sử dụng children truyền vào 1 mảng widget
    //   WebViewWidget(
    //             controller: controller,
    //
    //           ),
    //           // COMPLETE: Display a banner when ready
    //           if (_bannerAd != null)
    //             Align(
    //               alignment: Alignment.topCenter,
    //               child: SizedBox(
    //                 width: _bannerAd!.size.width.toDouble(),
    //                 height: _bannerAd!.size.height.toDouble(),
    //                 child: AdWidget(ad: _bannerAd!),
    //               ),
    //             ),
    //   ],
    // );

  }

  @override
  void dispose() {
    // COMPLETE: Dispose a BannerAd object
    _bannerAd?.dispose();
    _interstitialAd?.dispose();

    super.dispose();
  }

  @override
  void onClueUpdated(String clue) {
    setState(() {});

  }
}