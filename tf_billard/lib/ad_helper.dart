import 'dart:io';

class AdHelper {

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-7188489268015540/5524374246';
    } else if (Platform.isIOS) {
      return '';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-7188489268015540/9331757319';
    } else if (Platform.isIOS) {
      return '<YOUR_IOS_INTERSTITIAL_AD_UNIT_ID>';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
  //
  // static String get rewardedAdUnitId {
  //   if (Platform.isAndroid) {
  //     return '<YOUR_ANDROID_REWARDED_AD_UNIT_ID>';
  //   } else if (Platform.isIOS) {
  //     return '<YOUR_IOS_REWARDED_AD_UNIT_ID>';
  //   } else {
  //     throw UnsupportedError('Unsupported platform');
  //   }
  // }
}