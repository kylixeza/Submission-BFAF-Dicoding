import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_bfaf_v2/provider/settings_provider.dart';
import 'package:submission_bfaf_v2/style/style.dart';
import 'package:submission_bfaf_v2/widget/platform_widget.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: primaryColor,
      ),
      body: _buildSettingsPage(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        leading: Text('Settings'),
        backgroundColor: primaryColor,
      ),
      child: _buildSettingsPage(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid(context),
      iosBuilder: _buildIos(context),
    );
  }

  _buildSettingsPage(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, provider, child) {
        return ListView(
          children: [
            Material(
              child: ListTile(
                title: const Text('Scheduling Restaurant'),
                trailing: Switch.adaptive(
                  value: provider.isDailyRestaurantActive,
                  onChanged: (value) async {
                    provider.scheduledDailyRestaurant(value);
                    provider.enableDailyRestaurant(value);
                  }
                ),
              ),
            )
          ],
        );
      }
    );
  }
}