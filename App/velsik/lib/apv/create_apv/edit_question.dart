import 'package:flutter/material.dart';
import 'package:velsik/apv/create_apv/choose_questions.dart';
import 'package:velsik/models/question.dart';


class EditQuestionPage extends StatefulWidget {
  final Question question;
  final List<Question> questionList;
  final String? type;


  const EditQuestionPage({super.key, required this.question, required this.questionList, this.type});

  @override
  _EditQuestionPageState createState() => _EditQuestionPageState();
}

class _EditQuestionPageState extends State<EditQuestionPage> {


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
          icon: const Icon(Icons.arrow_back_ios,
          size: 20,
          color: Colors.white,),
          


        ),
        centerTitle: true, 
        title: const Text("Rediger spørgsmål", style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.w900)), 
      ),
        body: Stack(
  children: [
    Positioned.fill(
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 10,
              right: 10,
              child: Image.asset(
                'assets/${widget.question.questionTitle}.png', 
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 320,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.question.questionTitle,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black, 
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    initialValue: widget.question.questionText,
                    maxLines: null,
                    decoration: const InputDecoration(
                      labelText: 'Tekst',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        widget.question.questionText = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, widget.question);
                },
                child: const Text('Gem'),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: () {
                  _deleteQuestion();
                },
                child: const Text('Slet'),
              ),
            ),
          ],
        ),
      ),
    ),
  ],
),

    );
   
  }
   void _deleteQuestion() {

  widget.questionList.remove(widget.question);

  Navigator.pop(context);
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => ApvQuestionPage(type: widget.type, questionList: widget.questionList),
    ),
  );

}

}
