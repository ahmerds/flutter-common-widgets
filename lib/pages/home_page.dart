import 'package:flutter/material.dart';
import 'package:drawer_tutorial/pages/other_page.dart';
import 'package:drawer_tutorial/pages/json_storage.dart';
import 'package:drawer_tutorial/pages/http_request.dart';
import 'package:drawer_tutorial/pages/animated_button.dart';
import 'package:drawer_tutorial/pages/animation.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String mainProfilePicture = "https://avatars3.githubusercontent.com/u/11873696?s=200&v=4";
  String otherProfilePicture = "https://avatars1.githubusercontent.com/ml/671?s=140&v=4";

  void switchUser() {
    String backupString = mainProfilePicture;
    this.setState(() {
      mainProfilePicture = otherProfilePicture;
      otherProfilePicture = backupString;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Drawer App"), backgroundColor: Colors.redAccent,),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("John Doe"),
              accountEmail: Text("johndoe@mail.com"),
              currentAccountPicture: GestureDetector(
                onTap: () => print("The avatar was tapped"),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    mainProfilePicture
                  ),
                  backgroundColor: Colors.white54,
                ),
              ),
              otherAccountsPictures: <Widget>[
                GestureDetector(
                  onTap: () => switchUser(),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      otherProfilePicture
                    ),
                    backgroundColor: Colors.white54,
                  ),
                ),
              ],
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                    "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/0c771525-1438-4011-8056-d7c66e31b770/d9vu1fq-1307dbbb-3ccf-4367-97dc-21b46ef6d0f9.png/v1/fill/w_1192,h_670,q_70,strp/low_poly_landscape_by_tolgaordu_d9vu1fq-pre.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9MTA4MCIsInBhdGgiOiJcL2ZcLzBjNzcxNTI1LTE0MzgtNDAxMS04MDU2LWQ3YzY2ZTMxYjc3MFwvZDl2dTFmcS0xMzA3ZGJiYi0zY2NmLTQzNjctOTdkYy0yMWI0NmVmNmQwZjkucG5nIiwid2lkdGgiOiI8PTE5MjAifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6aW1hZ2Uub3BlcmF0aW9ucyJdfQ.UIAiHYgJds9GWNkuaP1sjs3hBNF80pvc9Y3jlQWOIw8",

                  )
                )
              ),
            ),
            ListTile(
              title: Text("JSON Storage"),
              trailing: Icon(Icons.subject),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) => JsonStorage())
                );
              },
            ),
            ListTile(
              title: Text("HTTP Requests"),
              trailing: Icon(Icons.compare_arrows),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) => HttpRequest())
                );
              },
            ),
            ListTile(
              title: Text("Animation Official"),
              trailing: Icon(Icons.ondemand_video),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) => AnimationTutorial())
                );
              },
            ),
            ListTile(
              title: Text("Animated Button"),
              trailing: Icon(Icons.ondemand_video),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) => AnimatedButton())
                );
              },
            ),
            ListTile(
              title: Text("Second Page"),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) => OtherPage("Second Page"))
                );
              },
            ),
            Divider(),
            ListTile(
              title: Text("Close"),
              trailing: Icon(Icons.cancel),
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
      body: Center(
        child: Text("Homepage", style: TextStyle(fontSize: 40.0),),
      ),
    );
  }
}