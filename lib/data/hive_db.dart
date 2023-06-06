import 'package:apad/models/note.dart';
import 'package:hive/hive.dart';

class HiveDatabase {
  //hive box
  final _myBox = Hive.box('note_data');

  //load data
  List<Note> loadNotes() {
    List<Note> savedNotesFormatted = [];

    if (_myBox.get("ALL_NOTES") != null) {
      List<dynamic> savedNotes = _myBox.get("ALL_NOTES");
      for (int i = 0; i < savedNotes.length; i++) {
        Note indivNote = Note(id: savedNotes[i][0], text: savedNotes[i][1]);
        savedNotesFormatted.add(indivNote);
      }
    } else {
      savedNotesFormatted.add(Note(id: 0, text: 'First Note'));
    }

    return savedNotesFormatted;
  }

  //save data
  void savedNotes(List<Note> allNotes){
    List<List<dynamic>> allNotesFormatted = [];
    for (var note in allNotes) {
      int id = note.id;
      String text = note.text;
      allNotesFormatted.add([id, text]);
    }

    _myBox.put("ALL_NOTES", allNotesFormatted);
  }
}
