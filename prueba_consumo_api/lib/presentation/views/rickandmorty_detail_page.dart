import 'package:flutter/material.dart';
import '../../domain/entities/rick_and_morty_character.dart';

class RickAndMortyDetailPage extends StatelessWidget {
  final Character character;

  const RickAndMortyDetailPage({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(character.image, height: 200),
            ),
            const SizedBox(height: 16),
            Text('Nombre: ${character.name}', style: const TextStyle(fontSize: 20)),
            Text('Estado: ${character.status}'),
            Text('Especie: ${character.species}'),
            Text('Género: ${character.gender}'),
            Text('Origen: ${character.originName}'),
            Text('Ubicación: ${character.locationName}'),
            const SizedBox(height: 16),
            Text('Episodios:', style: const TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: character.episode.length,
                itemBuilder: (_, i) => Text(character.episode[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}