import 'dart:ui';
import 'dart:async';
import 'package:aba_app/settingaba.dart';
import 'package:flutter/material.dart';

// Import your TransferList page directly
import 'transfers_list.dart';

void main() {
  runApp(const MainApp()); // Make MainApp const if possible
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Define your app-wide theme here
      theme: ThemeData(
        brightness: Brightness.dark, // Set dark mode for the whole app
        primaryColor: Colors.red,
        fontFamily: 'Arial',
        scaffoldBackgroundColor: const Color(0xFF0F1F2B), // Dark background for scaffolds
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent, // AppBar background
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white), // Default icon color for app bars
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold), // AppBar title style
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          // Define other text styles as needed for your dark theme
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> data = [
    {'image': 'assets/Accounts.png', 'title': 'Accounts'},
    {'image': 'assets/Cards.png', 'title': 'Cards'},
    {'image': 'assets/Payments.png', 'title': 'Payments'},
    {'image': 'assets/Scan.png', 'title': 'Scan'},
    {'image': 'assets/Favorites.png', 'title': 'Favorites'},
    {'image': 'assets/Transfers.png', 'title': 'Transfers'},
  ];

  final List<Map<String, dynamic>> list = [
    {'image': 'assets/Navi.png', 'title': 'Navi'},
    {'image': 'assets/Government Services.png', 'title': 'Government Services'},
    {'image': 'assets/Gift Zone.png', 'title': 'Gift Zone'},
    {'image': 'assets/Services.png', 'title': 'Services'},
    {'image': 'assets/Analytics.png', 'title': 'Analytics'},
    {'image': 'assets/E-cash.png', 'title': 'E-cash'},
    {'image': 'assets/new-account.png', 'title': 'New Account'},
    {'image': 'assets/Schedules.png', 'title': 'Schedules'},
    {'image': 'assets/Invite Friend.png', 'title': 'Invite Friend'},
    {'image': 'assets/Loans.png', 'title': 'Loans'},
    {'image': 'assets/Transfers.png', 'title': 'ABA Cashback'},
    {'image': 'assets/Transfers.png', 'title': 'Exchange Rate'},
    {'image': 'assets/Transfers.png', 'title': 'Locator'},
    {'image': 'assets/Transfers.png', 'title': 'Checkbook'},
  ];

  final List<Map<String, dynamic>> ad = [
    {'image': 'assets/ad1.png'},
    {'image': 'assets/ad2.jpg'},
    {'image': 'assets/ad3.jpg'},
    {'image': 'assets/ad4.jpg'},
  ];

  late final PageController _adPageController;
  Timer? _adTimer;
  int _currentAdPage = 0;

  @override
  void initState() {
    super.initState();
    _adPageController = PageController(viewportFraction: 1);
    // Use a delayed initialization for the timer to avoid potential issues during hot reload
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _adTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
        if (!mounted) return;
        setState(() {
          // Loop the ad pages
          _currentAdPage = (_currentAdPage + 1) % ad.length;
          _adPageController.animateToPage(
            _currentAdPage,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        });
      });
    });
  }

  @override
  void dispose() {
    _adTimer?.cancel();
    _adPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The body content remains the same, adjusted for the dark theme
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          color: const Color(0xFF0F1F2B), // Ensure consistent background
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top -----------------------------------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Icon(Icons.message_outlined, color: Colors.white),
                  SizedBox(width: 20),
                  Icon(Icons.notifications_outlined, color: Colors.white),
                  SizedBox(width: 20),
                  Icon(Icons.qr_code_outlined, color: Colors.white),
                ],
              ),
              // User ----------------------------------------------------------
              const SizedBox(height: 16),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SettingPage()),
                      );
                    },
                    icon: const Icon(
                      Icons.account_circle_sharp,
                      size: 64,
                      color: Colors.blueGrey,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Good Morning!',
                        style: TextStyle(color: Colors.white54), // Adjusted for dark theme
                      ),
                      Text(
                        'Kan Chanborey',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Adjusted for dark theme
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // Balance -------------------------------------------------------
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(20.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.yellow.shade300, Colors.yellow.shade400],
                  ),
                ),
                // Content -----------------------------------------------------
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.orange.shade300,
                                Colors.orange.shade400,
                              ],
                            ),
                          ),
                          child: const Text(
                            '\$ 1.571.237.48',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey,
                          ),
                          child: const Icon(Icons.visibility_outlined, size: 23),
                        ),
                      ],
                    ),
                    // ---------------------------------------------------------
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(7),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.orange.shade300,
                                Colors.orange.shade400,
                              ],
                            ),
                          ),
                          child: const Text(
                            'Default',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          'Savings',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                    // ---------------------------------------------------------
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 370),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _action(Icons.call_received, 'Receive'),
                            _action(Icons.send_sharp, 'Send'),
                            const Text('|'),
                            _action(Icons.analytics, 'Analytics'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Grid View -----------------------------------------------------
              const SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 1,
                ),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      // Navigate to ABATransferPage when 'Transfers' is tapped
                      if (data[index]['title'] == 'Transfers') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ABATransferPage()),
                        );
                      }
                      // You can add more specific navigation for other items if needed
                      // else if (data[index]['title'] == 'Accounts') {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(builder: (context) => AccountsPage()),
                      //   );
                      // }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white, // Ensure grid items are visible
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            data[index]['image'].toString(),
                            height: 50,
                            width: 50,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            data[index]['title'].toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                              color: Colors.black, // Text color for grid items
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              // Divider -------------------------------------------------------
              const SizedBox(height: 10),
              const Divider(thickness: 1, color: Colors.black26),
              // List View -----------------------------------------------------
              SizedBox(
                height: 65,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      margin: const EdgeInsets.only(right: 10, top: 8, bottom: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            list[index]['image'].toString(),
                            height: 35,
                            width: 35,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            list[index]['title'].toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              // New & Promotions ----------------------------------------------
              const SizedBox(height: 20),
              const Text(
                'News & Promotions',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  color: Colors.white, // Adjusted for dark theme
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 160,
                child: PageView.builder(
                  controller: _adPageController,
                  itemBuilder: (context, index) {
                    final adIndex = index % ad.length;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          ad[adIndex]['image'].toString(),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Explore Services ----------------------------------------------
              const SizedBox(height: 30),
              const Text(
                'Explore Services', // Corrected typo from 'Exolore'
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  color: Colors.white, // Adjusted for dark theme
                ),
              ),
              const SizedBox(height: 15),
              RepaintBoundary(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        'assets/ad1.png',
                        width: double.infinity,
                        height: 120,
                        fit: BoxFit.cover,
                        color: Colors.white.withOpacity(
                            0.9), // Original code used BlendMode.modulate, but this provides a more direct opacity control
                        colorBlendMode: BlendMode.modulate, // Retained original blend mode
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                        child: SizedBox(
                          width: double.infinity,
                          height: 120,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                child: Container(
                                  width: 50,
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 2,
                                            color: Colors.black, // Border color for inner container
                                          ),
                                          borderRadius: BorderRadius.circular(12),
                                          color: Colors.white, // Background for the icon/image
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: Image.asset(
                                            list[index]['image'].toString(),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        list[index]['title'].toString(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Government Services (renamed to avoid confusion with the Explore Services blur effect)
              // If this section is distinct, consider using unique image assets
              const SizedBox(height: 30),
              const Text(
                'More Services', // Renamed from 'Government Services' to 'More Services'
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: ad.length, // Assuming 'ad' is just example images, adjust as needed
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Container(
                        width: 110,
                        margin: const EdgeInsets.only(right: 15),
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(width: 2, color: Colors.transparent), // Border around the card
                          color: Colors.transparent,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.blue, // This blue will be underneath the image
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset(
                                  ad[index]['image'].toString(), // Using 'ad' images here
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                height: double.infinity,
                                width: double.infinity,
                                padding: const EdgeInsets.only(left: 10, bottom: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.white.withOpacity(0),
                                      Colors.black.withOpacity(1),
                                    ],
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      list[index]['title'].toString(), // Using 'list' titles here
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _action(IconData icon, String lable) {
  return Row(
    children: [
      Icon(icon, size: 20, color: Colors.black87), // Ensure icon color is visible on yellow background
      const SizedBox(width: 16),
      Text(lable, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)), // Ensure text color is visible
    ],
  );
}