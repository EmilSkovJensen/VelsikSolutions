import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class ApvQuestionPage extends StatefulWidget {

  const ApvQuestionPage({super.key,});

  @override
  _ApvQuestionPageState createState() => _ApvQuestionPageState();
}


class _ApvQuestionPageState extends State<ApvQuestionPage> {

  List questions = [];
  

 @override
  void initState() {
    super.initState();

    questions = ["are u gay", "why are yu geh?"];

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
        title: Text("Vælg spørgsmål"), 
      ),
      body: ReorderableListView(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        children: questions.map((question) {
          return ListTile(
            key: Key(question), // Each list tile needs a unique key
            title: Text(question),
          );
        }).toList(),
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (newIndex > oldIndex) {
              newIndex -= 1; // Adjust index after removing the element
            }
            final question = questions.removeAt(oldIndex);
            questions.insert(newIndex, question);
          });
        },
      ),
    );
  }
}