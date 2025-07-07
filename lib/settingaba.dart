import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'loginpage.dart';

class SettingPage extends StatelessWidget {
  final User user;
  const SettingPage({super.key, required this.user});
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: screenHeight * 0.35,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/ad1.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
              ),
              Container(
                height: screenHeight * 0.20,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                  child: Container(color: Colors.transparent),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(height: 20,),
                        IconButton(
                          icon: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 35,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        SizedBox(width: 10),
                        Text(
                          'ABA',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "'",
                          style: TextStyle(color: Colors.red, fontSize: 35),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "ការកំណត់ផ្សេងៗ",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Center(
                      child: FutureBuilder<DocumentSnapshot>(
                        future:
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(user.uid)
                                .get(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }
                          if (!snapshot.hasData) {
                            return Text('User not found');
                          }
                          final user = snapshot.data!;
                          return Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 6,
                                  ),
                                ),
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundImage: AssetImage('assets/ad1.png'),
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                '${user['firstname'] ?? ''} ${user['lastname'] ?? ''}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "លេខសម្គាល់: 12345",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 90),
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.account_circle_outlined,
                                color: Colors.black,
                                size: 30,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "ប្រូហ្វាលរបស់ខ្ញុំ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.grey,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.lock_outlined,
                                color: Colors.black,
                                size: 30,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "សុវត្ថិភាព",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.grey,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.language_outlined,
                                color: Colors.black,
                                size: 30,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "ភាសា",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "ភាសាខ្មែរ",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(width: 10),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.grey,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.phone_outlined,
                                color: Colors.black,
                                size: 30,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "ទាក់ទងមកយើងខ្ញុំ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.grey,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.menu_outlined,
                                color: Colors.black,
                                size: 30,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "លក្ខខណ្ទ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.grey,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        // Container(
                        //   margin: const EdgeInsets.symmetric(horizontal: 30),
                        //   width: double.infinity,
                        //   child: ElevatedButton(
                        //     onPressed: () async {
                        //       await FirebaseAuth.instance.signOut();
                        //       Navigator.pushAndRemoveUntil(
                        //         context,
                        //         MaterialPageRoute(
                        //           builder: (_) => const LoginPage(),
                        //         ),
                        //         (route) => false,
                        //       );
                        //     },
                        //     style: ElevatedButton.styleFrom(
                        //       backgroundColor: const Color.fromARGB(
                        //         255,
                        //         201,
                        //         18,
                        //         76,
                        //       ),
                        //       padding: const EdgeInsets.symmetric(
                        //         horizontal: 160,
                        //         vertical: 18,
                        //       ),
                        //       textStyle: const TextStyle(fontSize: 18),
                        //       shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(10),
                        //       ),
                        //       elevation: 5,
                        //     ),
                        //     child: const Text(
                        //       'Logout',
                        //       style: TextStyle(color: Colors.white),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              await FirebaseAuth.instance.signOut();
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const LoginPage(),
                                ),
                                (route) => false,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 160,
                                vertical: 18,
                              ),
                              textStyle: const TextStyle(fontSize: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 5,
                            ),
                            child: const Text(
                              'Logout',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),

                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.all(2),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "កម្មវិធី កំណែៈ V 5.0.70",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                        255,
                                        218,
                                        233,
                                        219,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(
                                      "ចុងក្រោយ ✅",
                                      style: TextStyle(
                                        color: const Color.fromARGB(
                                          255,
                                          16,
                                          88,
                                          18,
                                        ),
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                    "Login ចុងក្រោយ: 14:15  |  22 មិថុនា 2025",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                    "🇰🇭 មោទនភាពស្នាដៃខ្មែរ បង្កើតនៅកម្ពុជា",
                                    style: TextStyle(
                                      color: const Color.fromARGB(
                                        255,
                                        12,
                                        43,
                                        68,
                                      ),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 50),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "ABA",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: const Color.fromARGB(
                                              255,
                                              24,
                                              87,
                                              138,
                                            ),
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "'",
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          "BANK |",
                                          style: TextStyle(
                                            color: const Color.fromARGB(
                                              255,
                                              24,
                                              87,
                                              138,
                                            ),
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Icon(
                                          Icons.flag,
                                          color: Colors.red,
                                          size: 20,
                                        ),
                                        Text(
                                          "Nationnal Bank",
                                          style: TextStyle(
                                            color: const Color.fromARGB(
                                              255,
                                              24,
                                              87,
                                              138,
                                            ),
                                            fontSize: 5,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
