import 'package:flutter/material.dart';
import 'form.dart'; // Import the form page

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MovieMuse',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < 1) {
      _currentPage += 1;
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FormPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: <Widget>[
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: <Widget>[
                _buildPage('Hi there! 👋'),
                _buildPage('Welcome to MovieMuse!'),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: _nextPage,
            child: Text('Next'),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildPage(String text) {
    return Center(
      child: Text(
        text,
        style: TextStyle(fontSize: 24, color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }
}
