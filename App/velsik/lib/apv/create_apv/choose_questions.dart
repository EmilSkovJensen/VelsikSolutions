import 'package:flutter/material.dart';
import 'package:velsik/apv/create_apv/edit_question.dart';
import 'package:velsik/services/apvservice.dart';
import 'package:velsik/models/question.dart';
import 'package:velsik/apv/create_apv/choose_receivers.dart';

class ApvQuestionPage extends StatefulWidget {
  final String? type;
  final List<Question>? questionList;

  const ApvQuestionPage({super.key, required this.type, this.questionList});

  @override
  _ApvQuestionPageState createState() => _ApvQuestionPageState();
}


class _ApvQuestionPageState extends State<ApvQuestionPage> {
  final ApvService apvService = ApvService();
  List<Question> apvQuestions = [];
  

 @override
  void initState() {
    super.initState();
    if(widget.questionList != null){
      apvQuestions = widget.questionList!;
    }else {
        apvService.getTemplateQuestionsByTypeName(widget.type).then((questions) {
      if(questions != null){
        setState(() {
          apvQuestions = questions;
        });
      } 
    });
    }
    
  }

 @override
Widget build(BuildContext context) {
  final ColorScheme colorScheme = Theme.of(context).colorScheme;
  final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
  final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

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
        "Vælg spørgsmål",
        style: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.w900),
      ),
    ),
    body: Stack(
  children: [
    Positioned.fill(
      child: ReorderableListView(
        buildDefaultDragHandles: true,
        padding: const EdgeInsets.only(bottom: 140.0), 
        proxyDecorator: (Widget child, int index, Animation<double> animation) {
          return Material(
            color: const Color(0xFF2596BE), 
            elevation: 6.0, 
            child: child,
          );
        },
        children: apvQuestions.asMap().entries.map((entry) {
          final int index = entry.key;
          final Question question = entry.value;
          return ListTile(
            key: Key(question.questionId.toString()), 
            leading: Text(
              (index + 1).toString(),
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600), 
            ), 
            title: Text(
              question.questionTitle,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            tileColor: entry.key.isOdd ? oddItemColor : evenItemColor,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditQuestionPage(question: question, questionList: apvQuestions)),
                    );
                  },
                  child: const Icon(Icons.edit, color: Colors.white),
                ),
                const SizedBox(width: 8), 
                const Icon(Icons.drag_handle, color: Colors.white),
              ],
            ),
          );
        }).toList(),
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (newIndex > oldIndex) {
              newIndex -= 1; 
            }
            final Question question = apvQuestions.removeAt(oldIndex);
            apvQuestions.insert(newIndex, question);
          });
        },
      ),
    ),
    Positioned(
      bottom: 16,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: GestureDetector(
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ApvReceiversPage(questions: apvQuestions)),
              );
            },
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