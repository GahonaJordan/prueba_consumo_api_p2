import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../../domain/entities/rick_and_morty_character.dart';
import '../../domain/entities/rick_and_morty_episode.dart';
import '../../domain/entities/rick_and_morty_location.dart';

class RickAndMortyApi {
  final baseUrl = 'https://rickandmortyapi.com/api';

  // Método fetch
  Future<List<Character>> fetchCharacters({int limit = 10}) async {
    final response = await http.get(Uri.parse('$baseUrl/character?limit=$limit'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results']; // lista de personajes básicos

      // Obtener el detalle de cada uno (para usar la clase RickAndMorty)
      final characters = <Character>[];

      for (var result in results) {
        final detailResponse = await http.get(Uri.parse(result['url']));
        if (detailResponse.statusCode == 200) {
          final detailData = json.decode(detailResponse.body);
          characters.add(Character.fromJson(detailData));
        }
      }

      return characters;
    } else {
      throw Exception('Error al cargar los personajes');
    }
  }

  Future<List<Episode>> fetchEpisodes({int limit = 10}) async {
    final response = await http.get(Uri.parse('$baseUrl/episode?limit=$limit'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results']; // lista de episodios básicos

      // Obtener el detalle de cada uno (para usar la clase Episode)
      final episodes = <Episode>[];

      for (var result in results) {
        final detailResponse = await http.get(Uri.parse(result['url']));
        if (detailResponse.statusCode == 200) {
          final detailData = json.decode(detailResponse.body);
          episodes.add(Episode.fromJson(detailData));
        }
      }

      return episodes;
    } else {
      throw Exception('Error al cargar los episodios');
    }
  }

  Future<List<Location>> fetchLocations({int limit = 10}) async {
    final response = await http.get(Uri.parse('$baseUrl/location?limit=$limit'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results']; // lista de ubicaciones básicas

      // Obtener el detalle de cada una (para usar la clase Location)
      final locations = <Location>[];

      for (var result in results) {
        final detailResponse = await http.get(Uri.parse(result['url']));
        if (detailResponse.statusCode == 200) {
          final detailData = json.decode(detailResponse.body);
          locations.add(Location.fromJson(detailData));
        }
      }

      return locations;
    } else {
      throw Exception('Error al cargar las ubicaciones');
    }
  }
}