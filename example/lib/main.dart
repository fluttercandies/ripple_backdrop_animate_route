import 'package:flutter/material.dart';

import 'package:ripple_backdrop_animate_route/ripple_backdrop_animate_route.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Demo Home Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text('Click button to see the page.'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          RippleBackdropAnimatePage.show(
            context: context,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const <Widget>[
                Text('This is ripple backdrop animate page.'),
              ],
            ),
            childFade: true,
            duration: 300,
            blurRadius: 20.0,
            bottomButton: const Icon(Icons.visibility),
            bottomHeight: 60.0,
            bottomButtonRotate: false,
          );
        },
        tooltip: 'Push to page',
        child: const Icon(Icons.arrow_forward),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
