import 'package:flutter/material.dart';
import 'loginpage.dart';
import 'registerpage.dart'; 

// void main() {
//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {    
    return MaterialApp(
      title: 'ABA Mobile',
      home: const MyHomePage(title: 'ABA Mobile Home Page'),
    );
  }
}

void _onLoginPressed(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => LoginPage()),
  );
}
void _onRegisterPressed(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => RegisterPage()),
  );
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Aligns children at the start of the column
          children: [
            Container(
              margin: const EdgeInsets.only(top: 250), // Adds space at the top
              child: const Text(
                'ABA Mobile',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal, color: Colors.white),
              ),
              
            ),
            const SizedBox(height: 20),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Container(
            //       width: 450,
            //       padding: const EdgeInsets.all(10),
            //       height: 50,
            //       margin: const EdgeInsets.only(top: 20), // Adds space at the bottom
            //       child: const Text('Login',
            //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.white),
            //   ),
            //   alignment: Alignment.center,
            //   decoration: BoxDecoration(
            //     color: const Color.fromARGB(255, 201, 18, 76),
            //     borderRadius: BorderRadius.circular(10),
            //   ),
              
            // ),
            //   ]
            //   ),
              const SizedBox(height: 10),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Container(
            //       width: 450,
            //       padding: const EdgeInsets.all(10),
            //       height: 50,
            //       margin: const EdgeInsets.only(top: 10), // Adds space at the bottom
            //       child: const Text(
            //         'Register',
            //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.white),
            //   ),
            //   alignment: Alignment.center,
            //   decoration: BoxDecoration(
            //     color: const Color.fromARGB(255, 201, 18, 76),
            //     borderRadius: BorderRadius.circular(10),
            //   ),
              
            // ),
            //   ]
            //   ),
            const SizedBox(height: 300),
            ElevatedButton(
              onPressed: () => _onLoginPressed(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 201, 18, 76), // Button color
                padding: const EdgeInsets.symmetric(horizontal: 160, vertical: 18),
                textStyle: const TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
                elevation: 5, // Add a shadow
              ),
              child: const Text(
                'Login',
                style: TextStyle(color: Colors.white), // Text color
                ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _onRegisterPressed(context), // Assign the placeholder login function
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 201, 18, 76), // Button color
                padding: const EdgeInsets.symmetric(horizontal: 155, vertical: 18),
                textStyle: const TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
                elevation: 5, // Add a shadow
              ),
              child: const Text(
                'Register',
                style: TextStyle(color: Colors.white), // Text color
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 14, 89, 150),
    );
  }
}
