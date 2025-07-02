import 'package:flutter/material.dart';
void main() {
  runApp(const ABATransferApp());
}

class ABATransferApp extends StatelessWidget {
  const ABATransferApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ABA Transfers',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.red,
        fontFamily: 'Arial',
        scaffoldBackgroundColor: const Color(0xFF0F1F2B),
      ),
      home: const ABATransferPage(),
    );
  }
}

class ABATransferPage extends StatelessWidget {
  const ABATransferPage({super.key});

  final List<Map<String, dynamic>> transferOptions = const [
    {
      'title': 'Choose from Favorites',
      'subtitle': 'Transfer to friends from your favorite list',
      'icon': Icons.star_border,
      'color': Colors.teal,
    },
    {
      'title': 'Transfer to own ABA account',
      'subtitle': 'Make a transfer to your own account',
      'icon': Icons.account_circle_outlined,
      'color': Colors.blue,
    },
    {
      'title': 'Transfer to other ABA account',
      'subtitle': 'Transfer money to other ABA customers',
      'icon': Icons.compare_arrows,
      'color': Colors.red,
    },
    {
      'title': 'Send money to ABA ATM\'s',
      'subtitle': 'Make cardless cash withdrawal at any ABA ATM',
      'icon': Icons.local_atm,
      'color': Colors.green,
    },
    {
      'title': 'Transfer to Local Banks & Wallets',
      'subtitle': 'Make transfers to banks or wallets in Cambodia',
      'icon': Icons.account_balance,
      'color': Colors.deepOrange,
    },
    {
      'title': 'International Transfers',
      'subtitle': 'Send money abroad via various channels',
      'icon': Icons.language,
      'color': Colors.orange,
    },
    {
      'title': 'Transfer to cards',
      'subtitle': 'Transfer money to other bank card users',
      'icon': Icons.credit_card,
      'color': Colors.purple,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ABA Transfers'),
        leading: BackButton(
            onPressed:(){
            Navigator.pop(context);
          },
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.search),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Transfers',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Transfer money to your friends, relatives or partners in couple of simple steps.',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          ...transferOptions.map((item) => TransferTile(item)).toList(),
        ],
      ),
    );
  }
}

class TransferTile extends StatelessWidget {
  final Map<String, dynamic> data;

  const TransferTile(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1E2B38),
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: data['color'],
          child: Icon(data['icon'], color: Colors.white),
        ),
        title: Text(
          data['title'],
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          data['subtitle'],
          style: const TextStyle(color: Colors.grey),
        ),
        // trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 16),
        // onTap: () {
        //   // Add action for tap
        // },
      ),
    );
  }
}


