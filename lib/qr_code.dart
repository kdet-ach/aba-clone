import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ABAPaymentQR extends StatelessWidget {
  final User user;
  const ABAPaymentQR({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ABA QR',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: FutureBuilder<DocumentSnapshot>(
          future:
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData || !snapshot.data!.exists) {
              return Center(child: Text('User not found'));
            }

            var userData = snapshot.data!.data() as Map<String, dynamic>;

            return Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/ad1.png', // your image
                    fit: BoxFit.cover,
                  ),
                ),

                // Dark overlay (shadow effect)
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(
                      0.9,
                    ), // adjust opacity as needed
                  ),
                ),
                SafeArea(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          children: const [
                            TextSpan(text: "ABA"),
                            TextSpan(
                              text: "'",
                              style: TextStyle(color: Colors.red),
                            ),
                            TextSpan(text: " QR"),
                          ],
                        ),
                      ),

                      const SizedBox(height: 6),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          children: [
                            const TextSpan(
                              text:
                                  "ប្រើ QR នេះ ដើម្បីទទួលប្រាក់ពីមិត្តភ័ក្តិ ឬ\nផ្ទេរប្រាក់ពីអេបធនាគាផ្សេងរបស់អ្នក",
                            ),
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                child: Icon(
                                  Icons.info_outline,
                                  size: 16,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // QR Card
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 90),
                        padding: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16),
                                ),
                              ),
                              width: double.infinity,
                              child: const Center(
                                child: Text(
                                  "KHQR",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            // PHAL SOPHANIN and ៛ 0 (left aligned only)
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  32,
                                  8,
                                  16,
                                  0,
                                ), // adjust padding as needed
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${userData['firstname'] ?? ''} ${userData['lastname'] ?? ''}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      "៛ 0",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 8),

                            // Dotted Line
                            const DottedLine(),

                            const SizedBox(height: 20),

                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                '../assets/qr.png',
                                width: 250,
                                height: 250,
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey, width: 1),
                        ),
                        child: TextButton.icon(
                          onPressed: () {
                            // Add amount action
                          },
                          icon: const Icon(
                            Icons.add_rounded,
                            color: Colors.cyanAccent,
                          ),
                          label: const Text(
                            "បញ្ចូលចំនួនទឹកប្រាក់",
                            style: TextStyle(
                              color: Colors.cyanAccent,
                              fontSize: 18,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.cyanAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(fontSize: 14),
                          children: [
                            TextSpan(
                              text: "ទទួលទៅ:",
                              style: TextStyle(color: Colors.white),
                            ),
                            TextSpan(
                              text: '${userData['accountNumber'] ?? ''}',
                              style: TextStyle(color: Colors.cyanAccent),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 16,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            _BottomIcon(
                              icon: Icons.file_download_outlined,
                              label: 'ទាញយក',
                            ),
                            _BottomIcon(icon: Icons.qr_code, label: 'ស្កេន QR'),
                            _BottomIcon(icon: Icons.link, label: 'ផ្ញើលីង'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Close Button
                // Positioned(
                //   top: 16,
                //   right: 10,
                //   child: IconButton(
                //     onPressed: () {
                //       Navigator.pop(context); 
                //     },
                //     icon: Container(
                //       decoration: BoxDecoration(
                //         shape: BoxShape.circle,
                //         color: Colors.grey[850],
                //       ),
                //       padding: const EdgeInsets.all(8),
                //       child: const Icon(Icons.close, color: Colors.white),
                //     ),
                //   ),
                // ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// ...existing code...

class _BottomIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  const _BottomIcon({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[850], // same as close icon
          ),
          padding: const EdgeInsets.all(8),
          child: Icon(icon, color: Colors.white, size: 28),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 13)),
      ],
    );
  }
}

// ...existing code...

// Dotted Line Widget
class DottedLine extends StatelessWidget {
  final double height;
  final Color color;

  const DottedLine({this.height = 1, this.color = Colors.grey});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 5.0;
        const dashSpace = 3.0;
        final dashCount = (boxWidth / (dashWidth + dashSpace)).floor();

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: height,
              child: DecoratedBox(decoration: BoxDecoration(color: color)),
            );
          }),
        );
      },
    );
  }
}
