import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rick_and_morty/domain/entities/character.dart';
import 'package:flutter_rick_and_morty/presentation/cubits/detalle_personaje_cubit.dart';

class CharacterDetailPage extends StatelessWidget {
  final Character character;

  const CharacterDetailPage({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetallePersonajeCubit()..loadCharacterDetail(character),
      child: Scaffold(
        appBar: AppBar(
          title: Text(character.name),
        ),
        body: BlocBuilder<DetallePersonajeCubit, DetallePersonajeState>(
          builder: (context, state) {
            if (state is DetallePersonajeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DetallePersonajeLoaded) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Image.network(state.character.image),
                    const SizedBox(height: 16),
                    Text(
                      state.character.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text('Status: ${state.character.status}'),
                    Text('Species: ${state.character.species}'),
                    Text('Gender: ${state.character.gender}'),
                    Text('Origin: ${state.character.origin}'),
                    Text('Location: ${state.character.location}'),
                  ],
                ),
              );
            } else if (state is DetallePersonajeError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text('No details available.'));
            }
          },
        ),
      ),
    );
  }
}
