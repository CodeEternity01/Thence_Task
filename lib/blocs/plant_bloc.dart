import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thence_assignment/models/api_service.dart';
import '../models/plant_model.dart';


// Events
abstract class PlantEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchPlants extends PlantEvent {}

// States
abstract class PlantState extends Equatable {
  @override
  List<Object> get props => [];
}

class PlantInitial extends PlantState {}

class PlantLoading extends PlantState {}

class PlantLoaded extends PlantState {
  final List<Plant> plants;

  PlantLoaded(this.plants);

  @override
  List<Object> get props => [plants];
}

class PlantError extends PlantState {
  final String message;

  PlantError(this.message);

  @override
  List<Object> get props => [message];
}

// BLoC
class PlantBloc extends Bloc<PlantEvent, PlantState> {
  final ApiService apiService;

  PlantBloc(this.apiService) : super(PlantInitial());

  @override
  Stream<PlantState> mapEventToState(PlantEvent event) async* {
    if (event is FetchPlants) {
      yield PlantLoading();
      try {
        final plants = await apiService.fetchPlants();
        yield PlantLoaded(plants);
      } catch (e) {
        yield PlantError('Failed to fetch plants');
      }
    }
  }
}

