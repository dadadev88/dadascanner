import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:dadascanner/models/pokemon_model.dart';
import 'package:dadascanner/screens/screens.dart';
import 'package:dadascanner/widgets/widgets.dart';
import 'package:dadascanner/services/pokemons_service.dart';

class CapturePokemonScreen extends StatefulWidget {
  static const String routeName = '/capture-pokemon';

  const CapturePokemonScreen({Key? key}) : super(key: key);

  @override
  State<CapturePokemonScreen> createState() => _CapturePokemonScreenState();
}

class _CapturePokemonScreenState extends State<CapturePokemonScreen> {
  final int _maxPokeminId = 1025;

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final pokemonService = Provider.of<PokemonsService>(context, listen: true);

    return Scaffold(
      appBar: _getAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _getSearchTextField(context),
            const SizedBox(height: 16),
            _getButtons(pokemonService.getById, context),
            const SizedBox(height: 16),
            pokemonService.pokemonDetail != null
                ? Expanded(
                    child: SingleChildScrollView(
                      child: _getPokemonCaptureDetail(pokemonService),
                    ),
                  )
                : const Text('Find a pokemon to capture!'),
          ],
        ),
      ),
    );
  }

  TextField _getSearchTextField(BuildContext context) {
    return TextField(
      controller: _controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onChanged: (_) => setState(() {}),
      onSubmitted: (value) async {
        FocusScope.of(context).unfocus();
      },
      decoration: const InputDecoration(
        suffix: Icon(Icons.clear),
        labelText: 'Insert Pokemon number',
        filled: true,
      ),
    );
  }

  AppBar _getAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Capture Pokemon'),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.popAndPushNamed(context, HomeScreen.routeName);
        },
      ),
    );
  }

  Row _getButtons(Future<void> Function(int) getByid, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: _controller.text.isEmpty
              ? null
              : () => getByid(int.parse(_controller.text)),
          icon: const Icon(Icons.find_in_page),
          label: const Text('Find'),
        ),
        ElevatedButton.icon(
          onPressed: () async {
            Random random = Random();
            int randomPokemon = random.nextInt(this._maxPokeminId);
            _controller.text = '';
            FocusScope.of(context).unfocus();
            await getByid(randomPokemon);
          },
          icon: const Icon(Icons.radar_outlined),
          label: const Text('Random'),
        )
      ],
    );
  }

  Widget _getPokemonCaptureDetail(PokemonsService pokemonsService) {
    ;

    if (pokemonsService.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final pokemonDetail = pokemonsService.pokemonDetail!;
    Pokemon pokemon = Pokemon(
      name: pokemonDetail.name,
      id: pokemonDetail.id,
      img: pokemonDetail.img,
    );

    GlobalKey imgKey = GlobalKey();

    return Column(
      children: [
        PokemonCard(pokemon: pokemon, imgKey: imgKey),
        const SizedBox(height: 16),
        Ink(
          decoration:
              const ShapeDecoration(color: Colors.red, shape: CircleBorder()),
          child: IconButton(
            icon: const Icon(Icons.catching_pokemon),
            color: Colors.white,
            onPressed: () {
              final snackbar = SnackBar(
                content: Text('${pokemon.toString()} captured!'),
              );

              pokemonsService.cleanDetail();

              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            },
          ),
        )
      ],
    );
  }
}
