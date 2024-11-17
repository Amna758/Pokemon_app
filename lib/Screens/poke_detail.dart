import 'package:flutter/material.dart';
import 'package:pokemon_app/Model/Poke_Model.dart';

class PokeDetail extends StatelessWidget {
  final Pokemon pokemon;
  const PokeDetail({Key? key, required this.pokemon}) : super(key: key);

  bodywidget(BuildContext context) => Stack(
        children: [
          Positioned(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width - 20,
            left: 10.0,
            top: MediaQuery.of(context).size.height * 0.1,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    pokemon.name ?? 'Unknown Pokemon',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Height:${pokemon.height}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Weight:${pokemon.weight}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Types",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ...(pokemon.type ?? [])
                          .map((t) => FilterChip(
                                backgroundColor: Colors.amberAccent,
                                label: Text(
                                  t,
                                  style: TextStyle(color: Colors.white),
                                ),
                                onSelected: (b) {},
                              ))
                          .toList(),
                    ],
                  ),
                  Text(
                    "Weaknesses",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ...(pokemon.weaknesses ?? [])
                          .map((t) => FilterChip(
                                backgroundColor: Colors.red,
                                label: Text(
                                  t,
                                  style: TextStyle(color: Colors.white),
                                ),
                                onSelected: (b) {},
                              ))
                          .toList(),
                    ],
                  ),
                  Text(
                    "Next Evolution",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ...(pokemon.nextEvolution ?? [])
                          .map((n) => FilterChip(
                                backgroundColor: Colors.green,
                                label: Text(n.name ?? 'another name',
                                    style: TextStyle(color: Colors.white)),
                                onSelected: (b) {},
                              ))
                          .toList(),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Hero(
              tag: pokemon.img ??
                  'default', // Provide a fallback tag if img is null
              child: Container(
                height: 170,
                width: 170,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      pokemon.img ??
                          'https://example.com/placeholder_image.png',
                    ), // Provide a fallback image URL
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        elevation: 0.0,
        toolbarHeight: 70,
        backgroundColor: Colors.cyan,
        title: Center(
          child: Text(
            pokemon.name ?? 'Unknown Pokemon', // Fallback if name is null
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: bodywidget(context),
    );
  }
}
