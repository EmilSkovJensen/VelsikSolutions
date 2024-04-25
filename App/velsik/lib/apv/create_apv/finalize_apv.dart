import 'package:flutter/material.dart';
import 'package:velsik/home.dart';
import 'package:velsik/models/apv.dart';
import 'package:velsik/services/apvservice.dart';
import 'package:velsik/models/question.dart';
import 'package:velsik/models/user.dart';
import 'package:intl/intl.dart';

class FinalizeApvPage extends StatefulWidget {
  final List<Question> questions;
  final List<User> selectedUsers; 

  const FinalizeApvPage({super.key, required this.questions, required this.selectedUsers});

  @override
  _FinalizeApvPageState createState() => _FinalizeApvPageState();
}


class _FinalizeApvPageState extends State<FinalizeApvPage> {
  final ApvService apvService = ApvService();
  DateTime? startDate;
  DateTime? endDate;
  
  Apv finalApv = Apv(null, null, null, null, null, null);

 @override
  void initState() {
    super.initState();
   finalApv.questions = widget.questions;
   finalApv.users = widget.selectedUsers;
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
          "Vælg datoer",
          style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.w900),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 20, 
            left: 20,
            right: 20, 
            child: ElevatedButton(
              onPressed: () {
                _selectDate(context, true);
              },
              child: Text(startDate != null
                  ? 'Start dato: ${DateFormat('dd-MM-yyyy').format(startDate!)}'
                  : 'Vælg start dato', style: const TextStyle(color: Colors.black)),
            ),
          ),
          Positioned(
            top: 80, 
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                _selectDate(context, false);
              },
              child: Text(endDate != null
                  ? 'Slut dato: ${DateFormat('dd-MM-yyyy').format(endDate!)}'
                  : 'Vælg slut dato', style: const TextStyle(color: Colors.black)),
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
                    onTap: finalApv.startDate != null && finalApv.endDate != null ? () async {
                      if (finalApv.endDate!.isBefore(finalApv.startDate!)) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const AlertDialog(
                              title: Center(child: Text('Fejl meddelse')),
                              content: Text('Slut datoen skal ligge efter start datoen', textAlign: TextAlign.center),
                            );
                          },
                        );
                      } else {
                        if (await apvService.insertApv(finalApv) == true){
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const HomePage()),
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const AlertDialog(
                                title: Center(child: Text('Fejl meddelse')),
                                content: Text('Der skete en fejl under oprettelsen', textAlign: TextAlign.center),
                              );
                          },
                        );
                        }
                      }
                    } : null,
                    child: Image.asset('assets/send.png'),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary:   Color(0xFF2596BE), // color of the header and selected date
              onPrimary: Colors.white, // color of text against the primary color
              onSurface: Colors.black, // color of the text in the body
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF2596BE)
              ),
            ),
          ),
          child: DatePickerDialog(
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime(2101),
            helpText: "Vælg dato",
            cancelText: "Afbryd",
            confirmText: "Vælg",
            fieldLabelText: "Skriv dato",
          ),
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          startDate = picked;
          finalApv.startDate = startDate;
        } else {
          endDate = picked;
          finalApv.endDate = endDate;
        }
      });
    }
  }
}