import 'package:asktoai_app/constants/string_res.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';

class AudienceAd {
  static bool isInterstitialAdLoaded = false;
  static bool isRewardedAdLoaded = false;

  static Future<void> loadInterstitialAd() async {
    await FacebookInterstitialAd.loadInterstitialAd(
      // placementId: "YOUR_PLACEMENT_ID",
      placementId: StringResource.interstitialAndroidAdmobAdId,
      //"IMG_16_9_APP_INSTALL#2312433698835503_2650502525028617",
      listener: (result, value) {
        // print(">> FAN > Interstitial Ad: $result --> $value");
        if (result == InterstitialAdResult.LOADED)
          isInterstitialAdLoaded = true;

        /// Once an Interstitial Ad has been dismissed and becomes invalidated,
        /// load a fresh Ad by calling this function.
        if (result == InterstitialAdResult.DISMISSED &&
            value["invalidated"] == true) {
          isInterstitialAdLoaded = false;
          loadInterstitialAd();
        }
      },
    );
  }

  static Future<void> loadRewardedVideoAd() async {
    await FacebookRewardedVideoAd.loadRewardedVideoAd(
      placementId: "YOUR_PLACEMENT_ID",
      listener: (result, value) {
        // print("Rewarded Ad: $result --> $value");
        if (result == RewardedVideoAdResult.LOADED) isRewardedAdLoaded = true;
        if (result == RewardedVideoAdResult.VIDEO_COMPLETE)

        /// Once a Rewarded Ad has been closed and becomes invalidated,
        /// load a fresh Ad by calling this function.
        if (result == RewardedVideoAdResult.VIDEO_CLOSED &&
            (value == true || value["invalidated"] == true)) {
          isRewardedAdLoaded = false;
          loadRewardedVideoAd();
        }
      },
    );
  }
}
