import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

void main() {
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: Account()));
}

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(30),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 20, 81, 131),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back & Title Row
                  Row(
                    children: [
                      const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "ABA",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      const Text(
                        "'",
                        style: TextStyle(color: Colors.red, fontSize: 20),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "គណនី",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  // Wallet Summary
                  Row(
                    children: [
                      CircularPercentIndicator(
                        radius: 70.0,
                        lineWidth: 13.0,
                        animation: true,
                        percent: 0.98,
                        center: const Icon(
                          Icons.account_balance_wallet,
                          size: 40,
                          color: Colors.white,
                        ),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: Colors.cyan,
                        backgroundColor: Colors.white24,
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "ទឹកប្រាក់ដែលមាន",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          SizedBox(height: 8),
                          Divider(
                            color: Colors.white70,
                            thickness: 1,
                            endIndent: 40,
                          ),
                          SizedBox(height: 8),
                          Text(
                            "\$100,000,000",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Account Box with colored stripe
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(left: 10),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Text(
                              "Savings",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Icon(Icons.more_horiz_outlined),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "500 596 844 | Savings",
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: const [
                            Spacer(),
                            Text(
                              "\$100,000,000 USD",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Blue stripe on the left
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: 6,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 80), // space for floating button
          ],
        ),
      ),

      // Floating Add Button
      floatingActionButton: ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.add, size: 16, color: Colors.white),
        label: const Text(
          "ដាក់ប្រាក់",
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.redAccent,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 4,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
