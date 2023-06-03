import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:marvel_heroes_app/models/character_details.dart';
import 'package:marvel_heroes_app/services/characters_service.dart';

class CharacterDetailsPage extends StatefulWidget {
  final int id;

  const CharacterDetailsPage({super.key, required this.id});

  @override
  State<CharacterDetailsPage> createState() => _CharacterDetailsPageState();
}

class _CharacterDetailsPageState extends State<CharacterDetailsPage> {
  CharacterDetails? details;
  final service = CharacterService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalles')),
      body: FutureBuilder(
          future: service.getCharacterDetails(characterId: widget.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: SpinKitPouringHourGlassRefined(
                  color: Colors.red,
                  size: 80,
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                final details = snapshot.data;
                if (details != null) {
                  return ListView(
                    children: [
                      Image.network(details.thumbnail),
                      Text(
                        details.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Descripcion',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              details.description == ''
                                  ? 'Noy hay descripcion disponible'
                                  : details.description,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Comics en los que aparece:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ...details.comics.map((comic) {
                              return Text('- $comic');
                            }).toList(),
                          ],
                        ),
                      )
                    ],
                  );
                } else {
                  return const Text('No hay detalles de este heroe');
                }
              }
            }

            return const Text('Ocurrio un error');
          }),
    );
  }
}
