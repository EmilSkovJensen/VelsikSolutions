import 'package:flutter/material.dart';
import 'package:velsik/apv/previous_apv/question_statistics.dart';
import 'package:velsik/models/apv.dart';
import 'package:velsik/models/question.dart';
import 'package:velsik/services/apvservice.dart';

class ApvStatisticsPage extends StatefulWidget {
  final Apv apv;
  const ApvStatisticsPage({super.key, required this.apv});

  @override
  _ApvStatisticsPageState createState() => _ApvStatisticsPageState();
}

class _ApvStatisticsPageState extends State<ApvStatisticsPage> {
  final ApvService apvService = ApvService();
  
  
  @override
  void initState() {
    super.initState();
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
          "APV Statistik",
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: Stack(
            children: [
              ListView(
                children: widget.apv.questions!.asMap().entries.map((entry) {
                  final int index = entry.key;
                  final Question question = entry.value;
                  return GestureDetector(
                    onTap: () {
                      // Handle onTap event
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => QuestionStatisticsPage(question: question)),
                      );
                    },
                    child: ListTile(
                      leading: Text(
                        (index + 1).toString(),
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w600), // Adjust the font size as needed
                      ), // Placement number
                      title: Text(
                        question.questionTitle,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      tileColor: entry.key.isOdd ? oddItemColor : evenItemColor,
                    ),
                  );
                }).toList(),
              )
            ],
          ) 
    );
  }
}


