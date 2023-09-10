import 'package:flutter/material.dart';


import 'package:flutter_task_app/weather.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const MyDashboard(),
    );
  }
}

class MyDashboard extends StatefulWidget {
  const MyDashboard({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyDashboardState createState() => _MyDashboardState();
}

class _MyDashboardState extends State<MyDashboard> {
  late SharedPreferences logindata;
  late String username;
  Future<void> initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username') ?? 'Unknown User';
    });
  }

  @override
  void initState() {
    super.initState();
    initial();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                'Hello  $username',
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                logindata.setBool('login', true);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyLoginPage()));
              },
              child: const Text('LogOut'),
            ),
            const SizedBox(height: 50,),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WeatherPage()));
                },
                child: const Text('Weather')),
            
          ],
        ),
      ),
    );
  }
}
