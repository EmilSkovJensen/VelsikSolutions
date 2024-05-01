import 'package:flutter/material.dart';
import 'package:velsik/models/question.dart';
import 'package:velsik/services/apvservice.dart';

class QuestionStatisticsPage extends StatefulWidget {
  final Question question;
  const QuestionStatisticsPage({super.key, required this.question});

  @override
  _QuestionStatisticsPageState createState() => _QuestionStatisticsPageState();
}

class _QuestionStatisticsPageState extends State<QuestionStatisticsPage> {
  final ApvService apvService = ApvService();
  
  @override
  void initState() {
    super.initState();
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
        title: Text(
          widget.question.questionTitle,
          style: const TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: const Stack(
            children: [
        
            ],
          ) 
    );
  }
}


