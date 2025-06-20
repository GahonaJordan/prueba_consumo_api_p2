import 'package:flutter/material.dart';
import '../../../domain/entities/rick_and_morty_character.dart';
import '../../../domain/entities/rick_and_morty_location.dart';
import '../../../domain/entities/rick_and_morty_episode.dart';

class RickAndMortyCard extends StatelessWidget {
  final Character character;
  final Location? location;
  final Episode? episode;


  const RickAndMortyCard({
    super.key,
    required this.character,
    this.location,
    this.episode,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(character.image),
          radius: 30,
        ),
        title: Text(character.name),
        subtitle: Text('Status: ${character.status}'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (location != null) Text('Location: ${location!.name}'),
            if (episode != null) Text('Episode: ${episode!.name}'),
          ],
        ),
      ),
    );
  }
}