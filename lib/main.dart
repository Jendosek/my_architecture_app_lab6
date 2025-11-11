import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:my_architecture_app/di/injection_container.dart';
import 'package:my_architecture_app/ui/pages/login/login_page.dart';
import 'package:my_architecture_app/ui/pages/login/login_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initDependencyInjection();
  runApp(
    ChangeNotifierProvider(
      create: (context) => LoginProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Musify',
      theme: ThemeData.dark().copyWith(primaryColor: Colors.deepPurple),
      home: LoginPage(),
    );
  }
}
