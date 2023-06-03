import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:marvel_heroes_app/models/character.dart';
import 'package:marvel_heroes_app/pages/character_details_page.dart';
import 'package:marvel_heroes_app/services/characters_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PagingController<int, Character> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    const pageSize = 15;
    final characterService = CharacterService();
    final offset = (pageKey - 1) * pageSize;
    final newItems =
        await characterService.getCharacters(offset: offset, limit: pageSize);
    final isLastPage = newItems.result.length < pageSize;

    if (isLastPage) {
      _pagingController.appendLastPage(newItems.result);
    } else {
      final newPage = pageKey + 1;
      _pagingController.appendPage(newItems.result, newPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Marvel Heroes'),
      ),
      body: PagedListView<int, Character>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Character>(
          firstPageProgressIndicatorBuilder: (context) {
            return const SpinKitPouringHourGlassRefined(
              color: Colors.red,
              size: 80,
            );
          },
          newPageProgressIndicatorBuilder: (context) {
            return const SpinKitWaveSpinner(color: Colors.red);
          },
          itemBuilder: (context, character, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(character.thumbnail),
              ),
              title: Text(character.name),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return CharacterDetailsPage(id: character.id);
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
