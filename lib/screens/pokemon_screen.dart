import 'package:dadascanner/extensions/string.dart';
import 'package:dadascanner/models/pokemon_detaiil_model.dart';
import 'package:dadascanner/models/pokemon_model.dart';
import 'package:dadascanner/services/pokemons_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PokemonScreen extends StatefulWidget {
  static const String routeName = 'pokemon_detail';
  const PokemonScreen({super.key});

  @override
  State<PokemonScreen> createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {
  @override
  Widget build(BuildContext context) {
    final PokemonsService service = Provider.of<PokemonsService>(context);
    final int pokemonId = ModalRoute.of(context)!.settings.arguments as int;
    final Pokemon pokemon = service.pokemons.firstWhere(
      (p) => p.id == pokemonId,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name.capitalizeWords()),
      ),
      body: Center(
        child: Column(
          children: [
            Hero(
              tag: pokemon.img,
              child: FadeInImage(
                placeholder: const AssetImage('assets/images/pokeball.png'),
                image: NetworkImage(pokemon.img),
                fit: BoxFit.fitHeight,
                width: double.infinity * 0.7,
              ),
            ),
            const SizedBox(height: 20),
            _getDetailBody(service.pokemonDetail)
          ],
        ),
      ),
    );
  }

  Widget _getDetailBody(PokemonDetail? pokemonDetail) {
    if (pokemonDetail == null) return const CircularProgressIndicator();

    return Column(
      children: [
        Text('Experience: ${pokemonDetail.baseExperience}'),
      ],
    );
  }
}
