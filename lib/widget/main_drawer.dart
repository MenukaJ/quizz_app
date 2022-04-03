import 'package:flutter/material.dart';
import 'package:quiz_app_ii_example/page/home_page.dart';

import '../admin_pages/add_category.dart';

class MainDrawer extends StatelessWidget {
  final username;

  MainDrawer({this.username});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Colors.purple.shade300,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 30, bottom: 10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/User_icon_2.svg/220px-User_icon_2.svg.png"),
                            fit: BoxFit.fill)),
                  ),
                  Text(
                    username,
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text(
              'Profile',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.qr_code),
            title: Text(
              'Category',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () => Navigator.of(context).push(
                new MaterialPageRoute(builder: (context) => new AddCategory())),
          ),
          ListTile(
              leading: Icon(Icons.airplane_ticket),
              title: Text(
                'Question',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () => {}
              /*Navigator.of(context).push(
                new MaterialPageRoute(builder: (context) => new Ticket())),*/
              ),
          ListTile(
              leading: Icon(Icons.airplane_ticket),
              title: Text(
                'Options',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () => {}
              /*Navigator.of(context).push(
                new MaterialPageRoute(builder: (context) => new Ticket())),*/
              ),
          ListTile(
              leading: Icon(Icons.airplane_ticket),
              title: Text(
                'Quizz',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () => {}
              /*Navigator.of(context).push(
                new MaterialPageRoute(builder: (context) => new Ticket())),*/
              ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text(
              'Logout',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () => Navigator.of(context).push(
                new MaterialPageRoute(builder: (context) => new HomePage())),
          )
        ],
      ),
    );
  }
}
