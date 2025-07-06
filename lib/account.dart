import 'package:flutter/material.dart';
import 'package:aba_app/history_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AccountsPage extends StatefulWidget {
  // final String userId;
  final User user;
  const AccountsPage({super.key, required this.user});

  @override
  State<AccountsPage> createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  bool _showAnalytics = false; // State to toggle analytics visibility

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFF0F1F2B,
      ), // Dark background from your theme
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
          'ABA Accounts',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream:
            FirebaseFirestore.instance
                .collection('users')
                .doc(widget.user.uid)
                .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(
              child: Text(
                'No user data found.',
                style: TextStyle(color: Colors.white),
              ),
            );
          }
          final userData = snapshot.data!.data() as Map<String, dynamic>;
          final accountNumber = userData['accountNumber']?.toString() ?? '';
          final balance = '${userData['balance']?.toString() ?? '0.00'} USD';

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Section: Available Balance and All Accounts Circle
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // All Accounts Circle
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: CircularProgressIndicator(
                            value: 0.7, // Example value for progress
                            strokeWidth: 10,
                            backgroundColor: Colors.cyan.withOpacity(0.3),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Colors.cyan,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.account_balance_wallet_outlined,
                              color: Colors.white,
                              size: 30,
                            ),
                            Text(
                              'All Accounts',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    // Available Balance
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Available Balance',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '\$$balance',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Analytics Section
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _showAnalytics = !_showAnalytics;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.analytics, color: Colors.white70),
                      const SizedBox(width: 8),
                      const Text(
                        'Analytics',
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                      Icon(
                        _showAnalytics
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: Colors.white70,
                      ),
                    ],
                  ),
                ),
                if (_showAnalytics) // Conditional rendering for analytics content
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E2B38), // Card background color
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'Analytics content goes here...',
                        style: TextStyle(color: Colors.white54),
                      ),
                    ),
                  ),
                const SizedBox(height: 20),
                // Accounts Section Header
                const Text(
                  'ACCOUNT',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 10),
                // Single Account Card
                _buildAccountCard(
                  context,
                  title: 'Main Account',
                  accountNumber: accountNumber,
                  type: 'Savings',
                  balance: balance,
                ),
              ],
            ),
          );
        },
      ),
      // Floating Action Button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: FloatingActionButton.extended(
            onPressed: () {
              // Handle "Account" button press
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Add Account button pressed!')),
              );
            },
            backgroundColor: Colors.red, // Red button color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Rounded corners
            ),
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text(
              'Account',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Modified _buildAccountCard to include InkWell and navigate to HistoryPage
  Widget _buildAccountCard(
    BuildContext context, { // Accept context
    required String title,
    required String accountNumber,
    required String type,
    required String balance,
    bool isDefault = false,
    bool hasVisa = false,
  }) {
    return InkWell(
      // Wrap the Card with InkWell to make it tappable
      onTap: () {
        // Navigate to HistoryPage when an account card is tapped
        Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HistoryPage(user: widget.user),
                      ),
                    );
      },
      borderRadius: BorderRadius.circular(10), // Match the Card's border radius
      child: Card(
        color: const Color(0xFF1E2B38), // Card background color
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Icon(
                    Icons.more_horiz,
                    color: Colors.white70,
                  ), // Three dots icon
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    '$accountNumber | $type',
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  if (isDefault)
                    Container(
                      margin: const EdgeInsets.only(left: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text(
                        'Default',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  if (hasVisa)
                    Container(
                      margin: const EdgeInsets.only(left: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.shade700, // Visa tag background
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text(
                        'VISA',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  balance,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
