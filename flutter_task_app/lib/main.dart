import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const MyLoginPage(),
    );
  }
}

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  // ignore: non_constant_identifier_names
  final username_controller = TextEditingController();
  // ignore: non_constant_identifier_names
  final email_controller = TextEditingController();
  // ignore: non_constant_identifier_names
  final password_controller = TextEditingController();

  late SharedPreferences logindata;
  late bool newuser;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    check_if_already_login();
  }

  // ignore: non_constant_identifier_names
  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);

   
    if (newuser == false) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MyDashboard()));
    }
  }

  @override
  void dispose() {
    
    username_controller.dispose();
    email_controller.dispose();
    password_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Unicode"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: username_controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'username'
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: email_controller,
                decoration: const InputDecoration(
                 border: OutlineInputBorder(),
                  labelText: 'email',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                obscureText: true,
                controller: password_controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  
                ),
              ),
            ),
            ElevatedButton(
              
              onPressed: () {
                String username = username_controller.text;
                String email = username_controller.text;
                String password = password_controller.text;

                if (username != '' && email != '' && password != '') {
                  logindata.setBool('login', false);

                  logindata.setString('username', username);

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const MyDashboard()));
                }
              },
              child: const Text("Log-In"),
            )
          ],
        ),
      ),
    );
  }
}