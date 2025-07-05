// transfers_list.dart
import 'package:flutter/material.dart';
import 'package:aba_app/transfer-to-other-aba-account.dart'; // Import the new page

class ABATransferPage extends StatefulWidget {
  const ABATransferPage({super.key});

  @override
  State<ABATransferPage> createState() => _ABATransferPageState();
}

class _ABATransferPageState extends State<ABATransferPage> {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = "";

  final List<Map<String, dynamic>> transferOptions = [
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
    final filteredOptions = transferOptions.where((item) {
      final title = item['title'].toString().toLowerCase();
      final subtitle = item['subtitle'].toString().toLowerCase();
      final query = searchQuery.toLowerCase();
      return title.contains(query) || subtitle.contains(query);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // This will now pop back to HomePage
          },
        ),
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white12,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: _searchController,
            onChanged: (value) => setState(() => searchQuery = value),
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.redAccent,
            decoration: InputDecoration(
              hintText: 'Search transfers...',
              hintStyle: const TextStyle(color: Colors.white54),
              prefixIcon: const Icon(Icons.search, color: Colors.white70),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              suffixIcon: searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.close, color: Colors.white60),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          searchQuery = '';
                        });
                      },
                    )
                  : null,
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Transfers',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 8),
          const Text(
            'Transfer money to your friends, relatives or partners in couple of simple steps.',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          if (filteredOptions.isEmpty)
            Column(
              children: const [
                Icon(Icons.inbox, size: 60, color: Colors.grey),
                SizedBox(height: 10),
                Text(
                  'Not Found',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Text(
                  'Sorry, there are no results that match your search.',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            )
          else
            ...filteredOptions.map((item) {
              // Add specific navigation for "Transfer to other ABA account"
              if (item['title'] == 'Transfer to other ABA account') {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TransferToOtherABAPage()),
                    );
                  },
                  child: TransferTile(item),
                );
              }
              // For other items, just return the TransferTile
              return TransferTile(item);
            }).toList(),
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
      ),
    );
  }
}
