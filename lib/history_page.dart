import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HistoryPage extends StatefulWidget {
  final User user;
  const HistoryPage({super.key, required this.user});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  bool _showBalanceDetails =
      false; // State to toggle balance details visibility

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
            icon: const Icon(
              Icons.filter_list,
              color: Colors.white,
            ), // Filter icon
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Filter options')));
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ), // More options icon
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('More options')));
            },
          ),
        ],
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
          return Builder(
            builder: (context) {
              return Column(
                children: [
                  // Account Info and Balance Section
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Savings',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$accountNumber | Savings',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
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
                              Text(
                                balance,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(
                                _showBalanceDetails
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                color: Colors.white70,
                              ),
                            ],
                          ),
                        ),
                        if (_showBalanceDetails)
                          Text(
                            balance,
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 14,
                            ),
                          ),
                        const SizedBox(height: 16),
                        const Divider(color: Colors.white12, thickness: 1),
                      ],
                    ),
                  ),
                  // Transaction History List
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream:
                          FirebaseFirestore.instance
                              .collection('transactions')
                              .where('from', isEqualTo: widget.user.uid)
                              .snapshots(),
                      builder: (context, sentSnapshot) {
                        return StreamBuilder<QuerySnapshot>(
                          stream:
                              FirebaseFirestore.instance
                                  .collection('transactions')
                                  .where('to', isEqualTo: widget.user.uid)
                                  .snapshots(),
                          builder: (context, receivedSnapshot) {
                            if (sentSnapshot.connectionState ==
                                    ConnectionState.waiting ||
                                receivedSnapshot.connectionState ==
                                    ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            // Combine sent and received transactions
                            final sentTransactions =
                                sentSnapshot.hasData
                                    ? sentSnapshot.data!.docs
                                        .map((doc) => MapEntry(doc, 'sent'))
                                        .toList()
                                    : [];

                            final receivedTransactions =
                                receivedSnapshot.hasData
                                    ? receivedSnapshot.data!.docs
                                        .map((doc) => MapEntry(doc, 'received'))
                                        .toList()
                                    : [];

                            final allTransactions = [
                              ...sentTransactions,
                              ...receivedTransactions,
                            ];

                            // Sort by timestamp (newest first)
                            allTransactions.sort((a, b) {
                              final aTime =
                                  a.key.data()!['timestamp'] as Timestamp;
                              final bTime =
                                  b.key.data()!['timestamp'] as Timestamp;
                              return bTime.compareTo(aTime); // newest first
                            });

                            if (allTransactions.isEmpty) {
                              return const Center(
                                child: Text(
                                  'No transactions found.',
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                            }

                            return ListView.builder(
                              itemCount: allTransactions.length,
                              itemBuilder: (context, index) {
                                final entry = allTransactions[index];
                                final data =
                                    entry.key.data() as Map<String, dynamic>;
                                final transactionType = entry.value;
                                final otherUserUid =
                                    transactionType == 'sent'
                                        ? data['to']
                                        : data['from'];

                                return FutureBuilder<DocumentSnapshot>(
                                  future:
                                      FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(otherUserUid)
                                          .get(),
                                  builder: (context, userSnapshot) {
                                    String otherUserName = otherUserUid;
                                    if (userSnapshot.hasData &&
                                        userSnapshot.data!.exists) {
                                      final userData =
                                          userSnapshot.data!.data()
                                              as Map<String, dynamic>;
                                      otherUserName =
                                          '${userData['firstname'] ?? ''} ${userData['lastname'] ?? ''}'
                                              .trim();
                                    }

                                    final amount = data['amount'];
                                    final isSent = transactionType == 'sent';

                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0,
                                            vertical: 8.0,
                                          ),
                                          child: Text(
                                            data['timestamp'] != null
                                                ? (data['timestamp']
                                                        as Timestamp)
                                                    .toDate()
                                                    .toString()
                                                : '',
                                            style: const TextStyle(
                                              color: Colors.white70,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  isSent
                                                      ? 'Sent \$${amount} to $otherUserName'
                                                      : 'Received \$${amount} from $otherUserName',
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            color: const Color(0xFF1E2B38),
                                            margin: const EdgeInsets.only(
                                              bottom: 2.0,
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0,
                                              vertical: 12.0,
                                            ),
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor:
                                                      isSent
                                                          ? Colors.red
                                                          : Colors.green,
                                                  child: Text(
                                                    otherUserName.isNotEmpty
                                                        ? otherUserName
                                                            .substring(0, 2)
                                                            .toUpperCase()
                                                        : '??',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 16),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        isSent
                                                            ? 'To: $otherUserName'
                                                            : 'From: $otherUserName',
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 4),
                                                      Text(
                                                        isSent
                                                            ? 'Sent'
                                                            : 'Received',
                                                        style: TextStyle(
                                                          color:
                                                              isSent
                                                                  ? Colors.red
                                                                  : Colors
                                                                      .green,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Text(
                                                  isSent
                                                      ? '-\$${amount}'
                                                      : '+\$${amount}',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color:
                                                        isSent
                                                            ? Colors.red
                                                            : Colors.green,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                  // Bottom Pay & Transfer Button
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('PAY & TRANSFER button pressed!'),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.white, // White button background
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
              );
            },
          );
        },
      ),
    );
  }
}
