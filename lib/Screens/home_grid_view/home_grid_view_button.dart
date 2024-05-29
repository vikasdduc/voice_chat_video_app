
import 'package:call_app/Screens/Location_screen/location_view.dart';
import 'package:call_app/Screens/voice_call/join_voice_call_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeGridViewButton extends StatefulWidget {
  const HomeGridViewButton({super.key});

  @override
  State<HomeGridViewButton> createState() => _HomeGridViewButtonState();
}

class _HomeGridViewButtonState extends State<HomeGridViewButton> {
  final List<Color> _colors = [
    Colors.red,
    Colors.blue,
    Colors.yellow,
    Colors.purple
  ];

  final List<Icon> _icons = [
    Icon(Icons.location_on_outlined,size: 50,),
    Icon(Icons.record_voice_over_outlined,size: 50),
    Icon(Icons.energy_savings_leaf_outlined,size: 50),
    Icon(Icons.shopping_bag_outlined,size: 50),
  ];

  final List<Text> _buttonText = [
    Text("Location",style: const TextStyle(fontSize: 20, color: Colors.white)),
    Text("Talk Group",style: const TextStyle(fontSize: 20, color: Colors.white)),
    Text("Surroundings",style: const TextStyle(fontSize: 20, color: Colors.white)),
    Text("Buy Helmet",style: const TextStyle(fontSize: 20, color: Colors.white)),
  ];
  final List<Color> _defaultColor = [
    Colors.red.shade200,
    Colors.blue.shade200,
    Colors.yellow.shade200,
    Colors.purple.shade200
  ];
  //final Color _defaultColor = Colors.greenAccent;
  late List<Color> _currentColors;

  @override
  void initState() {
    super.initState();
    _currentColors = List.from(_defaultColor);
  }

  void _onButtonPressed(int index) {
    if(index == 0){
      Navigator.push(context, MaterialPageRoute(builder: (context) => GoogleMapPage()));
    }
    if(index == 1){
      Navigator.push(context, MaterialPageRoute(builder: (context) => VoiceCallScreen()));
    }
    // Handle button press action here GoogleMapPage
    print("Button ${index + 1} pressed");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text("Home"),
      // ),

      body: Column(
        children: [
          SizedBox(height: 50,),
          Expanded(
            child: Padding(
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
                            _icons[index],
                            SizedBox(height: 10),
                            _buttonText[index]
            
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
