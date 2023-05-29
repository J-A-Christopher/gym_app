import 'package:flutter/material.dart';
import 'package:gym_app/providers/arms_provider.dart';
import 'package:gym_app/providers/back_provider.dart';
import 'package:gym_app/providers/chest_provider.dart';
import 'package:gym_app/providers/legs_provider.dart';
import './screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LegsProvider>(
            create: (context) => LegsProvider()),
        ChangeNotifierProvider<ArmsProvider>(
            create: (context) => ArmsProvider()),
        ChangeNotifierProvider<BackProvider>(
            create: (context) => BackProvider()),
        ChangeNotifierProvider<ChestProvider>(
            create: (context) => ChestProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo)
                .copyWith(secondary: Colors.orange)),
        home: const HomeScreen(),
      ),
    );
  }
}
