import '../../domain/entities/rick_and_morty_character.dart';
import '../../domain/entities/rick_and_morty_episode.dart';
import '../../domain/entities/rick_and_morty_location.dart';
import '../../data/datasource/rickandmorty_api.dart';

class RickAndMortyRepositoryImpl {
  final RickAndMortyApi api;

  RickAndMortyRepositoryImpl(this.api);

  // Método para obtener los personajes
  Future<List<Character>> getRickAndMorty({int limit = 10}) =>
      api.fetchCharacters(limit: limit);

  // Método para obtener los episodios
  Future<List<Episode>> getRickAndMortyEpisodes({int limit = 10}) =>
      api.fetchEpisodes(limit: limit);

  // Método para obtener las ubicaciones
  Future<List<Location>> getRickAndMortyLocations({int limit = 10}) =>
      api.fetchLocations(limit: limit);
}