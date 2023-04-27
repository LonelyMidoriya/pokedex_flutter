import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../domain/models/pokemon_entry.dart';
import '../../utils/consts.dart';

class GridItem extends StatelessWidget {
  final PokemonEntry entry;
  const GridItem(this.entry, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const ShapeDecoration(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          color: gridCellColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CachedNetworkImage(
            placeholder: (context, url) => const CircularProgressIndicator(),
            width: 100,
            height: 100,
            fit: BoxFit.fill,
            errorWidget: (context, _, __) =>
                Image.asset(assetImage),
            imageUrl:
                '$imageUrl${entry.url.replaceAll(RegExp(r'[^0-9]'), '').substring(1)}.png',
          ),
          Text(
            entry.name.toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.w800),
          )
        ],
      ),
    );
  }
}
