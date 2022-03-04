import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_page.dart';
import 'models/customer.dart';


void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PAYGO Agent',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(secondary: Colors.white70)
      ),
      home: const MyHomePage(),

    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);


  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {
  late SharedPreferences sharedPreferences;
  late Future<List<Customer>> listCustomers;


  Future<List<Customer>> fetchCustomer() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var _preferencesKey = sharedPreferences.getString('token');


    var url= Uri.parse('https://paygoapp.herokuapp.com/api/v1/customers/');
    final response = await http.get(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Token $_preferencesKey',
        },
    );
    print(_preferencesKey);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      var getCustomersData = json.decode(response.body) as List;
      var listCustomers = getCustomersData.map((i) => Customer.fromJSON(i)).toList();

      return listCustomers;
    } else {
      throw Exception('Failed to load Customers');

    }
  }

  checkLoginStatus() async{
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("token") == null){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => const LoginPage()), (route) => false);


    }
  }
  @override
  void initState(){
    super.initState();
    checkLoginStatus();
    listCustomers = fetchCustomer();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("PAYGO", style: TextStyle(color: Colors.white)),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              /*showsearch(
                 // context: context, delegate: SearchName(SearchName: listCustomers)
              );*/
            },

          ),

        ],
        centerTitle: true,
      ),
      body: FutureBuilder <List<Customer>>(
        future: listCustomers,
        builder:(context, snapshot){
          if(snapshot.hasData){
            return ListView.separated(itemBuilder: (context, index){
              var customer = (snapshot.data as List<Customer>)[index];
              return Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text(
                    customer.username,
                    style: const TextStyle(fontWeight: FontWeight.bold,
                    fontSize: 22),
                  ),
                    const SizedBox(height: 5,),
                    Text('Region: '+customer.region),
                    const SizedBox(height: 5),
                    Text('Amount Repaid: '+(customer.amountRepaid).toString()),
                    const SizedBox(height: 5),
                    Text('Amount Arrears Payment: '+(customer.arrearsPrepayment).toString()),
                    const SizedBox(height: 5),
                    Text('Amount Loan: '+(customer.loanAmount).toString()),
                    const SizedBox(height: 5),
                    Text('Expected date: '+ (customer.expectedPayDate).toString()),
                    const SizedBox(height: 5),
                    Text('Phone Number: '+(customer.phoneNumber).toString()),
                    const SizedBox(height: 5),
                    Text('Coordinates: '+customer.coordinates),


                  ],
                ),
              );
            }, separatorBuilder: (context, index){
              return const Divider();
            }, itemCount: (snapshot.data as List<Customer>).length);

          }
          else if(snapshot.hasError){
            return Center(
              child: Text("${snapshot.error}"),
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.cyan,
            ),
          );
        } ,

      ),
      drawer:  Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Menu'),
            ),
            ListTile(
              title: const Text('Log Out'),
              onTap: () {
                // Update the state of the app.
                sharedPreferences.clear();
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => const LoginPage()), (route) => false);

              },
            ),
          ],
        ),
      ),
    );
  }
}
/*
class SearchName extends SearchDelegate<Customer> {
  late List<Customer> searchName;
  SearchName({required this.searchName});
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = searchName
        .where((q) => q.username.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView(
        children: results
            .map<ListTile>(
              (f) => ListTile(
            title: Text(
              f.username,
                style: const TextStyle(fontWeight: FontWeight.bold,
                    fontSize: 22)
            ),
            onTap: () {
              query = f.username;

              // close(context, f);
              // Navigator.pop(context);
            },
          ),
        )
            .toList());
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final results = searchName
        .where((q) => q.username.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView(
        children: results
            .map<ListTile>(
              (customer) => ListTile(
            title: Text(
              customer.username,
              style: const TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
            onTap: () {
              query = customer.username;
              padding:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:(context){

                      return ListView.separated(itemBuilder: (context, index){

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [Text(
                            customer.username,
                            style: const TextStyle(fontWeight: FontWeight.bold,
                                fontSize: 22),
                          ),
                            const SizedBox(height: 5,),
                            Text('Region: '+customer.region),
                            const SizedBox(height: 5),
                            Text('Amount Repaid: '+(customer.amountRepaid).toString()),
                            const SizedBox(height: 5),
                            Text('Amount Arrears Payment: '+(customer.arrearsPrepayment).toString()),
                            const SizedBox(height: 5),
                            Text('Amount Loan: '+(customer.loanAmount).toString()),
                            const SizedBox(height: 5),
                            Text('Expected date: '+ (customer.expectedPayDate).toString()),
                            const SizedBox(height: 5),
                            Text('Phone Number: '+(customer.phoneNumber).toString()),
                            const SizedBox(height: 5),
                            Text('Coordinates: '+customer.coordinates),


                          ],
                        );
                      }, separatorBuilder: (context, index){
                        return const Divider();
                      }, itemCount: (customer as List<Customer>).length);


                  },
                ),
              );
              // close(context, f);
              // Navigator.pop(context);
            },
          ),
        )
            .toList());
  }
}*/
