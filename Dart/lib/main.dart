import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(
    home: MyApp()

  ));
  
}
final PasswordController = TextEditingController();
final WebsiteController = TextEditingController();
final EmailController = TextEditingController();



class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool secret = false;
  String hide_show = "Hide";
  List<String> alphachoice = ["A","B","C","D","E","F","G","H","I","J","K",'L',"M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","1","2","3","4","5","6","7","8","9","0","!","@","#","%","^","&","*","(",")","-","=","_","+"];
  Map<String, String> database = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(100, 80, 80, 80),
      appBar: AppBar(
        title: Text("Password Manager"),
        backgroundColor: Color.fromARGB(100, 80, 80, 80),
        centerTitle:  true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Image.asset('assets/lock.png'),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
            "Website:",
            style: TextStyle(
            color: Colors.white
            ),
            ),

             SizedBox(
               width: 200,
               child: TextField(
                 controller: WebsiteController,
                 style: TextStyle(
                  height: 0.1,
                   fontSize: 12
                  ),
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      fillColor: Colors.white, filled: true,
                      labelText: 'Enter website',
                  )

                )
              ),


              TextButton(
                  onPressed: (){
                    var email = database[WebsiteController.text + "User"];
                    var password = database[WebsiteController.text + "Pass"];
                    EmailController.text = email.toString();
                    PasswordController.text = password.toString();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(100, 80, 80, 95)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: BorderSide(color: Color.fromARGB(100, 80, 80, 95))
                      )
                  )
                  ),
                  child: Text(
                      'Search',
                      style: TextStyle(
                      color: Colors.white
                  )
                  )
              )
            ],
          ),
    ),

      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 25.0),
            child: Text(
                "Username:",
                style: TextStyle(
                    color: Colors.white
                ),
              ),
              ),


            SizedBox(
                width: 200,
                child: TextField(
                  controller: EmailController,
                    style: TextStyle(
                        height: 0.1,
                        fontSize: 12
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      fillColor: Colors.white, filled: true,
                      labelText: 'Enter email',
                    )

                )
            ),
            ],
          ),
      ),


      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Password:",
                style: TextStyle(
                    color: Colors.white
                ),
              ),

              SizedBox(
                  width: 150,
                  child: TextField(
                    controller: PasswordController,
                    obscureText: secret,
                      style: TextStyle(
                          height: 0.1,
                          fontSize: 12
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        fillColor: Colors.white, filled: true,
                        labelText: 'Enter password',
                      )

                  )
              ),

              TextButton(
                  onPressed: (){
                    setState(() {
                      secret = !secret;
                      if (hide_show == "Hide") {
                        hide_show = "Show";
                      }
                      else{
                        hide_show = "Hide";
                      }
                    }
                    );
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(100, 80, 80, 95)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(color: Color.fromARGB(100, 80, 80, 95))
                          )
                      )
                  ),
                  child: Text(
                      hide_show,
                      style: TextStyle(
                          color: Colors.white
                      )
                  )
              ),
              TextButton(
                  onPressed: (){
                    var new_pass = "";
                    for (int i = 0; i < 12; i++) {
                      Random random = Random();
                      var index = random.nextInt(alphachoice.length);
                      new_pass = new_pass + alphachoice[index];
                    }
                    PasswordController.text = new_pass;
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(100, 80, 80, 95)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(color: Color.fromARGB(100, 80, 80, 95))
                          )
                      )
                  ),
                  child: Text(
                      'Generate',
                      style: TextStyle(
                          color: Colors.white
                      )
                  )
              )
            ],
          ),
      ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: (){
                      database[WebsiteController.text + "User"] = EmailController.text;
                      database[WebsiteController.text + "Pass"] = PasswordController.text;
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(100, 80, 80, 95)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                side: BorderSide(color: Color.fromARGB(100, 80, 80, 95))
                            )
                        )
                    ),
                    child: Text(
                        'Add',
                        style: TextStyle(
                            color: Colors.white
                        )
                    )
                )
              ],
            ),
          ),

        ],
      ),

    );


  }
}


  