import 'package:flutter/material.dart';


class Textfi extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TextfiState();
}

class _TextfiState extends State<Textfi> {
  // Define multiple controllers for different inputs
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  
  late TextEditingController _currentController;

  @override
  void initState() {
    super.initState();
    _currentController = _controller1; // Initialize the current controller
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _currentController,
                decoration: InputDecoration(
                  hintText: 'Enter text',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Switch to the next controller and update the hint text
                  setState(() {
                    _currentController = _currentController == _controller1
                        ? _controller2
                        : _controller1;
                  });
                  _currentController.clear(); // Clear the text input
                },
                child: Text('Switch Controller'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}