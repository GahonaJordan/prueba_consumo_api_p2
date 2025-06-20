import '../../domain/entities/rick_and_morty_character.dart';
import '../../domain/entities/rick_and_morty_episode.dart';
import '../../domain/entities/rick_and_morty_location.dart';
import '../../data/repositories/rickandmorty_repository_impl.dart';

class FetchRickAndMortyUseCase {
  final RickAndMortyRepositoryImpl repositoryImpl;

  FetchRickAndMortyUseCase(this.repositoryImpl);

  // Método ejecutar
  Future<List<Character>> execute({int limit = 10}) =>
      repositoryImpl.getRickAndMorty(limit: limit);
  Future<List<Episode>> executeEpisodes({int limit = 10}) =>
      repositoryImpl.getRickAndMortyEpisodes(limit: limit);
  Future<List<Location>> executeLocations({int limit = 10}) =>
      repositoryImpl.getRickAndMortyLocations(limit: limit);
}