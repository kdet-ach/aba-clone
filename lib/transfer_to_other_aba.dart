
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'main.dart';

class TransferToOtherABAPage extends StatefulWidget {
  final User user;
  const TransferToOtherABAPage({super.key, required this.user});

  @override
  State<TransferToOtherABAPage> createState() => _TransferToOtherABAPageState();
}

class _TransferToOtherABAPageState extends State<TransferToOtherABAPage> {
  bool _addToFavorites = false;
  bool _transferAsGift = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  String _status = '';

  Future<void> _transfer() async {
    if (!_formKey.currentState!.validate()) return;

    final confirmed = await _showPasswordDialog(context);
if (confirmed != true) {
  setState(() => _status = 'Transaction canceled or incorrect password');
  return;
}
    final senderUid = widget.user.uid;
    final recipientAccount = _accountController.text.trim();
    final amount = double.tryParse(_amountController.text.trim());

    if (amount == null || amount <= 0) {
      setState(() => _status = 'Enter a valid amount');
      return;
    }

    try {
      // Find recipient by email
      final recipientQuery =
          await FirebaseFirestore.instance
              .collection('users')
              .where('accountNumber', isEqualTo: recipientAccount)
              .limit(1)
              .get();

      if (recipientQuery.docs.isEmpty) {
        setState(() => _status = 'Recipient not found');
        return;
      }

      final recipientDoc = recipientQuery.docs.first;
      final recipientUid = recipientDoc.id;

      // Run transaction to update both balances atomically
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final senderRef = FirebaseFirestore.instance
            .collection('users')
            .doc(senderUid);
        final recipientRef = FirebaseFirestore.instance
            .collection('users')
            .doc(recipientUid);

        final senderSnapshot = await transaction.get(senderRef);
        final recipientSnapshot = await transaction.get(recipientRef);

        final senderBalance = (senderSnapshot['balance'] ?? 0).toDouble();
        final recipientBalance = (recipientSnapshot['balance'] ?? 0).toDouble();

        if (senderBalance < amount) {
          throw Exception('Insufficient balance');
        }

        transaction.update(senderRef, {'balance': senderBalance - amount});
        transaction.update(recipientRef, {
          'balance': recipientBalance + amount,
        });

        // Record the transaction
        await FirebaseFirestore.instance.collection('transactions').add({
          'from': widget.user.uid,
          'to': recipientUid,
          'amount': amount,
          'timestamp': FieldValue.serverTimestamp(),
        });
      });

      setState(() {
        _status = 'Transfer successful!';
        _amountController.clear();
        _accountController.clear();
      });
      Future.delayed(Duration(seconds: 1), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage(user: widget.user)),
        );
      });
    } catch (e) {
      setState(() => _status = 'Error: ${e.toString()}');
    }
  }

  Future<bool?> _showPasswordDialog(BuildContext context) async {
  final _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final user = FirebaseAuth.instance.currentUser;
  String? errorMessage;

  if (user == null || user.email == null) {
    // If no user or email exists
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('User not authenticated')),
    );
    return false;
  }

  return await showDialog<bool>(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setStateDialog) {
          return AlertDialog(
            title: const Text("Confirm Transaction"),
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Text(
                        errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    maxLength: 6, // 🔐 Limit to 6 characters
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your 6-digit PIN';
                      }
                      if (value.length != 6 || int.tryParse(value) == null) {
                        return 'PIN must be exactly 6 digits';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: "Enter 6-digit PIN",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: Navigator.of(context).pop,
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () async {
                  if (formKey.currentState?.validate() == true) {
                    try {
                      final credential = EmailAuthProvider.credential(
                        email: user.email!,
                        password: _passwordController.text.trim(),
                      );

                      await user.reauthenticateWithCredential(credential);

                      Navigator.of(context).pop(true);
                    } catch (e) {
                      setStateDialog(() {
                        _passwordController.clear();
                        errorMessage = 'Incorrect password. Please try again.';
                      });
                    }
                  }
                },
                child: const Text("Confirm"),
              ),
            ],
          );
        },
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFF0F1F2B,
      ), 
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
          'ABA Transfers',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              // Red circular icon with double-arrow
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withOpacity(0.5),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.compare_arrows, // Double-arrow icon
                  color: Colors.white,
                  size: 40,
                ),
              ),
              const SizedBox(height: 20),
              // Title text
              const Text(
                'Transfer to other ABA account',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              StreamBuilder<DocumentSnapshot>(
                stream:
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(widget.user.uid)
                        .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return _buildInputField(
                      icon: Icons.account_balance_wallet_outlined,
                      hintText: 'Loading balance...',
                    );
                  }
                  final userData =
                      snapshot.data!.data() as Map<String, dynamic>;
                  final balance = userData['balance']?.toString() ?? '0.00';
                  final accountNumber =
                      userData['accountNumber']?.toString() ?? '';
                  return _buildInputField(
                    icon: Icons.account_balance_wallet_outlined,
                    hintText: 'Account: $accountNumber | Balance: $balance USD',
                  );
                },
              ),
              const SizedBox(height: 15),
              // Enter receiver account number
              _buildInputField(
                icon: Icons.person_outline,
                hintText: 'Enter receiver account number',
                suffixIcon: Icons.bookmark_border,
                controller: _accountController,
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Enter account number'
                            : null,
              ),
              const SizedBox(height: 15),
              // Amount
              _buildInputField(
                icon: Icons.attach_money,
                hintText: 'Amount',
                keyboardType: TextInputType.number,
                controller: _amountController,
                validator: (value) {
                  final amount = double.tryParse(value ?? '');
                  if (amount == null || amount <= 0)
                    return 'Enter a valid amount';
                  return null;
                },
              ),
              const SizedBox(height: 15),
              // Remark (optional)
              _buildInputField(
                icon: Icons.edit_outlined,
                hintText: 'Remark (optional)',
              ),
              const SizedBox(height: 30),
              // Add to Favorites toggle
              _buildToggleRow(
                icon: Icons.star_border,
                text: 'Add to Favorites',
                value: _addToFavorites,
                onChanged: (bool newValue) {
                  setState(() {
                    _addToFavorites = newValue;
                  });
                },
              ),
              const SizedBox(height: 15),
              // Transfer as Gift toggle
              _buildToggleRow(
                icon: Icons.card_giftcard,
                text: 'Transfer as Gift',
                value: _transferAsGift,
                onChanged: (bool newValue) {
                  setState(() {
                    _transferAsGift = newValue;
                  });
                },
              ),
              const SizedBox(height: 40),
              // TRANSFER button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _transfer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'TRANSFER',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              if (_status.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(
                  _status,
                  style: TextStyle(
                    color:
                        _status.contains('success') ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build text input fields
  Widget _buildInputField({
    required IconData icon,
    required String hintText,
    IconData? suffixIcon,
    TextInputType keyboardType = TextInputType.text,
    TextEditingController? controller, // Add this for controller support
    String? Function(String?)? validator, // Add this for validation
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white12, // Darker background for input fields
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.redAccent,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.white70),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white54),
          suffixIcon:
              suffixIcon != null
                  ? Icon(suffixIcon, color: Colors.white70)
                  : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 10,
          ),
        ),
      ),
    );
  }

  // Helper method to build toggle rows
  Widget _buildToggleRow({
    required IconData icon,
    required String text,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.white70, size: 24),
            const SizedBox(width: 15),
            Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.red, // Active color for the switch
          inactiveThumbColor: Colors.grey,
          inactiveTrackColor: Colors.grey.withOpacity(0.5),
        ),
      ],
    );
  }
}
