import 'package:dadascanner/models/pokemon_model.dart';
import 'package:dadascanner/screens/screens.dart';
import 'package:dadascanner/services/pokemons_service.dart';
import 'package:dadascanner/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PokemonsScreen extends StatefulWidget {
  static const String routeName = 'pokemons';

  const PokemonsScreen({super.key});

  @override
  State<PokemonsScreen> createState() => _PokemonsScreenState();
}

class _PokemonsScreenState extends State<PokemonsScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      Provider.of<PokemonsService>(context, listen: false).getAll();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _onRefresh(PokemonsService service) async {
    service.getAll();
  }

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<PokemonsService>(context);
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: _getAppBar(context, service),
      body: RefreshIndicator(
        onRefresh: () => _onRefresh(service),
        child: service.isLoading
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 10),
                    Text('Getting pokemons...')
                  ],
                ),
              )
            : Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Center(
                    child: service.pokemons.isEmpty
                        ? const Text('Do not have data')
                        : _getPokemonsBuilder(service, screenSize.width),
                  ),
                ),
              ),
      ),
    );
  }

  AppBar _getAppBar(BuildContext context, PokemonsService service) {
    return AppBar(
      title: const Center(
        child: Text('Pokemons', textAlign: TextAlign.center),
      ),
      leading: GestureDetector(
        onTap: () => Navigator.of(context).popAndPushNamed(
          HomeScreen.routeName,
        ),
        child: const Icon(Icons.arrow_back_ios_new),
      ),
      actions: [
        IconButton(
          onPressed: () => _onRefresh(service),
          icon: const Icon(Icons.refresh_rounded),
        )
      ],
    );
  }

  Widget _getPokemonsBuilder(PokemonsService service, double screenWidth) {
    List<Pokemon> pokemons = service.pokemons;
    final int itemCount = pokemons.length;

    if (screenWidth > 500) {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: itemCount,
        itemBuilder: (_, i) => _itemBuilderFn(pokemons[i]),
      );
    }

    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (_, i) => _itemBuilderFn(pokemons[i]),
    );
  }

  PokemonCard _itemBuilderFn(Pokemon pokemon) {
    return PokemonCard(
      pokemon: pokemon,
      onTap: (BuildContext context) {
        final service = Provider.of<PokemonsService>(context, listen: false);

        service.getById(pokemon.id);

        Navigator.pushNamed(
          context,
          PokemonScreen.routeName,
          arguments: pokemon.id,
        );
      },
    );
  }
}
