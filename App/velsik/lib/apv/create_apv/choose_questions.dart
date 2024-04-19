import 'package:flutter/material.dart';
import 'package:velsik/services/apvservice.dart';
import 'package:velsik/models/question.dart';
import 'package:velsik/apv/create_apv/choose_receivers.dart';

class ApvQuestionPage extends StatefulWidget {
  final String? type;

  const ApvQuestionPage({super.key, required this.type});

  @override
  _ApvQuestionPageState createState() => _ApvQuestionPageState();
}


class _ApvQuestionPageState extends State<ApvQuestionPage> {
  final ApvService apvService = ApvService();
  List<Question> apvQuestions = [];
  

 @override
  void initState() {
    super.initState();

    apvService.getTemplateQuestionsByTypeName(widget.type).then((questions) {
      if(questions != null){
        setState(() {
          apvQuestions = questions;
        });
      } 
    });
  }

 @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

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
        title: const Text("Vælg spørgsmål"), 
      ),
      body: ReorderableListView(
        buildDefaultDragHandles: true,
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: apvQuestions.asMap().entries.map((entry) {
          final int index = entry.key;
          final Question question = entry.value;
          return ListTile(
            key: Key(question.questionId.toString()), // Each list tile needs a unique key
            leading: Text(
              (index + 1).toString(),
              style: const TextStyle(fontSize: 16), // Adjust the font size as needed
            ), // Placement number
            title: Text(question.questionTitle),
            tileColor: entry.key.isOdd ? oddItemColor : evenItemColor,
            trailing: const Icon(Icons.drag_handle),
          );
        }).toList(),
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (newIndex > oldIndex) {
              newIndex -= 1; // Adjust index after removing the element
            }
            final Question question = apvQuestions.removeAt(oldIndex);
            apvQuestions.insert(newIndex, question);
            // Update placement numbers
            for (int i = 0; i < apvQuestions.length; i++) {
              apvQuestions[i].placementNo = i + 1;
            }
          });
        },

      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ApvReceiversPage(questions: apvQuestions)),
            );
          },
          child: const Text('Næste'),
        ),
      ),
    );
  }
}