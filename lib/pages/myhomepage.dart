import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';
import '../models/note_data.dart';
import 'editing_note_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<NoteData>(context, listen: false).initializeNotes();
  }

  //create a new note
  void createNewNote() {
    int id = Provider.of<NoteData>(context, listen: false).getAllNotes().length;
    Note newNote = Note(id: id, text: '');

    goToNotePage(newNote, true);
  }

  //editing page handle
  goToNotePage(Note note, bool isNew) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditingNotePage(note: note, isNew: isNew),
        ));
  }

  //delete note
  void deleteNote(Note note) {
    Provider.of<NoteData>(context, listen: false).deleteNote(note);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteData>(
      builder: (context, value, child) => Scaffold(
          // appBar: AppBar(
          //   backgroundColor: CupertinoDynamicColor.resolve(CupertinoColors.systemBackground, context),
          //   title: const Text(
          //         'APad',
          //         style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: CupertinoColors.systemGrey)
          //         ),
          // ),
          backgroundColor: CupertinoColors.systemGroupedBackground,
          floatingActionButton: FloatingActionButton(
            onPressed: createNewNote,
            elevation: 0,
            backgroundColor: Colors.grey[400],
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 25.0, top: 75),
                child: Text(
                  'Notes',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),

              //List of notes
              value.getAllNotes().isEmpty
                  ? const Padding(
                      padding: EdgeInsets.only(top: 50.0),
                      child: Center(
                        child: Text(
                          'Nothing to show here!\nPress the + button to add a new note.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ))
                  : CupertinoListSection.insetGrouped(
                      children: List.generate(
                          value.getAllNotes().length,
                          (index) => CupertinoListTile(
                                title: Text(value.getAllNotes()[index].text),
                                onTap: () {
                                  goToNotePage(
                                      value.getAllNotes()[index], false);
                                },
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () =>
                                      deleteNote(value.getAllNotes()[index]),
                                ),
                              ))),
            ],
          )),
    );
  }
}
