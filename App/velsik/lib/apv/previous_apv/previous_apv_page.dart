import 'package:flutter/material.dart';
import 'package:velsik/apv/response_page.dart';
import 'package:velsik/models/apv.dart';
import 'package:velsik/services/apvservice.dart';
import 'package:intl/intl.dart'; 

class PreviousApvPage extends StatefulWidget {
  const PreviousApvPage({super.key});

  @override
  _PreviousApvPageState createState() => _PreviousApvPageState();
}

class _PreviousApvPageState extends State<PreviousApvPage> {
  final ApvService apvService = ApvService();
  List<Apv>? apvs = [];
  
  @override
  void initState() {
    super.initState();

    apvService.getPreviousApvsByCompanyId().then((allApvs) => {
      setState(() {
          if(allApvs != null){
            apvs = allApvs;
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
          "Tidligere APV",
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: apvs != null && apvs!.isEmpty
          ? Stack(
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
              child: Center(child: Text("Ingen tidligere apv", style: TextStyle(fontSize: 35, color: Colors.white, fontWeight: FontWeight.w900))),
              ),
            ],
          ) 
          : Stack(
            children: [
                ListView.builder(
                itemCount: apvs!.length,
                itemBuilder: (context, index) {
                  final apv = apvs![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResponsePage(apv: apv), //CHANGE TO APV STATS PAGE
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Card(
                        child: ListTile(
                          title: Text('APV Nummer: ${apv.apvId}'),
                          subtitle: Text('Start dato: ${DateFormat('dd-MM-yyyy').format(apv.startDate!).toString()}, Slut dato: ${DateFormat('dd-MM-yyyy').format(apv.endDate!).toString()}'),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
    );
  }
}


