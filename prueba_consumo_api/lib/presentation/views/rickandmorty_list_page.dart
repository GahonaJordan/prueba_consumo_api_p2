import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/rickandmorty_provider.dart';
import '../widgets/rickandmorty_card.dart';
import 'rickandmorty_detail_page.dart';

class RickAndMortyListPage extends ConsumerStatefulWidget {
  const RickAndMortyListPage({super.key});

  @override
  ConsumerState<RickAndMortyListPage> createState() => _RickAndMortyListPageState();
}

class _RickAndMortyListPageState extends ConsumerState<RickAndMortyListPage> {
  final ScrollController _scrollController = ScrollController();
  String searchQuery = '';
  String? selectedStatus;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        ref.read(rickAndMortyListProvider.notifier).loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final characters = ref.watch(rickAndMortyListProvider);

    // Filtrado por búsqueda y estado
    final filtered = characters.where((c) {
      final matchesSearch = c.name.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesStatus = selectedStatus == null || c.status == selectedStatus;
      return matchesSearch && matchesStatus;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo Rick and Morty'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                selectedStatus = value == 'Todos' ? null : value;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'Todos', child: Text('Todos')),
              const PopupMenuItem(value: 'Alive', child: Text('Alive')),
              const PopupMenuItem(value: 'Dead', child: Text('Dead')),
              const PopupMenuItem(value: 'unknown', child: Text('Unknown')),
            ],
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Buscar',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: filtered.length,
              itemBuilder: (_, i) {
                final character = filtered[i];
                return ListTile(
                  leading: Image.network(character.image, width: 56, height: 56, fit: BoxFit.cover),
                  title: Text(character.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Especie: ${character.species}'),
                      Text('Estado: ${character.status}'),
                      Text('Episodios: ${character.episode.length}'),
                    ],
                  ),
                  isThreeLine: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RickAndMortyDetailPage(character: character),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}