import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_tcg_app/src/blocs/pokemon_cards_bloc.dart';
import 'package:pokemon_tcg_app/src/models/pokemon_card.dart';
import 'package:pokemon_tcg_app/src/repositories/pokemon_tcg_repository.dart';

class PokemonCardsPage extends StatelessWidget {
  const PokemonCardsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokémon TCG Cards'),
      ),
      body: BlocProvider(
        create: (_) => PokemonCardsBloc(
          pokemonTcgRepository: PokemonTcgRepository(),
        )..add(PokemonCardsFetched()),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  bottom: 16.0,
                ),
                child: SearchBar(),
              ),
              Expanded(
                child: BlocBuilder<PokemonCardsBloc, PokemonCardsState>(
                  builder: (context, state) {
                    if (state is PokemonCardsLoadSuccess) {
                      return GridView.count(
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                        crossAxisCount: 2,
                        children: List.generate(
                          state.cards.length,
                          (index) => PokemonCardWidget(
                            card: state.cards.elementAt(index),
                          ),
                        ),
                      );
                    } else if (state is PokemonCardsEmptyLoadSuccess) {
                      return const Center(
                        child: Text('No Pokémon Card was found.'),
                      );
                    } else if (state is PokemonCardsLoadInProgress) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is PokemonCardsLoadFailure) {
                      return const Center(
                        child: Text('Something went wrong.'),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: TextField(
              controller: _controller,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            context.read<PokemonCardsBloc>()
              ..add(
                PokemonCardsSearched(name: _controller.text),
              );
          },
        ),
      ],
    );
  }
}

class PokemonCardWidget extends StatelessWidget {
  const PokemonCardWidget({
    Key? key,
    required this.card,
  }) : super(key: key);

  final PokemonCard card;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(card.name);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 8.0,
                  ),
                  child: CachedNetworkImage(
                      imageUrl: card.image?.small ?? '',
                      placeholder: (context, url) {
                        return CircularProgressIndicator();
                      },
                      errorWidget: (context, url, error) {
                        return Center(
                          child: Text(
                            'Image not found.',
                          ),
                        );
                      }),
                ),
              ),
              Text(
                card.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
