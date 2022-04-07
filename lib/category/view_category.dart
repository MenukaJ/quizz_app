import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../model/CategoryNew.dart';
import '../model/category.dart';
import '../services/category_service.dart';
import 'add_category.dart';
import 'delete_category.dart';
import 'edit_category.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({Key key}) : super(key: key);

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  //CategoryService get service => GetIt.instance<CategoryService>();
  CategoryService service = new CategoryService();
  List<CategoryNew> _apiResponse;
  bool _isLoading = false;

  @override
  void initState() {
    _fetchNotes();
    super.initState();
  }

  _fetchNotes() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await service.getAllCategory();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Categories'),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => AddCategory()))
              .then((_) {
            _fetchNotes();
          });
        },
        child: Icon(Icons.add),
      ),
      body: Builder(
        builder: (_) {
          if (_isLoading) {
            return CircularProgressIndicator();
          }
          /*if (_apiResponse.error) {
            return Center(child: Text(_apiResponse.errorMessage));
          }*/
          return ListView.separated(
            separatorBuilder: (_, __) => Divider(
              height: 2,
            ),
            itemBuilder: (_, index) {
              return Dismissible(
                key: ValueKey(_apiResponse[index].id),
                direction: DismissDirection.startToEnd,
                onDismissed: (direction) {},
                confirmDismiss: (direction) async {
                  final result = await showDialog(
                      context: context, builder: (_) => DeleteCategory());

                  if (result) {
                    final deleteResult =
                        await service.delete(_apiResponse[index].id);
                    var message;
                    if (deleteResult != null) {
                      message = deleteResult.message;
                    } else {
                      message = 'An error occurred';
                    }

                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              title: Text('Done'),
                              content: Text(message),
                              actions: <Widget>[
                                FlatButton(
                                    child: Text('ok'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    })
                              ],
                            ));

                    return deleteResult == null ? false : true;
                  }

                  print(result);
                  return result;
                },
                background: Container(
                  color: Colors.red,
                  padding: EdgeInsets.only(left: 16),
                  child: Align(
                    child: Icon(Icons.delete, color: Colors.white),
                    alignment: Alignment.centerLeft,
                  ),
                ),
                child: Card(
                    color: Colors.white,
                    margin: EdgeInsets.all(9),
                    child: ListTile(
                      title: Text(_apiResponse[index].name),
                      subtitle: Text(_apiResponse[index].description),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => EditCategory(
                                categoryNew: _apiResponse[index])));
                      },
                    )),
              );
            },
            itemCount: _apiResponse.length,
          );
        },
      ),
    );
  }
}
