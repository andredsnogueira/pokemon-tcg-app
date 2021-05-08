import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_tcg_app/src/models/pokemon_card.dart';

class PokemonCardDetailsPage extends StatelessWidget {
  final PokemonCard card;
  const PokemonCardDetailsPage({
    Key? key,
    required this.card,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(card.name),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          CachedNetworkImage(
            imageUrl: card.image?.small ?? '',
            height: MediaQuery.of(context).size.height / 3,
            fit: BoxFit.contain,
            placeholder: (context, url) {
              return Center(
                child: CircularProgressIndicator(),
              );
            },
            errorWidget: (context, url, error) {
              return Center(
                child: Text(
                  'Image not found.',
                ),
              );
            },
          ),
          InformationSection(
            title: 'Information',
            children: [
              ListItem(
                title: 'Name',
                trailingLabel: card.name,
              ),
              if (card.hp != null)
                ListItem(
                  title: 'HP',
                  trailingLabel: card.hp!,
                ),
              if (card.level != null)
                ListItem(
                  title: 'Level',
                  trailingLabel: card.level!,
                ),
              ListItem(
                title: 'Supertype',
                trailingLabel: card.supertype,
              ),
              if (card.evolvesFrom != null)
                ListItem(
                  title: 'Evolves from',
                  trailingLabel: card.evolvesFrom!,
                ),
            ],
          ),
          if (card.attacks != null && card.attacks!.isNotEmpty)
            InformationSection(
              title: 'Attacks',
              children: card.attacks!
                  .map(
                    (attack) => ListItem(
                      title: attack.name,
                      subtitle: attack.text,
                      trailingLabel: attack.damage,
                    ),
                  )
                  .toList(),
            ),
          if (card.abilities != null && card.abilities!.isNotEmpty)
            InformationSection(
              title: 'Abilities',
              children: card.abilities!
                  .map(
                    (ability) => ListItem(
                      title: ability.name,
                      subtitle: ability.text,
                      trailingLabel: ability.type,
                    ),
                  )
                  .toList(),
            ),
          if (card.types != null && card.types!.isNotEmpty)
            InformationSection(
              title: 'Types',
              children: card.types!
                  .map(
                    (type) => ListItem(
                      title: type,
                    ),
                  )
                  .toList(),
            ),
          if (card.subtypes != null && card.subtypes!.isNotEmpty)
            InformationSection(
              title: 'Subtypes',
              children: card.subtypes!
                  .map(
                    (subtype) => ListItem(
                      title: subtype,
                    ),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }
}

class InformationSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const InformationSection({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16.0,
          ),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.blueAccent,
            ),
          ),
        ),
        ...children,
      ],
    );
  }
}

class ListItem extends StatelessWidget {
  final String title;
  final String? trailingLabel;
  final String? subtitle;

  const ListItem({
    Key? key,
    required this.title,
    this.trailingLabel,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle:
              subtitle != null && subtitle!.isNotEmpty ? Text(subtitle!) : null,
          trailing: trailingLabel != null && trailingLabel!.isNotEmpty
              ? Text(trailingLabel!)
              : null,
        ),
        Divider(),
      ],
    );
  }
}
