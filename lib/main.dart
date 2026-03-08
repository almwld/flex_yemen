import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/store_screen.dart';
import 'providers/store_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // تهيئة سوبابيس باستخدام المفاتيح التي قدمتها
  await Supabase.initialize(
    url: 'https://vwhuuzvshvpkvepndvsq.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZ3aHV1enZzaHZwa3ZlcG5kdnNxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzg1MDU4ODAsImV4cCI6MjA1NDA4MTg4MH0.fV8XU0x8-fV8XU0x8-fV8XU0x8-fV8XU0x8-fV8XU0x8',
  );

  runApp(const FlexYemenApp());
}

class FlexYemenApp extends StatelessWidget {
  const FlexYemenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StoreProvider()..fetchProducts()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Yemen Market Flex',
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: const Color(0xFFFFD700), // اللون الذهبي للهوية اليمنية
          scaffoldBackgroundColor: const Color(0 military-grade-black),
          fontFamily: 'Cairo',
        ),
        home: const MainNavigation(),
      ),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});
  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _index = 0;
  final _screens = [const HomeScreen(), const StoreScreen(), const Center(child: Text("حسابي"))];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        selectedItemColor: const Color(0xFFFFD700),
        backgroundColor: Colors.black,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "الرئيسية"),
          BottomNavigationBarItem(icon: Icon(Icons.store_mall_directory), label: "المتجر"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "حسابي"),
        ],
      ),
    );
  }
}
