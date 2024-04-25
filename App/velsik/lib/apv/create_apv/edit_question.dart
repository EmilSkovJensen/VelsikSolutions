import 'package:flutter/material.dart';
import 'package:velsik/models/question.dart';


class EditQuestionPage extends StatefulWidget {
  final Question question;


  const EditQuestionPage({super.key, required this.question});

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
              top: 400,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    initialValue: widget.question.questionTitle,
                    decoration: const InputDecoration(
                      labelText: 'Titel',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      widget.question.questionTitle = value;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    initialValue: widget.question.questionText,
                    maxLines: null, // Allow multiple lines
                    decoration: const InputDecoration(
                      labelText: 'Tekst',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      widget.question.questionText = value;
                    },
                  ),
                ],
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
}



