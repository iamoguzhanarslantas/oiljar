import 'dart:math';

import 'package:flutter/material.dart';

class CampaignsPage extends StatelessWidget {
  static const String routeName = '/campaigns';
  const CampaignsPage({super.key});

  final Map<String, dynamic> campaigns = const {
    'Campaign 1': 50,
    'Campaign 2': 200,
    'Campaign 3': 300,
    'Campaign 4': 400,
    'Campaign 5': 500,
  };

  int generateRandomPrice() {
    final random = Random();
    return random.nextInt(500);
  }

  @override
  Widget build(BuildContext context) {
    var points = ModalRoute.of(context)!.settings.arguments as int?;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campaigns'),
        actions: [
          Text('Points: $points'),
          const SizedBox(width: 20),
        ],
      ),
      body: ListView.builder(
        itemCount: campaigns.entries.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              if (points! < campaigns.values.elementAt(index)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        'You do not have enough points to redeem this campaign'),
                  ),
                );
                return;
              } else if (points! >= campaigns.values.elementAt(index)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Campaign redeemed successfully'),
                  ),
                );
                points = points! -
                    int.parse(campaigns.values.elementAt(index).toString());
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
