import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Color> _colors = [
    Colors.redAccent,
    Colors.blueAccent,
    Colors.yellowAccent,
    Colors.purpleAccent
  ];

  final Color _defaultColor = Colors.greenAccent;
  late List<Color> _currentColors;

  @override
  void initState() {
    super.initState();
    _currentColors = List.filled(4, _defaultColor);
  }

  void _onButtonPressed(int index) {
    // Handle button press action here
    print("Button ${index + 1} pressed");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Helmet App Home'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: 4,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  _currentColors[index] = _colors[index];
                });
                _onButtonPressed(index);
              },
              child: Card(
                color: _currentColors[index],
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add, // Use appropriate icons or images
                        size: 40,
                        color: Colors.white,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Button ${index + 1}',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
