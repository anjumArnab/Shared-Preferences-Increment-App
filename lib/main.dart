import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CounterProvider(),
      child: const TiltCounter(),
    ),
  );
}

class TiltCounter extends StatelessWidget {
  const TiltCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tilt Counter',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const MyHomePage(title: 'Tilt Counter'),
    );
  }
}

class CounterProvider extends ChangeNotifier {
  int _counter = 0;
  double _angle = 0.0;

  int get counter => _counter;
  double get angle => _angle;

  CounterProvider() {
    _loadCounter();
  }

  void _loadCounter() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _counter = pref.getInt("counter") ?? 0;
    notifyListeners();
  }

  void _saveCounter() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("counter", _counter);
  }

  void updateTilt(double delta) {
    _angle += delta * 0.1;
    if (_angle > 0.1) {
      _counter++;
      _angle = 0.0;
    } else if (_angle < -0.1) {
      _counter--;
      _angle = 0.0;
    }
    _saveCounter();
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final counterProvider = Provider.of<CounterProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Text(title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'You have tilted the box this many times:',
          ),
          Text(
            '${counterProvider.counter}',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 40),
          Center(
            child: GestureDetector(
              onHorizontalDragUpdate: (details) =>
                  counterProvider.updateTilt(details.delta.dx),
              child: Transform.rotate(
                angle: counterProvider.angle,
                child: Container(
                  width: 100,
                  height: 30,
                  color: Colors.lime,
                  alignment: Alignment.center,
                  child: const Text(
                    "Tilt Me",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
