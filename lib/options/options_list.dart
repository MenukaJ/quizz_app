import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:quiz_app/options/options_delete.dart';
import 'package:quiz_app/options/options_modify.dart';
import 'package:quiz_app/services/options_service.dart';
import 'options_api_response.dart';
import 'options_for_listing.dart';

class OptionsList extends StatefulWidget {
  @override
  _OptionsListState createState() => _OptionsListState();
}

class _OptionsListState extends State<OptionsList> {
  OptionsService get service => GetIt.instance<OptionsService>();

  OptionsAPIResponse<List<OptionsForListing>> _apiResponse;
  bool _isLoading = false;

  @override
  void initState() {
    _fetchOptions();
    super.initState();
  }

  _fetchOptions() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await service.getOptionsList();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Options'),
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
              .push(MaterialPageRoute(builder: (_) => OptionsModify()))
              .then((_) {
            _fetchOptions();
          });
        },
        child: Icon(Icons.add),
      ),
      body: Builder(
        builder: (_) {
          if (_isLoading) {
            return CircularProgressIndicator();
          }
          if (_apiResponse.error) {
            return Center(child: Text(_apiResponse.errorMessage));
          }
          return ListView.separated(
            separatorBuilder: (_, __) =>
                Divider(height: 1, color: Colors.green),
            itemBuilder: (_, index) {
              return Dismissible(
                key: ValueKey(_apiResponse.data[index].optionID),
                direction: DismissDirection.startToEnd,
                onDismissed: (direction) {},
                confirmDismiss: (direction) async {
                  final result = await showDialog(
                      context: context, builder: (_) => OptionsDelete());

                  if (result) {
                    final deleteResult = await service.deleteOption(_apiResponse.data[index].optionID);
                    var message;
                    if (deleteResult != null && deleteResult.data == true) {
                      message = 'The option was deleted successfully';
                    } else {
                      message = deleteResult?.errorMessage ?? 'An error occurred';
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

                    return deleteResult?.data ?? false;
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
                      title: Text(
                        _apiResponse.data[index].questionName,
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      subtitle: Text(_apiResponse.data[index].code + ' . ' + _apiResponse.data[index].name),
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (_) => OptionsModify(optionsID: _apiResponse.data[index].optionID)))
                            .then((data) {
                          _fetchOptions();
                        });
                      },
                    )),
              );
            },
            itemCount: _apiResponse.data.length,
          );
        },
      ),
    );
  }
}
