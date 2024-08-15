import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rick_and_morty/domain/entities/character.dart';
import 'package:flutter_rick_and_morty/presentation/cubits/detalle_personaje_cubit.dart';
import 'package:flutter_rick_and_morty/presentation/cubits/detalle_personaje_state.dart';

class CharacterDetailPage extends StatelessWidget {
  final Character character;

  const CharacterDetailPage({super.key, required this.character});

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
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            state.character.image,
                            height: 250.0,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: Text(
                          state.character.name,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Divider(color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      _buildDetailRow('Status', state.character.status, context),
                      _buildDetailRow('Species', state.character.species, context),
                      _buildDetailRow('Gender', state.character.gender, context),
                      _buildDetailRow('Origin', state.character.origin, context),
                      _buildDetailRow('Location', state.character.location, context),
                    ],
                  ),
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

  Widget _buildDetailRow(String label, String value, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
