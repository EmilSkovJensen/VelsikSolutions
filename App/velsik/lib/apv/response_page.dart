import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velsik/home_user.dart';
import 'package:velsik/models/question.dart';
import 'package:velsik/models/response.dart';
import 'package:velsik/models/apv.dart';
import 'package:velsik/services/apvservice.dart';

class ResponsePage extends StatefulWidget {
  final Apv apv;

  const ResponsePage({super.key, required this.apv});

  @override
  _ResponsePage createState() => _ResponsePage();
}

class _ResponsePage extends State<ResponsePage> {
  int currentIndex = 0;
  List<Response> responses = [];
  bool isAllAnswered = true; 

  void prepareAnswers(Response response) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? userId = prefs.getInt('userId');

    response.userId = userId;
    response.comment = null;
    
    setState((){
      responses.add(response);
    });
  }

  void answer(bool answer, String comment) {
    responses[currentIndex].answer = answer;
    responses[currentIndex].comment = comment;

    if(currentIndex == responses.length - 1){
      setState(() {
      });
    } else {
      setState(() {
        currentIndex++;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    
    for(Question question in widget.apv.questions!) {
      Response response = Response(null, question.questionId, null, null, null);
      response.questionTitle = question.questionTitle;
      response.questionText = question.questionText;
      prepareAnswers(response);
    }
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
          icon: const Icon(Icons.arrow_back_ios,
          size: 20,
          color: Colors.white,),
          


        ),
        centerTitle: true, 
        title: const Text("Spørgeskema", style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.w900)), 
      ),
      body: Stack(
        children: [
          Center(
              child: Card(
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () {
                              if (currentIndex > 0) {
                                setState(() {
                                  currentIndex--;
                                });
                              }
                            },
                          ),
                        Text(
                            '${currentIndex + 1}/${widget.apv.questions!.length}',
                            style: const TextStyle(fontSize: 18),
                          ),
                        IconButton(
                            icon: const Icon(Icons.arrow_forward),
                            onPressed: () {
                              if (currentIndex < responses.length - 1) {
                                setState(() {
                                  currentIndex++;
                                });
                              }
                            },
                        ),
                      ],
                    ),
                    Center(child: Image.asset('assets/${responses[currentIndex].questionTitle}.png')),
                    ListTile(
                      title: Text(
                          '${responses[currentIndex].questionTitle}', style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w600), textAlign: TextAlign.center),
                    ),
                    ListTile(
                      title: Text(
                          '${responses[currentIndex].questionText}', textAlign: TextAlign.center),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: responses[currentIndex].answer == false || responses[currentIndex].answer == null ? () {
                              answer(true, "");
                          } : null,
                          style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>( const RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0), // Set the border radius to 40px
                                                  ),
                                                ),
                                              ),
                                              minimumSize: MaterialStateProperty.all(const Size(100, 50)),
                                              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                                (Set<MaterialState> states) {
                                                  if (responses[currentIndex].answer == true) {
                                                    // Change opacity when pressed
                                                    return const Color.fromARGB(255, 115, 223, 101).withOpacity(0.3); // Adjust the opacity (0.5) as needed
                                                  }
                                                  return const Color.fromARGB(255, 115, 223, 101); // Return original color
                                                },
                                              ),
                                            ),
                          child: const Text('Ja', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),),
                        ),
                        ElevatedButton(
                          onPressed: responses[currentIndex].answer == true || responses[currentIndex].answer == null ? () {
                              answer(false, "");
                          } : null,
                          style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>( const RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0), // Set the border radius to 40px
                                                  ),
                                                ),
                                              ),
                                              minimumSize: MaterialStateProperty.all(const Size(100, 50)),
                                              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                                (Set<MaterialState> states) {
                                                  if (responses[currentIndex].answer == false) {
                                                    // Change opacity when pressed
                                                    return const Color.fromARGB(255, 211, 73, 73).withOpacity(0.3); // Adjust the opacity (0.5) as needed
                                                  }
                                                  return const Color.fromARGB(255, 211, 73, 73); // Return original color
                                                },
                                              ),
                                            ),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(5, 211, 73, 20), // Set the overlay color
                            ),
                            child: const Text(
                              'Nej',
                              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if(currentIndex == responses.length - 1)
              Positioned(
                bottom: 16, 
                left: 0, 
                right: 0, 
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Center(
                    child: GestureDetector(
                      onTap: () async {
                        bool foundANull = false;
                        for (Response response in responses) {
                          if (response.answer == null) {
                            foundANull = true;
                            break;
                          }
                        }

                        if(foundANull){
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const AlertDialog(
                                title: Center(child: Text('Fejl meddelse')),
                                content: Text('Du mangler at svare på nogle spørgsmål', textAlign: TextAlign.center),
                              );
                            },
                          );
                        } else {
                          ApvService apvService = ApvService();
                          
                          if (await apvService.insertResponses(responses) == true){
                            Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const HomeUserPage()),
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const AlertDialog(
                                  title: Center(child: Text('Fejl meddelse')),
                                  content: Text('Der skete en fejl under indsendelsen af besvarelsen', textAlign: TextAlign.center),
                                );
                              },
                            );
                          }
                        }
                        
                      },
                      child: Image.asset('assets/send1.png'),
                    ),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}