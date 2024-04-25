import 'package:flutter/material.dart';
import 'package:velsik/services/apvservice.dart';
import 'package:velsik/apv/create_apv/choose_questions.dart';



class ApvTypePage extends StatefulWidget {
  final String category;

  const ApvTypePage({super.key, required this.category});

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

    apvService.getApvTypesByCategory(widget.category).then((types) {
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
    backgroundColor: const Color(0xFF2596BE),
    appBar: AppBar(
      elevation: 0,
      backgroundColor: const Color(0xFF2596BE),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          size: 20,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      title: const Text(
        "Vælg typen",
        style: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.w900),
      ),
    ),
    body: Stack(
      children: [
        ListView.builder(
          itemCount: apvTypes.length,
          itemBuilder: (context, index) {
            final type = apvTypes[index];
            return ListTile(
              leading: Radio<String>(
                fillColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.selected)) {
                      return Colors.white; // Change selected color
                    }
                    return Colors.white; // Change unselected color
                  },
                ),
                value: type,
                groupValue: selectedType,
                onChanged: (String? value) {
                  setState(() {
                    selectedType = value;
                  });
                },
              ),
              title: Text(
                type,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
              onTap: () {
                setState(() {
                  selectedType = type;
                });
              },
            );
          },
        ),
        Positioned(
          bottom: 16,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Center(
              child: GestureDetector(
                onTap: selectedType != null ? () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ApvQuestionPage(type: selectedType),
                    ),
                  );
                } : null,
                child: Image.asset('assets/næste.png'),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
}