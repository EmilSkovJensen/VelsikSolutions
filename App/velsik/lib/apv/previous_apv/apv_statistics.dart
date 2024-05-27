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
  
  Color? getTileColor(int? totalAttendees, int? yesCount) {
    double yesPercentage = yesCount! / totalAttendees!;

    if (yesPercentage >= 0.75) {
      return Colors.redAccent[100]; // pastel red
    } else if (yesPercentage >= 0.50) {
      return Colors.orangeAccent[100]; // pastel orange
    } else if (yesPercentage >= 0.25) {
      return Colors.yellowAccent[100]; // pastel yellow
    } else {
      return Colors.greenAccent[100]; // pastel green
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
                  final Question question = entry.value;
                  return GestureDetector(
                    onTap: () {
                      // Handle onTap event
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => QuestionStatisticsPage(question: question)),
                      );
                    },
                    child: Stack(
                      children: [
                        ListTile(
                          title: Text(
                            question.questionTitle,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            "Ja: ${question.yesCount}    Nej: ${question.noCount}",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          tileColor: entry.key.isOdd ? oddItemColor : evenItemColor,
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          bottom: 0,
                          width: MediaQuery.of(context).size.width * 0.07,
                          child: Container(
                            color: getTileColor(question.totalAttendees, question.yesCount), // Change to your desired color
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              )
            ],
          ) 
    );
  }
}


