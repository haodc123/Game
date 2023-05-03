import 'package:app_webview/app_theme.dart';
import 'package:flutter/material.dart';

// COMPLETE: Import google_mobile_ads.dart
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeRoute extends StatelessWidget {

  const HomeRoute({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  "TFlash Game 1!",
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
                      child: Text('Let\'s get started!'),
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
              ],
            ),
          );
        },
      ),
    );
  }

  // COMPLETE: Change return type to Future<InitializationStatus>
  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }
}