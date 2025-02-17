import 'dart:convert';
import 'dart:io';
import 'package:dadascanner/interfaces/loading_notifier.dart';
import 'package:dadascanner/models/pokemon_detaiil_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dadascanner/models/pokemon_model.dart';

class PokemonsService extends LoadingNotifier {
  final String _baseUrl = Platform.isAndroid ? '10.0.2.2:3000' : '0.0.0.0:3000';
  final String _baseUrlPokeApi = 'pokeapi.co';
  List<Pokemon> pokemons = [];
  PokemonDetail? pokemonDetail;

  Future<void> getAll() async {
    try {
      this.openLoading();
      Uri uri = Uri.http(_baseUrl, '/pokemons');
      final response = await http.get(uri);
      final List<dynamic> data = json.decode(response.body);
      this.pokemons = data.map((e) => Pokemon.fromJson(e)).toList();
    } catch (e) {
      debugPrint('Error to get pokemons');
      debugPrint(e.toString());
    } finally {
      this.closeLoading();
    }
  }

  Future<void> getById(int pokemonId) async {
    try {
      this.openLoading();
      Uri uri = Uri.https(_baseUrlPokeApi, '/api/v2/pokemon/$pokemonId');
      final response = await http.get(uri);
      final jsonString = json.decode(response.body);
      this.pokemonDetail = PokemonDetail.fromJson(jsonString);
      this.closeLoading();
    } catch (e) {
      debugPrint('Id do not exists');
    }
  }

  void cleanDetail() {
    this.pokemonDetail = null;
    notifyListeners();
  }
}
