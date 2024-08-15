import 'package:equatable/equatable.dart';
import 'package:flutter_rick_and_morty/domain/entities/character.dart';

abstract class DetallePersonajeState extends Equatable {
  const DetallePersonajeState();

  @override
  List<Object?> get props => [];
}

class DetallePersonajeInitial extends DetallePersonajeState {}

class DetallePersonajeLoading extends DetallePersonajeState {}

class DetallePersonajeLoaded extends DetallePersonajeState {
  final Character character;

  const DetallePersonajeLoaded(this.character);

  @override
  List<Object?> get props => [character];
}

class DetallePersonajeError extends DetallePersonajeState {
  final String message;

  const DetallePersonajeError(this.message);

  @override
  List<Object?> get props => [message];
}
