import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:birthday_displayer_app/widget/listCardWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _searchController = TextEditingController();

  Future resultsLoaded;
  List _allResults = [];
  List _resultsList = [];

  @override
  void initState() {
    // TODO: implement initState
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultsLoaded = getUsersStreamSnapshots();
  }

  _onSearchChanged() {
    searchResults();
    print(_searchController.text);
  }

  searchResults() {
    var showResults = [];
    if (_searchController.text != "") {
      for (var profileInfo in _allResults) {
        var name = profileInfo['name'];
        if (name.contains(_searchController.text)) {
          showResults.add(profileInfo);
        }
      }
    } else {
      showResults = List.from(_allResults);
      print(_allResults);
    }
    setState(() {
      _resultsList = showResults;
    });
  }

  getUsersStreamSnapshots() async {
    var data = await FirebaseFirestore.instance.collection('profileinfo').get();
    setState(() {
      _allResults = data.docs;
    });
    searchResults();
    return 'Complete';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            MaterialButton(
              child: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/modify_screen');
              },
            )
          ],
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
          title: Text(
            'BIRTHDAYS',
            style: TextStyle(
              letterSpacing: 2.0,
            ),
          ),
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 1.5,
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search_sharp,
                    ),
                  ),
                  controller: _searchController,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 8.0),
                  child: ListView.builder(
                      itemCount: _resultsList.length,
                      itemBuilder: (BuildContext context, int index) =>
                          buildListCard(context, _resultsList[index])),
                ),
              )
            ],
          ),
        ));
  }
}
