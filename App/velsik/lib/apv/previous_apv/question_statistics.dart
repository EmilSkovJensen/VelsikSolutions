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
  List<String>? comments = [];
  
  @override
  void initState() {
    super.initState();

    apvService.getCommentsByQuestionId(widget.question.questionId).then((allComments) => {
      setState(() {
          if(allComments != null){
            comments = allComments;
          } 
      })
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
          "Kommentarer",
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: comments != null && comments!.isNotEmpty
          ? ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: comments!.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      comments![index],
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            )
          : Stack(
            children: [
              Positioned(
              top: 30,
              left: 0,
              right: 0,
              child: Image.asset('assets/error.png'),
              ),
              const Positioned(
              top: 270,
              left: 0,
              right: 0,
              child: Center(child: Text("Ingen kommentarer", style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w900))),
              ),
            ],
          )
    );
  }
}

