import 'package:dadascanner/extensions/string.dart';
import 'package:dadascanner/models/pokemon_model.dart';
import 'package:dadascanner/widgets/badge_text.dart';
import 'package:flutter/material.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;
  final double _cardMargin = 10;
  final double _imgHeigth = 250;
  final Function(BuildContext context)? onTap;
  final GlobalKey? imgKey;

  const PokemonCard({
    super.key,
    required this.pokemon,
    this.imgKey,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double heigth = _imgHeigth + _cardMargin + 80;

    return GestureDetector(
      onTap: () => this.onTap == null ? null : this.onTap!(context),
      child: Container(
        margin: EdgeInsets.all(_cardMargin),
        width: screenSize.width,
        height: heigth,
        decoration: _getDecoration(),
        child: _getContent(screenSize),
      ),
    );
  }

  Padding _getContent(Size screenSize) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          _getImage(screenSize.width),
          BadgeText('#${this.pokemon.id.toString().padLeft(3, '0')}'),
          Text(
            this.pokemon.name.capitalizeWords(),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }

  // Widget _getPokemonTypes(double screenWidth) {
  //   final double typesQtyWitdth = this.pokemon.types.length * 80;
  //   return Center(
  //     widthFactor: 1,
  //     child: SizedBox(
  //       width: typesQtyWitdth,
  //       height: 18,
  //       child: ListView.builder(
  //         scrollDirection: Axis.horizontal,
  //         itemCount: this.pokemon.types.length,
  //         itemBuilder: (_, i) {
  //           return BadgeText(
  //             this.pokemon.types[i].toString().capitalizeWords(),
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }

  Widget _getImage(double screenWith) {
    return SizedBox(
      height: _imgHeigth,
      child: Stack(children: [
        Container(
          width: 200,
          height: 200,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(100)),
          ),
        ),
        Positioned(
          bottom: 5,
          child: Hero(
            tag: this.pokemon.img,
            child: FadeInImage(
              key: imgKey,
              placeholder: const AssetImage('assets/images/pokeball.png'),
              image: NetworkImage(this.pokemon.img),
              fit: BoxFit.fitHeight,
              height: 200,
            ),
          ),
        ),
      ]),
    );
  }

  BoxDecoration _getDecoration() {
    return BoxDecoration(
      color: Colors.grey.shade300,
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      boxShadow: [
        BoxShadow(
          color: Colors.white.withOpacity(.8),
          offset: const Offset(2, 1),
          blurRadius: 5,
          spreadRadius: 1,
        )
      ],
    );
  }
}
