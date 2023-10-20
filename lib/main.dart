import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 215, 102, 36)),
        useMaterial3: true,
      ),
      home: const HomeComponents(
          title: 'Florian Huguet', description: "Nombre :"),
    );
  }
}

class HomeComponents extends StatefulWidget {
  const HomeComponents(
      {super.key, required this.title, required this.description});

  final String title;
  final String description;
  @override
  State<HomeComponents> createState() => _HomeComponentsState();
}

class _HomeComponentsState extends State<HomeComponents> {
  int _counter = 0;
  bool _showCalculator = true;

  List<String> imagePaths = [
    'lib/assets/img/abel.png',
    'lib/assets/img/image2.png',
  ];

  late String currentImagePath;

  @override
  void initState() {
    super.initState();
    currentImagePath = randomImage();
  }

  String randomImage() {
    final randomIndex = Random().nextInt(imagePaths.length);
    return imagePaths[randomIndex];
  }

  void _updateCounter(int num) {
    setState(() {
      _counter = num;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text(widget.title, style: TextStyle(color: Colors.white)),
      ),
      backgroundColor: Colors.grey[800],
      body: _showCalculator
          ? Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomRight,
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      '$_counter',
                      style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.w200,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.black,
                  child: Column(
                    children: [
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(20),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1.0,
                          crossAxisSpacing: 20.0,
                          mainAxisSpacing: 20.0,
                        ),
                        itemCount: 9,
                        itemBuilder: (context, index) {
                          return TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              shape: const CircleBorder(),
                              backgroundColor: Colors.grey[700],
                              padding: const EdgeInsets.all(15),
                            ),
                            onPressed: () => _updateCounter(index + 1),
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                            ),
                            backgroundColor: Colors.grey[700],
                            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                          ),
                          onPressed: () => _updateCounter(0),
                          child: const Text(
                            '0',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Center(child: Image.asset(currentImagePath)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _showCalculator = !_showCalculator;
            if (!_showCalculator) {
              currentImagePath = randomImage();  // Mettez à jour l'image chaque fois que vous passez au mode image
            }
          });
        },
        child: Icon(_showCalculator ? Icons.image : Icons.calculate),
      ),
    );
  }
}
