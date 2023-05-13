import 'package:first_app/app/core/utils/DataHelper.dart';
import 'package:first_app/app/data/models/game.dart';

class GameProvider {
  Future<List<Game>> readGames() async {
    final List<Map<String, dynamic>> gameMaps = await DataHelper.getAll("Game");

    List<Game> games = List.generate(gameMaps.length, (i) {
      return Game.fromJson(gameMaps[i]);
    });
    return games;
  }
}
