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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: const Text("Vælg dato"),
      ),
      body: Stack(
        children: [
          // Your other widgets can go here

          // Date Selector for Start Date
          Positioned(
            top: 20, 
            left: 20, 
            child: ElevatedButton(
              onPressed: () {
                _selectDate(context, true);
              },
              child: Text(startDate != null
                  ? 'Start Date: ${DateFormat('yyyy-MM-dd').format(startDate!)}'
                  : 'Select Start Date'),
            ),
          ),

          // Date Selector for End Date
          Positioned(
            top: 80, 
            left: 20, 
            child: ElevatedButton(
              onPressed: () {
                _selectDate(context, false);
              },
              child: Text(endDate != null
                  ? 'End Date: ${DateFormat('yyyy-MM-dd').format(endDate!)}'
                  : 'Select End Date'),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: finalApv.startDate != null && finalApv.endDate != null ? () async {
            if (await apvService.insertApv(finalApv)){
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
              );
            }  
          } : null, // Disable the button if no type is selected
          child: const Text('Send'),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
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