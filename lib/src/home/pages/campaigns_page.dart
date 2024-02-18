import 'dart:math';

import 'package:flutter/material.dart';
import 'package:oiljar/src/home/home.dart' show UserHomePage;
import 'package:oiljar/src/services/services.dart' show UserRepository;

class CampaignsPage extends StatefulWidget {
  static const String routeName = '/campaigns';
  const CampaignsPage({super.key});

  @override
  State<CampaignsPage> createState() => _CampaignsPageState();
}

class _CampaignsPageState extends State<CampaignsPage> {
  final Map<String, dynamic> campaigns = const {
    'Campaign 1': 10,
    'Campaign 2': 200,
    'Campaign 3': 300,
    'Campaign 4': 400,
    'Campaign 5': 500,
  };

  int generateRandomPrice() {
    final random = Random();
    return random.nextInt(500);
  }

  int userPoints = 0;

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    userPoints = args['points'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campaigns'),
        actions: [
          Text('Points: $userPoints'),
          const SizedBox(width: 20),
        ],
      ),
      body: ListView.builder(
        itemCount: campaigns.entries.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () async {
              if (userPoints < campaigns.values.elementAt(index)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        'You do not have enough points to redeem this campaign'),
                  ),
                );
                return;
              } else if (userPoints >= campaigns.values.elementAt(index)) {
                await UserRepository().updatePoints(
                    args['id'], campaigns.values.elementAt(index));
                if (context.mounted) {
                  Navigator.pushNamed(context, UserHomePage.routeName);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          '${campaigns.keys.elementAt(index).toString()} redeemed successfully'),
                    ),
                  );
                }
              }
            },
            child: ListTile(
              title: Text(
                campaigns.keys.elementAt(index),
              ),
              subtitle: Text('Price: \$${campaigns.values.elementAt(index)}'),
            ),
          );
        },
      ),
    );
  }
}
