import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '/home.dart';

class ApvTypePage extends StatefulWidget {
  final String industry;

  const ApvTypePage({super.key, required this.industry});

  @override
  _ApvTypePageState createState() => _ApvTypePageState();
}


class _ApvTypePageState extends State<ApvTypePage> {

  List types = [];
  String? selectedType;

 @override
  void initState() {
    super.initState();

    types = ["Murervirksomheder", "VVS"];

  }
  @override
  Widget build(BuildContext context) {
    
        return Scaffold(
          appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios,
          size: 20,
          color: Colors.black,),
        ),
        centerTitle: true,
        title: Text("Vælg underbranche"), 
      ),
          body: Align(
            alignment: Alignment.center,
           child: ListView.builder(
        itemCount: types.length,
        itemBuilder: (context, index) {
          final type = types[index];
          return ListTile(
            leading: Radio<String>(
              value: type,
              groupValue: selectedType,
              onChanged: (String? value) {
                setState(() {
                  selectedType = value;
                });
              },
            ),
            title: Text(type),
            onTap: () {
              setState(() {
                selectedType = type;
              });
            },
          );
        },
      ),
    ),
    bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: selectedType != null ? () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } : null, // Disable the button if no type is selected
          child: Text('Næste'),
        ),
      ),
    );
        
  }
}