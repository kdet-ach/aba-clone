import 'dart:ui';
import 'dart:async';
import 'package:aba_app/settingaba.dart';
import 'package:flutter/material.dart';

import 'qr_code.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}

class HomePage extends StatefulWidget {
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
    _adTimer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (!mounted) return;
      setState(() {
        _currentAdPage = (_currentAdPage + 1);
        _adPageController.animateToPage(
          _currentAdPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          color: Colors.white10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top -----------------------------------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.message_outlined),
                  SizedBox(width: 20),
                  Icon(Icons.notifications_outlined),
                  SizedBox(width: 20),
                  Icon(Icons.qr_code_outlined),
                ],
              ),
              // User ----------------------------------------------------------
              SizedBox(height: 16),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SettingPage()),
                      );
                    },
                    icon: Icon(
                      Icons.account_circle_sharp,
                      size: 64,
                      color: Colors.blueGrey,
                    ),
                  ),
                  // Icon(
                  //   Icons.account_circle_sharp,
                  //   size: 64,
                  //   color: Colors.blueGrey,
                  // ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good Morning!',
                        style: TextStyle(color: Colors.black54),
                      ),
                      Text(
                        'Kan Chanborey',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // Balance -------------------------------------------------------
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(20.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
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
                          padding: EdgeInsets.symmetric(
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
                          child: Text(
                            '\$ 1.571.237.48',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey,
                          ),
                          child: Icon(Icons.visibility_outlined, size: 23),
                        ),
                      ],
                    ),
                    // ---------------------------------------------------------
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
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
                          child: Text(
                            'Default',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
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
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        constraints: BoxConstraints(maxWidth: 370),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _action(Icons.call_received, 'Receive'),
                            _action(Icons.send_sharp, 'Send'),
                            Text('|'),
                            _action(Icons.analytics, 'Analytics'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Grid View -----------------------------------------------------
              SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 1.3,
                ),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ABAPaymentQR()),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
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
                          SizedBox(height: 10),
                          Text(
                            data[index]['title'].toString(),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              // Divider -------------------------------------------------------
              SizedBox(height: 10),
              Divider(thickness: 1, color: Colors.black26),
              // List View -----------------------------------------------------
              SizedBox(
                height: 65,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      margin: EdgeInsets.only(right: 10, top: 8, bottom: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue,
                        boxShadow: [
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
                          SizedBox(width: 10),
                          Text(
                            list[index]['title'].toString(),
                            style: TextStyle(
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
              SizedBox(height: 20),
              Text(
                'News & Promotions',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                height: 160,
                child: PageView.builder(
                  controller: _adPageController,
                  itemBuilder: (context, index) {
                    final adIndex = index % ad.length;
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3),
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
              SizedBox(height: 30),
              Text(
                'Exolore Services',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              SizedBox(height: 15),

              // RepaintBoundary(
              //   child: Stack(
              //     children: [
              //       ClipRRect(
              //         borderRadius: BorderRadius.circular(15),
              //         child: Image.asset(
              //           'assets/ad1.png',
              //           width: double.infinity,
              //           height: 130,
              //           fit: BoxFit.cover,
              //         ),
              //       ),
              //       ClipRRect(
              //         borderRadius: BorderRadius.circular(15),
              //         child: BackdropFilter(
              //           filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              //           child: Container(
              //             width: double.infinity,
              //             height: 130,
              //             color: Colors.black.withOpacity(0.2),
              //             child: ListView.builder(
              //               scrollDirection: Axis.horizontal,
              //               itemCount: list.length,
              //               itemBuilder: (context, index) {
              //                 return Container(
              //                   width: 100,
              //                   padding: EdgeInsets.all(10),
              //                   decoration: BoxDecoration(
              //                           border: Border.all(
              //                             width: 2,
              //                             color: Colors.white,
              //                           ),
              //                           borderRadius: BorderRadius.circular(10),
              //                         ),
              //                   child: Column(
              //                     mainAxisAlignment: MainAxisAlignment.start,
              //                     crossAxisAlignment: CrossAxisAlignment.center,
              //                     children: [
              //                       Container(
              //                         width: 50,
              //                         height: 50,
              //                         decoration: BoxDecoration(
              //                           border: Border.all(
              //                             width: 2,
              //                             color: Colors.white,
              //                           ),
              //                           borderRadius: BorderRadius.circular(10),
              //                         ),
              //                         child: Image.asset(
              //                           list[index]['image'].toString(),
              //                           height: 40,
              //                           width: 40,
              //                         ),
              //                       ),
              //                       SizedBox(height: 5),
              //                       Text(
              //                         list[index]['title'].toString(),
              //                         style: TextStyle(
              //                           fontSize: 16,
              //                           color: Colors.white,
              //                         ),
              //                         overflow: TextOverflow.fade,
              //                         maxLines: 2,
              //                         textAlign: TextAlign.center,
              //                       ),
              //                     ],
              //                   ),
              //                 );
              //               },
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

              // RepaintBoundary(
              //   child: Stack(
              //     children: [
              //       ClipRRect(
              //         borderRadius: BorderRadius.circular(15),
              //         child: Image.asset(
              //           'assets/ad1.png',
              //           width: double.infinity,
              //           height: 120,
              //           fit: BoxFit.cover,
              //         ),
              //       ),
              //       ClipRRect(
              //         borderRadius: BorderRadius.circular(15),
              //         child: BackdropFilter(
              //           filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              //           child: Container(
              //             width: double.infinity,
              //             height: 120,
              //             color: Colors.black.withOpacity(0.2),
              //             child: ListView.builder(
              //               scrollDirection: Axis.horizontal,
              //               itemCount: list.length,
              //               itemBuilder: (context, index) {
              //                 return Container(
              //                   padding: EdgeInsets.all(25),
              //                   width: 100,
              //                   child: Column(
              //                     children: [
              //                       Container(
              //                         width: 40,
              //                         height: 40,
              //                         decoration: BoxDecoration(
              //                           border: Border.all(
              //                             width: 2,
              //                             color: Colors.white,
              //                           ),
              //                           borderRadius: BorderRadius.circular(10),
              //                         ),
              //                         child: Image.asset(
              //                           list[index]['image'].toString(),
              //                         ),
              //                       ),
              //                       SizedBox(height: 10),
              //                       Text(
              //                         list[index]['title'].toString(),
              //                         style: TextStyle(
              //                           fontSize: 14,
              //                           color: Colors.white,
              //                         ),
              //                         maxLines: 1,
              //                         overflow: TextOverflow.ellipsis,
              //                         textAlign: TextAlign.center,
              //                       ),
              //                     ],
              //                   ),
              //                 );
              //               },
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
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
                                  padding: EdgeInsets.symmetric(vertical: 10),
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
                                            color: Colors.black,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          color: Colors.white,
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          child: Image.asset(
                                            list[index]['image'].toString(),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        list[index]['title'].toString(),
                                        style: TextStyle(
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
              // Government Services -------------------------------------------
              SizedBox(height: 30),
              Text(
                'Government Services',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              SizedBox(height: 15),
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
                          0.9,
                        ), // Your desired opacity
                        colorBlendMode:
                            BlendMode
                                .modulate, // Blend mode to apply transparency
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
                                  padding: EdgeInsets.symmetric(vertical: 10),
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
                                            color: Colors.black,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          color: Colors.white,
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          child: Image.asset(
                                            list[index]['image'].toString(),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        list[index]['title'].toString(),
                                        style: TextStyle(
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
              // Discoveries ---------------------------------------------------
              SizedBox(height: 30),
              Text(
                'Government Services',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: ad.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Container(
                        width: 110,
                        margin: EdgeInsets.only(right: 15),
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(width: 2),
                          color: Colors.transparent,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.blue,
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset(
                                  ad[index]['image'].toString(),
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                height: double.infinity,
                                width: double.infinity,
                                // color: Colors.black,
                                padding: EdgeInsets.only(left: 10, bottom: 5),
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
                                      list[index]['title'].toString(),
                                      style: TextStyle(
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
      Icon(icon, size: 20),
      SizedBox(width: 16),
      Text(lable, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    ],
  );
}
