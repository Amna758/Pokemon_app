import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon_app/Model/Poke_Model.dart';
import 'package:pokemon_app/Screens/poke_detail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var url =
      "https://raw.githubusercontent.com/Biuni/PokemonGo-Pokedex/master/pokedex.json";

  late PokeModel pokeModel =
      PokeModel(pokemon: []); // Initialize pokeModel as late
  bool isLoading = true; // To show a loading indicator initially

  @override
  void initState() {
    super.initState();
    Fetchdata();
  }

  Fetchdata() async {
    try {
      var response = await http.get(Uri.parse(url));
      var decodedJson = jsonDecode(response.body);
      setState(() {
        pokeModel = PokeModel.fromJson(decodedJson);
        isLoading = false; // Stop showing the loading indicator
      });
    } catch (e) {
      print("Error fetching data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        toolbarHeight: 70,
        title: Center(
          child: Text(
            "Poke App",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        onPressed: () {
          setState(() {
            isLoading = true; // Show loading indicator during refresh
          });
          Fetchdata(); // Refresh data on button press
        },
        child: Icon(
          Icons.refresh,
          color: Colors.white,
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading spinner
          : GridView.count(
              crossAxisCount: 2,
              children: pokeModel.pokemon!.map((poke) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PokeDetail(pokemon: poke)));
                  },
                  child: Hero(
                    tag: poke.img ?? "", // Using empty string as fallback
                    child: Card(
                      elevation: 5,
                      margin: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            poke.img ??
                                'https://via.placeholder.com/100x100.png?text=No+Image', // Random placeholder image URL
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 10),
                          Text(
                            poke.name ?? "No Name",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
    );
  }
}
