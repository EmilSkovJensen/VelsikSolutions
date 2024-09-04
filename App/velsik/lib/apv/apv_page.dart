import 'package:flutter/material.dart';
//import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:velsik/apv/current_apv/user_statuses.dart';
import 'package:velsik/apv/previous_apv/previous_apv_page.dart';
import 'create_apv/choose_category.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ApvPage extends StatefulWidget {
  const ApvPage({super.key, required int userid});

  @override
  _ApvPageState createState() => _ApvPageState();
}

class _ApvPageState extends State<ApvPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
        title: const Text(
          "APV-Værktøj",
          style: TextStyle(
            fontSize: 30,
            color: Colors.black,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04, right: MediaQuery.of(context).size.width * 0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(width: double.infinity, 
                    height: MediaQuery.of(context).size.height * 0.2, 
                    decoration: BoxDecoration(color: const Color(0xFFF2F2F7),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [ 
                        Padding(
                          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.06),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Nuværende", 
                                style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                                color: Colors.black,  
                                ),
                                textAlign: TextAlign.left,
                              ),
                              const Text(
                                "Modtaget 24 ud af 34", style: TextStyle(
                                fontWeight: FontWeight.w600, 
                                fontSize: 12,
                                color: Colors.grey,  
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
                                child: Container(width: MediaQuery.of(context).size.width * 0.25, 
                                  height: MediaQuery.of(context).size.height * 0.04, 
                                  decoration: BoxDecoration(color: const Color.fromARGB(255, 230, 93, 84),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "Mangler 10", style: TextStyle(
                                        fontWeight: FontWeight.w600, 
                                        fontSize: 12,
                                        color: Colors.white,  
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.05, top: MediaQuery.of(context).size.height * 0.02),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.height * 0.18, // Set the desired width
                            height: MediaQuery.of(context).size.height * 0.18, // Set the desired height
                            child: SfRadialGauge(
                              axes: <RadialAxis>[
                                RadialAxis(
                                  minimum: 0,
                                  maximum: 100,
                                  showLabels: false,
                                  showTicks: false,
                                  axisLineStyle: const AxisLineStyle(
                                    thickness: 0.25,
                                    cornerStyle: CornerStyle.bothCurve,
                                    color: Color.fromARGB(100,76,118,236),
                                    thicknessUnit: GaugeSizeUnit.factor,
                                  ),
                                  pointers: const <GaugePointer>[
                                    RangePointer(
                                      value: 75, // Progress value (in percentage)
                                      cornerStyle: CornerStyle.bothCurve,
                                      width: 0.2,
                                      sizeUnit: GaugeSizeUnit.factor,
                                      color: Color.fromARGB(255,76,118,236), // Color of the progress bar
                                    ),
                                  ],
                                  annotations: const <GaugeAnnotation>[
                                    GaugeAnnotation(
                                      positionFactor: 0,
                                      widget: Text(
                                        '75%', // Displayed percentage
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(width: MediaQuery.of(context).size.width * 0.43, 
                    height: MediaQuery.of(context).size.height * 0.1, 
                    decoration: BoxDecoration(color: const Color(0xFFF2F2F7),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Row(
                      children: [
                        Text(
                          "Nuværende", 
                          style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                          color: Colors.black,  
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    )
                  ),
                  Container(width: MediaQuery.of(context).size.width * 0.43, 
                    height: MediaQuery.of(context).size.height * 0.1, 
                    decoration: BoxDecoration(color: const Color(0xFFF2F2F7),
                      borderRadius: BorderRadius.circular(30),
                    )
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(width: MediaQuery.of(context).size.width * 0.43, 
                    height: MediaQuery.of(context).size.height * 0.1, 
                    decoration: BoxDecoration(color: const Color(0xFFF2F2F7),
                      borderRadius: BorderRadius.circular(30),
                    )
                  ),
                  Container(width: MediaQuery.of(context).size.width * 0.43, 
                    height: MediaQuery.of(context).size.height * 0.1, 
                    decoration: BoxDecoration(color: const Color(0xFFF2F2F7),
                      borderRadius: BorderRadius.circular(30),
                    )
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              MaterialButton(
                minWidth: double.infinity,
                height: MediaQuery.of(context).size.height * 0.25,
                onPressed: () async {
                  
                },
                color: const Color(0xFFF2F2F7),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),  
                ),
                child: const Row(
                  children: [
                    
                  ],
                ), 
              ),
            ],
          ),
        ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255,76,118,236), // Set the color of the BottomAppBar
        shape: const CircularNotchedRectangle(), // Creates a notch for the FAB
        notchMargin: 8.0, // Margin around the notch
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.0001, // Height of the BottomAppBar
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // No other widgets in the BottomAppBar, just the FAB in the middle
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
        
      },
      backgroundColor: const Color.fromARGB(255,76,118,236), // Set the background color of the FAB
      child: const Icon(
        size: 40,
        Icons.add,
        color: Colors.white, // Set the color of the "+" icon
      ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, // Centers the FAB in the BottomAppBar
    );
  }
}



