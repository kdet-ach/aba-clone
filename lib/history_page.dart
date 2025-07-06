// history_page.dart
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  bool _showBalanceDetails = false; // State to toggle balance details visibility

  // Sample transaction data
  final List<Map<String, dynamic>> transactions = [
    {
      'date': '09 Jun 2025',
      'entries': [
        {'name': 'KHOEUN LAMPHOU', 'amount': -5.00, 'currency': 'USD', 'iconType': 'house'},
      ],
    },
    {
      'date': '06 Jun 2025',
      'entries': [
        {'name': 'Paid by DONG DARONG', 'amount': 5.00, 'currency': 'USD', 'iconType': 'house'},
      ],
    },
    {
      'date': '13 May 2025',
      'entries': [
        {'name': 'DONG DARONG', 'amount': -1.00, 'currency': 'USD', 'iconType': 'initials'},
      ],
    },
    {
      'date': '11 May 2025',
      'entries': [
        {'name': 'DONG DARONG', 'amount': 1.00, 'currency': 'USD', 'iconType': 'initials'},
      ],
    },
    {
      'date': '20 Apr 2025',
      'entries': [
        {'name': 'Another Transaction', 'amount': -10.00, 'currency': 'USD', 'iconType': 'house'},
        {'name': 'Income Source', 'amount': 25.00, 'currency': 'USD', 'iconType': 'initials'},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1F2B), // Dark background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'ABA History',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.white), // Filter icon
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Filter options')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white), // More options icon
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('More options')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Account Info and Balance Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Savings',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                const Text(
                  '500 205 054 | Savings',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 16),
                const Text(
                  'AVAILABLE BALANCE',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _showBalanceDetails = !_showBalanceDetails;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '0.00 USD',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        _showBalanceDetails ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                        color: Colors.white70,
                      ),
                    ],
                  ),
                ),
                if (_showBalanceDetails)
                  const Text(
                    'Account Balance: 0.00 USD', // Example detail
                    style: TextStyle(color: Colors.white54, fontSize: 14),
                  ),
                const SizedBox(height: 16),
                const Divider(color: Colors.white12, thickness: 1),
              ],
            ),
          ),
          // Transaction History List
          Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final date = transactions[index]['date'];
                final entries = transactions[index]['entries'] as List<Map<String, dynamic>>;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Text(
                        date,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ...entries.map((entry) {
                      final isNegative = entry['amount'] < 0;
                      return InkWell( // Added InkWell here to make the card tappable
                        onTap: () {
                          // Define what happens when a transaction card is tapped
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Tapped on transaction with ${entry['name']} for ${entry['amount']} ${entry['currency']}'),
                            ),
                          );
                        },
                        child: Container(
                          color: const Color(0xFF1E2B38), // Card background for each entry
                          margin: const EdgeInsets.only(bottom: 2.0), // Small margin between entries
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: entry['iconType'] == 'house' ? Colors.blue : Colors.purple,
                                child: entry['iconType'] == 'house'
                                  ? const Icon(Icons.house, color: Colors.white)
                                  : Text(
                                      entry['name'].substring(0, 2).toUpperCase(),
                                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  entry['name'],
                                  style: const TextStyle(color: Colors.white, fontSize: 16),
                                ),
                              ),
                              Text(
                                '${isNegative ? '' : '+'}${entry['amount'].toStringAsFixed(2)} ${entry['currency']}',
                                style: TextStyle(
                                  color: isNegative ? Colors.red : Colors.green,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                );
              },
            ),
          ),
          // Bottom Pay & Transfer Button
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            color: Colors.red, // Red background for the button container
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('PAY & TRANSFER button pressed!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // White button background
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text(
                'PAY & TRANSFER',
                style: TextStyle(
                  color: Colors.red, // Red text color
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
