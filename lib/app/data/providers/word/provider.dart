import '../../../core/utils/DataHelper.dart';
import '../../models/Word.dart';

class WordProvider
{

  Future<List<Word>> readWords() async {
    final List<Map<String,dynamic>> wordMaps = await DataHelper.getAll("Word");
    List<Word> words = List.generate(wordMaps.length, (i) {
      return Word.fromJson(wordMaps[i]);
    });
    return words;
  }


}