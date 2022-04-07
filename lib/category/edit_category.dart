import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_app_ii_example/data/user.dart';
import 'package:quiz_app_ii_example/services/category_service.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../model/CategoryNew.dart';
import '../widget/main_drawer.dart';

class EditCategory extends StatefulWidget {
  final CategoryNew categoryNew;

  // const EditCategory(CategoryNew apiResponse, {Key key, this.categoryNew}) : super(key: key);
  EditCategory({Key key, @required this.categoryNew}) : super(key: key);

  //const AddCategory({Key? key}) : super(key: key);

  @override
  State<EditCategory> createState() => _EditCategoryState(categoryNew);
}

class _EditCategoryState extends State<EditCategory> {
  final scffoldKey = GlobalKey<ScaffoldState>();
  final CategoryNew categoryNew;
  GlobalKey<FormState> globalKey = new GlobalKey<FormState>();
  CategoryRequestModel requestModel;

  _EditCategoryState(this.categoryNew);

  // String name;
  String status;

  // String description;
  // String backgroundColor;
  // String imageURL;
  // String icon;
  // String id;

  @override
  void initState() {
    super.initState();
    requestModel = new CategoryRequestModel(
        name: categoryNew.name.toString(),
        status: categoryNew.status.toString(),
        description: categoryNew.description.toString(),
        backgroundColor: categoryNew.backgroundColor.toString(),
        imageURL: categoryNew.imageUrl.toString(),
        icon: categoryNew.icon.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepOrange, Colors.purple],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
        ),
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
                      height: 20,
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
                        validator: (input) =>
                            input.length < 1 ? "Name should be valid" : null,
                        decoration: new InputDecoration(
                            hintText: categoryNew.name.toString(),
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
                              color: Colors.blueGrey,
                            ))),
                    SizedBox(
                      height: 20,
                    ),
                    new TextFormField(
                        keyboardType: TextInputType.text,
                        onSaved: (input) => requestModel.description = input,
                        validator: (input) => input.length < 1
                            ? "Description should be valid"
                            : null,
                        decoration: new InputDecoration(
                            hintText: categoryNew.description.toString(),
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
                              color: Colors.blueGrey,
                            ))),
                    SizedBox(
                      height: 30,
                    ),
                    new TextFormField(
                        keyboardType: TextInputType.text,
                        onSaved: (input) => requestModel.imageURL = input,
                        //validator: (input) => input.length < 1? "URL should be valid": null,
                        decoration: new InputDecoration(
                            hintText: categoryNew.imageUrl.toString(),
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
                              Icons.image,
                              color: Colors.blueGrey,
                            ))),
                    SizedBox(
                      height: 30,
                    ),
                    DropdownButton<String>(
                      focusColor: Colors.white,
                      value: status,
                      //elevation: 5,
                      style: TextStyle(color: Colors.white),
                      iconEnabledColor: Colors.black,
                      items: <String>['Red', 'Green', 'Yellow', 'Blue']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                      hint: Text(
                        categoryNew.backgroundColor.toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      onChanged: (String value) {
                        setState(() {
                          requestModel.backgroundColor = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
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
                      activeBgColors: [
                        [Colors.blue],
                        [Colors.pink]
                      ],
                      onToggle: (index) {
                        print('switched to: $index');
                        // setState(() {
                        if (index == 0)
                          requestModel.status = "ACTIVE";
                        else
                          requestModel.status = "INACTIVE";
                        // });
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    FlatButton(
                      padding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 200,
                      ),
                      color: Colors.green,
                      onPressed: () {
                        if (validateAndSave()) {
                          print(requestModel.toJson());
                        }
                        CategoryService categoryService = new CategoryService();
                        categoryService
                            .update(categoryNew.id.toString(), username,
                                requestModel)
                            .then((responce) {
                          //print(responce.message);
                          return Fluttertoast.showToast(
                            msg: responce.message,
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.SNACKBAR,
                            backgroundColor: Colors.blueGrey,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        });
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                      //color: Theme.of(context).accentColor,
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

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
