import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        textTheme: const TextTheme(
            bodyLarge: TextStyle(fontSize: 30),
            labelMedium: TextStyle(fontSize: 15)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Muhammad app'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _counVal = 1;
  List<String> todos = [];
  void contintVal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = prefs.getInt('counter') ?? 0;
      todos = prefs.getStringList('todos') ?? [];
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      contintVal();
    });
  }

  Future<void> _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter += _counVal;
      prefs.setInt('counter', _counter);
    });
  }

  Future<void> _dincrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter -= _counVal;
      prefs.setInt('counter', _counter);
    });
  }

  Future<void> _reset() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = 0;
      prefs.setInt('counter', _counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Click on text to reset:',
            ),
            GestureDetector(
              child: Text(
                '$_counter',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              onTap: () {
                setState(() {
                  _reset();
                });
              },
            ),
            Container(
                width: _width * 0.5,
                height: _height * 0.06,
                child: TextField(
                  onChanged: (String v) {
                    setState(() {
                      _counVal = v.isNotEmpty ? int.parse(v) : 1;
                      if (kDebugMode) {
                        print(_counVal);
                      }
                    });
                  },
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      hintText: 'cont',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 0),
                          borderRadius:
                              BorderRadius.all(Radius.circular(1000)))),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  style: Theme.of(context).textTheme.labelMedium,
                ))
          ],
        ),
      ),
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
        const SizedBox(
          height: 10,
        ),
        FloatingActionButton(
          onPressed: _dincrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.minimize),
        )
      ]), 
    );
  }
}
