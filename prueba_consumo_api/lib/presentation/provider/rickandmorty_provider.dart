import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasource/rickandmorty_api.dart';
import '../../domain/entities/rick_and_morty_character.dart';
import '../../domain/entities/rick_and_morty_location.dart';
import '../../domain/entities/rick_and_morty_episode.dart';
import '../../data/repositories/rickandmorty_repository_impl.dart';
import '../../aplication/usecase/fetch_rickandmorty_usecase.dart';

final _api = RickAndMortyApi();
final _repository = RickAndMortyRepositoryImpl(_api);
final _useCase = FetchRickAndMortyUseCase(_repository);
class RickAndMortyListNotifier extends StateNotifier<List<Character>> {
  RickAndMortyListNotifier() : super([]) {
    fetchInitial();
  }

  Future<void> fetchInitial() async {
    final characters = await _useCase.execute(limit: 10);
    state = characters;
  }

  Future<void> loadMore() async {
    final more = await _useCase.execute(limit: 10);
    state = [...state, ...more];
  }
}
final rickAndMortyListProvider =
    StateNotifierProvider<RickAndMortyListNotifier, List<Character>>(
  (ref) => RickAndMortyListNotifier(),
);

