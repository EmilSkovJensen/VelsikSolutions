import 'package:flutter/material.dart';
<<<<<<< Updated upstream
import 'package:velsik/home.dart';
import 'package:velsik/services/apvservice.dart';
=======
import 'package:flutter/rendering.dart';
import 'choose-questions.dart';
>>>>>>> Stashed changes

class ApvTypePage extends StatefulWidget {
  final String industry;

  const ApvTypePage({super.key, required this.industry});

  @override
  _ApvTypePageState createState() => _ApvTypePageState();
}


class _ApvTypePageState extends State<ApvTypePage> {
  final ApvService apvService = ApvService();
  List<String> apvTypes = [];
  String? selectedType;

 @override
  void initState() {
    super.initState();

    apvService.getApvTypesByIndustry(widget.industry).then((types) {
      if(types != null){
        setState(() {
          apvTypes = types;
        });
      } 
    });
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
        title: const Text("Vælg typen"), 
      ),
          body: Align(
            alignment: Alignment.center,
           child: ListView.builder(
        itemCount: apvTypes.length,
        itemBuilder: (context, index) {
          final type = apvTypes[index];
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
<<<<<<< Updated upstream
              MaterialPageRoute(builder: (context) => const HomePage()),
=======
              MaterialPageRoute(builder: (context) => ApvQuestionPage()),
>>>>>>> Stashed changes
            );
          } : null, // Disable the button if no type is selected
          child: const Text('Næste'),
        ),
      ),
    );
        
  }
}