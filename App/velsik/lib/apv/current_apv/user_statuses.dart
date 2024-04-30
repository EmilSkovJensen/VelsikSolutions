import 'package:flutter/material.dart';
import 'package:velsik/models/user_response_status.dart';
import 'package:velsik/services/apvservice.dart';


class UserStatusesPage extends StatefulWidget {
  const UserStatusesPage({super.key});

  @override
  _UserStatusesPageState createState() => _UserStatusesPageState();
}


class _UserStatusesPageState extends State<UserStatusesPage> {
  final ApvService apvService = ApvService();
  List<UserResponseStatus> userStatuses = [];
  

 @override
  void initState() {
      super.initState();
      apvService.getCurrentApvUserStatuses().then((statuses) {
          if(statuses != null){
            setState(() {
              userStatuses = statuses;
            });
          } 
        }
      );
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
          "Nuværende APV",
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: userStatuses.length,
        itemBuilder: (context, index) {
          final UserResponseStatus userStatus = userStatuses[index];
          return Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Card(
              color: index.isOdd ? oddItemColor : evenItemColor,
              child: ListTile(
                title: Text(
                  '${userStatus.firstname} ${userStatus.lastname}',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: userStatus.status == false ? const Text(
                  "Mangler besvarelse",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 219, 44, 44),
                  ),
                ) : const Text(
                  "Modtaget besvarelse",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 41, 207, 69),
                  ),
                ),
                trailing: ElevatedButton(
                    onPressed: () {
                      showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const AlertDialog(
                                title: Center(child: Text('Fejl meddelse')),
                                content: Text('Denne funktion er ikke implementeret endnu', textAlign: TextAlign.center),
                              );
                            },
                        );
                    },
                    style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>( const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0), // Set the border radius to 40px
                          ),
                        ),
                      ),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    ),
                  child: const Text('Send påmindelse',),
                ),
              )
            ),
          );
        },
      ),
    );
  }
}