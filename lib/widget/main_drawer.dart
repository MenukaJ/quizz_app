import 'package:flutter/material.dart';
import 'package:quiz_app_ii_example/page/home_page.dart';
import 'package:quiz_app_ii_example/views/notes_list.dart';

import '../admin_pages/add_category.dart';
import '../admin_pages/add_quiz.dart';

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
            leading: Icon(Icons.category_rounded),
            title: Text(
              'Categories',
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
            leading: Icon(Icons.category_rounded),
            title: Text(
              'Categories 2',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () => Navigator.of(context).push(
                new MaterialPageRoute(builder: (context) => new NoteList())),
          ),
          ListTile(
              leading: Icon(Icons.quiz_rounded),
              title: Text(
                'Quizzes',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () => Navigator.of(context).push(
                  new MaterialPageRoute(builder: (context) => new AddQuiz()))
          ),
          ListTile(
              leading: Icon(Icons.question_answer_rounded),
              title: Text(
                'Questions',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () => {}),
          ListTile(
              leading: Icon(Icons.notes_rounded),
              title: Text(
                'Options',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () => {}),
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
