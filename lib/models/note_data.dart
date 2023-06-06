import 'package:apad/data/hive_db.dart';
import 'package:flutter/material.dart';

import 'note.dart';

class NoteData extends ChangeNotifier {
  final db = HiveDatabase();
  //List of notes
  List<Note> allNotes = [];

  //initialize list
  void initializeNotes() {
    allNotes = db.loadNotes();
  }

  //get notes
  List<Note> getAllNotes() {
    return allNotes;
  }
  //add a new note
  void addNewNote(Note note) {
    allNotes.add(note);
    notifyListeners();
  }
  //update note
  void updateNote(Note note, String text) {
    for(int i=0;i<allNotes.length; i++) {
      if(allNotes[i].id == note.id) {
        allNotes[i].text = text;
        notifyListeners();
      }
    }
  }
  //delete note
  void deleteNote(Note note){
    allNotes.remove(note);
    notifyListeners();
  }
}