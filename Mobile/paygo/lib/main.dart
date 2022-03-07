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
      /// defining applicaion theme
      theme: ThemeData(
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
    ///initializing customer list from the api wile setting it to a future list
    ///flowing the model defined int the customer.dart file.
    ///the list can only be gotten through authorization code from a loged in agent
    ///which is shared through the sharedP reference from the login view.
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
    //print(_preferencesKey);
   // print(response.statusCode);
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
    /// this function checks if the Agent was login in by checking the shared[reference value token
    /// if not then the app loads the login page
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("token") == null){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => const LoginPage()), (route) => false);


    }
  }
  @override
  void initState(){
    ///adding listeners to check agent's login state and fetch
    ///customers
    super.initState();
    checkLoginStatus();
    listCustomers = fetchCustomer();
  }

  @override
  Widget build(BuildContext context) {
    /// creating the app's body
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
             // showSearch(context: context, delegate: SearchName( listCustomers: listCustomers));
            },

          ),

        ],
        centerTitle: true,
      ),
      ///defining the body of the app by displaying the customer list from
      ///the server and divided each user with a seperator
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
      ///creating side menu that will hold the sign out button
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
/*  late Future<List<Customer>> listCustomers;
  SearchName({required this.listCustomers});
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
    //lead icon on the left of the search bar
    return IconButton(
      icon:AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){},
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //show some sugestion from the custoner list
    List customer =  listCustomers as List ;
    final results = customer
        .where((q) => q.username.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView(
        children: results
            .map<ListTile>(
              (customer) => ListTile(
            title: Text(
                customer.username,
                style: const TextStyle(fontWeight: FontWeight.bold,
                    fontSize: 22)
            ),
            onTap: () {
              query = customer.username;

              // close(context, f);
              // Navigator.pop(context);
            },
          ),
        )
            .toList());
  }

  @override
  Widget buildResults(BuildContext context) {
    //shows when someone searches for something
    List customer =  listCustomers as List ;
    final results = customer
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
