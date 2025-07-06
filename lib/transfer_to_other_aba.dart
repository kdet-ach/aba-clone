// transfer_to_other_aba.dart
import 'package:flutter/material.dart';
// You will need to add the 'qr_flutter' package to your pubspec.yaml if you use it elsewhere.
// This page itself does not directly require 'qr_flutter'.

class TransferToOtherABAPage extends StatefulWidget {
  const TransferToOtherABAPage({super.key});

  @override
  State<TransferToOtherABAPage> createState() => _TransferToOtherABAPageState();
}

class _TransferToOtherABAPageState extends State<TransferToOtherABAPage> {
  String? _selectedAccount; // For the dropdown
  bool _addToFavorites = false;
  bool _transferAsGift = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1F2B), // Consistent with your app's dark theme
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
            // Select your account dropdown
            _buildInputFieldWithDropdown(
              context,
              icon: Icons.account_balance_wallet_outlined,
              hintText: 'Select your account',
              value: _selectedAccount,
              items: const ['Savings: 0.00 USD', 'Current: 1000.00 USD'], // Example items
              onChanged: (String? newValue) {
                setState(() {
                  _selectedAccount = newValue;
                });
              },
            ),
            const SizedBox(height: 15),
            // Enter receiver account number
            _buildInputField(
              icon: Icons.person_outline,
              hintText: 'Enter receiver account number',
              suffixIcon: Icons.bookmark_border,
            ),
            const SizedBox(height: 15),
            // Amount
            _buildInputField(
              icon: Icons.attach_money,
              hintText: 'Amount',
              keyboardType: TextInputType.number,
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
                onPressed: () {
                  // Handle transfer logic here
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Transfer button pressed!')),
                  );
                },
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
          ],
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
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white12, // Darker background for input fields
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.redAccent,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.white70),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white54),
          suffixIcon: suffixIcon != null ? Icon(suffixIcon, color: Colors.white70) : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        ),
      ),
    );
  }

  // Helper method to build dropdown input field
  Widget _buildInputFieldWithDropdown(
    BuildContext context, {
    required IconData icon,
    required String hintText,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Row(
            children: [
              Icon(icon, color: Colors.white70),
              const SizedBox(width: 10),
              Text(hintText, style: const TextStyle(color: Colors.white54)),
            ],
          ),
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white70),
          dropdownColor: const Color(0xFF1E2B38), // Darker background for dropdown menu
          style: const TextStyle(color: Colors.white, fontSize: 16),
          isExpanded: true,
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
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
