import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'grid.dart';
import 'content.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Philo', primarySwatch: Colors.purple),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var calories;
  var caloriescheck;
  var weight;
  var protein;
  var labels;
  var error;
  bool requst = true;
  var responseJson;

  bool pbar = false;

  bool iscalory = true;

  TextEditingController _nameController = TextEditingController();

  knowDiet(String diet) async {
    final response = await http.get(
      'https://edamam-edamam-nutrition-analysis.p.rapidapi.com/api/nutrition-data?ingr=$diet',
      headers: {
        "X-RapidAPI-Host": "edamam-edamam-nutrition-analysis.p.rapidapi.com",
        "X-RapidAPI-Key": "a29ac21fabmsh82de3b391187b03p1a9d95jsn09596bfc5528"
      },
    );

    if (response.statusCode == 200) {
      responseJson = json.decode(response.body);

      caloriescheck = responseJson['calories'];

      calories = responseJson['calories'];
      calories =
          num.parse(calories.toStringAsFixed(1)).toString(); //absolute value

      weight = responseJson['totalWeight'];
      weight = num.parse(weight.toStringAsFixed(1)).toString();

      protein = responseJson['totalNutrients']['PROCNT']['quantity'];
      protein = num.parse(protein.toStringAsFixed(1)).toString();

      labels = responseJson['healthLabels'];

//print(labels);

      if (calories == '0') {
        requst = false;
      } else {
        requst = true;
      }
    } else {
      requst = false;
    }

    error =
        "1. Please checkout if your input is correct.\n 2. Please check you have a working internet connection.\n 3. Then retry. ";

    print(requst);
    print(calories);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Diet Analyzer"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                color: Colors.redAccent,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Text("Analyze Diet",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold)),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 300,
                          margin: EdgeInsets.all(20),
                          child: TextField(
                            controller: _nameController,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: "Ex: 1 large apple",
                              hintStyle: TextStyle(fontSize: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              filled: true,
                              contentPadding: EdgeInsets.all(12),
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                        InkWell(
                          child: ClipOval(
                            child: Container(
                              padding: EdgeInsets.all(8),
                              color: Colors.white,
                              child: Icon(
                                Icons.search,
                                color: Colors.redAccent,
                              ),
                            ),
                          ),
                          onTap: () => knowDiet(_nameController.text),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              requst == false
                  ? Center(
                      child: Center(
                        child: Text(error),
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(bottom: 20, top: 20),
                      color: Colors.blueAccent,
                      padding: EdgeInsets.all(4.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Text('Macros',
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Content(calories, "Calories:", "kCAL"),
                                Content(weight, "Weight:", "Gram"),
                                Content(protein, "Protein:", "Gram"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
              Container(
                color: Colors.blueAccent,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text('Diet Labels',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                    DietLabels(labels),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
