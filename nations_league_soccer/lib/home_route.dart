import 'package:nations_league_soccer/app_theme.dart';
// For check internet
import 'package:nations_league_soccer/network_connectivity.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter/material.dart';
// For Import google_mobile_ads.dart
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeRoute extends StatelessWidget {

  HomeRoute({Key? key}): super(key: key);

  // For check internet
  Map _source = {ConnectivityResult.none: false};
  final NetworkConnectivity _networkConnectivity = NetworkConnectivity.instance;
  String string = '';

  @override
  Widget build(BuildContext context) {

    // For check internet
    _networkConnectivity.initialise();
    _networkConnectivity.myStream.listen((source) {
        _source = source;
        print('source $_source');
        // 1.
        switch (_source.keys.toList()[0]) {
          case ConnectivityResult.mobile:
            string =
            _source.values.toList()[0] ? 'Mobile: Online' : 'Mobile: Offline';
            break;
          case ConnectivityResult.wifi:
            string =
            _source.values.toList()[0] ? 'WiFi: Online' : 'WiFi: Offline';
            break;
          case ConnectivityResult.none:
            default:
            string = 'You are offline, please turn on Internet to play game.';
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  string,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            );
        }
    });

    return Scaffold(
      backgroundColor: AppTheme.primary,
      body: FutureBuilder<void>(
        future: _initGoogleMobileAds(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Nations League Soccer",
                  style: TextStyle(
                    fontSize: 32,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 72),
                ),
                if (snapshot.hasData)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).accentColor,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/game');
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 48.0,
                        vertical: 12.0,
                      ),
                      child: Text('Let\'s get start!'),
                    ),
                  )
                else if (snapshot.hasError)
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  )
                else
                  const SizedBox(
                    width: 48,
                    height: 48,
                    child: CircularProgressIndicator(),
                  ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 142),
                ),
                const Text(
                  "Powered by GameMonetize, Delivered by TFlash Game.\n\nGet more game at https://en.tflash.online.",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _networkConnectivity.disposeStream();
  }

  // COMPLETE: Change return type to Future<InitializationStatus>
  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }
}