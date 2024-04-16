import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ApvTypePage extends StatefulWidget {
  final String industry;

  const ApvTypePage({super.key, required this.industry});

  @override
  _ApvTypePageState createState() => _ApvTypePageState();
}


class _ApvTypePageState extends State<ApvTypePage> {

  List types = ["murervirksomheder"];
  String? selectedType;


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
        centerTitle: true, // Centering the title
        title: Text("Vælg underbranche"), // Add your title here
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
    );
        
  }
}