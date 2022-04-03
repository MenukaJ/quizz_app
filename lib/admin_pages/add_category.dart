import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_app_ii_example/data/user.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../model/CategoryNew.dart';
import '../widget/main_drawer.dart';

class AddCategory extends StatefulWidget {
  //const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final scffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalKey = new GlobalKey<FormState>();
  CategoryRequestModel requestModel;
  String name = "";
  String _status;
  String description = "";
  String backgroundColor = "";
  String imageURL = "";
  String icon = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category"),
      ),
      //drawer: MainDrawer(username: username),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).hintColor.withOpacity(0.2),
                        offset: Offset(0, 10),
                        blurRadius: 20)
                  ]),
              child: Form(
                key: globalKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      "Category",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 40),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    new TextFormField(
                        keyboardType: TextInputType.text,
                        onSaved: (input) => requestModel.name = input,
                        validator: (input) => input.length < 250
                            ? "description should be valid"
                            : null,
                        decoration: new InputDecoration(
                            hintText: "Name",
                            hintStyle: TextStyle(color: Colors.black),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.2),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor)),
                            prefixIcon: Icon(
                              Icons.category,
                              color: Colors.black,
                            ))),
                    SizedBox(
                      height: 20,
                    ),
                    new TextFormField(
                        keyboardType: TextInputType.text,
                        onSaved: (input) => requestModel.description = input,
                        validator: (input) => input.length < 1
                            ? "username should be valid"
                            : null,
                        decoration: new InputDecoration(
                            hintText: "Description",
                            hintStyle: TextStyle(color: Colors.black),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.2),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor)),
                            prefixIcon: Icon(
                              Icons.description,
                              color: Colors.black,
                            ))),
                    SizedBox(
                      height: 30,
                    ),
                    /*DropdownButton<String>(
                      focusColor:Colors.white,
                      value: _status,
                      //elevation: 5,
                      style: TextStyle(color: Colors.white),
                      iconEnabledColor:Colors.black,
                      items: <String>[
                        'ACTIVE',
                        'INACTIVE'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,style:TextStyle(color:Colors.black),),
                        );
                      }).toList(),
                      hint:Text(
                        "Please choose a Status",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      onChanged: (String value) {
                        setState(() {
                          _status = value;
                        });
                      },
                    ),*/
                    ToggleSwitch(
                      minWidth: 90.0,
                      initialLabelIndex: 1,
                      cornerRadius: 10.0,
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.grey,
                      inactiveFgColor: Colors.white,
                      totalSwitches: 2,
                      labels: ['ACTIVE', 'INACTIVE'],
                      //icons: [FontAwesomeIcons.ac, FontAwesomeIcons.venus],
                      activeBgColors: [[Colors.blue],[Colors.pink]],
                      onToggle: (index) {
                        print('switched to: $index');
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    FlatButton(
                      padding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 100,
                      ),
                      onPressed: () {

                      },
                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Theme.of(context).accentColor,
                      shape: StadiumBorder(),
                    )
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
