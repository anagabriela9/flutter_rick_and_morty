import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rick_and_morty/presentation/cubits/personajes_cubit.dart';
import 'package:flutter_rick_and_morty/presentation/pages/character_detail_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick and Morty Characters'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CharacterSearchDelegate(
                  onSearch: (query) {
                    setState(() {
                      searchQuery = query;
                    });
                    context.read<PersonajesCubit>().fetchCharacters(query);
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<PersonajesCubit, PersonajesState>(
        builder: (context, state) {
          if (state is PersonajesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PersonajesLoaded) {
            return ListView.builder(
              itemCount: state.characters.length,
              itemBuilder: (context, index) {
                final character = state.characters[index];
                return ListTile(
                  leading: Image.network(character.image),
                  title: Text(character.name),
                  subtitle: Text('${character.species} - ${character.status}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CharacterDetailPage(character: character),
                      ),
                    );
                  },
                );
              },
            );
          } else if (state is PersonajesError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('No characters found.'));
          }
        },
      ),
    );
  }
}

class CharacterSearchDelegate extends SearchDelegate {
  final Function(String) onSearch;

  CharacterSearchDelegate({required this.onSearch});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    onSearch(query);
    return Container(); // La lógica para mostrar resultados ya está en el Cubit
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
