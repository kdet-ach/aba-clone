import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _onLoginPressed() {
    if (_formKey.currentState!.validate()) {
      // Handle login logic here
      print('Username: ${_usernameController.text}');
      print('PIN: ${_pinController.text}');
      // Navigate or show success message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 14, 89, 150),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'ABA Mobile',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  const Icon(Icons.lock, size: 60, color: Colors.white),
                  const SizedBox(height: 20),
                  const Text(
                    "Create Login Security PIN",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "This PIN will be required every time you log into your ABA Mobile account.",
                    style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.person),
                      filled: true,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    controller: _pinController,
                    decoration: const InputDecoration(
                      labelText: 'Create 6-digit PIN',
                      prefixIcon: Icon(Icons.lock),
                      filled: true,
                      
                    ),
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your PIN';
                      }
                      if (value.length != 6 || int.tryParse(value) == null) {
                        return 'PIN must be 6 digits';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 250),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _onLoginPressed,
                      
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 201, 18, 76),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        
                        textStyle: const TextStyle(fontSize: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5,
                      ),
                      child: const Text('Login',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginPage(),
  ));
} 