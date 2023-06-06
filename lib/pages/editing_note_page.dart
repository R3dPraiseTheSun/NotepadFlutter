import 'package:apad/models/note_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';


// ignore: must_be_immutable
class EditingNotePage extends StatefulWidget {
  Note note;
  bool isNew;
  EditingNotePage({
    super.key,
    required this.note,
    required this.isNew
    });

  @override
  State<EditingNotePage> createState() => _EditingNotePageState();
}

class _EditingNotePageState extends State<EditingNotePage> {
  QuillController _controller = QuillController.basic();
  
  @override
  void initState() {
    super.initState();
    loadExistingNote();
  }

  void loadExistingNote() {
    final doc = Document()..insert(0, widget.note.text);
    setState(() {
      _controller = QuillController(
        document: doc, selection: const TextSelection.collapsed(offset: 0));
    });
  }

  //add new note
  void addNewNote() {
    int id = Provider.of<NoteData>(context, listen: false).getAllNotes().length;

    String text = _controller.document.toPlainText();
    Provider.of<NoteData>(context, listen: false).addNewNote(
      Note(id: id, text: text)
    );
  }

  void updateNote() {
    String text = _controller.document.toPlainText();
    Provider.of<NoteData>(context, listen: false).updateNote(widget.note, text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if(widget.isNew && !_controller.document.isEmpty()){
              addNewNote();
            }
            else {
              updateNote();
            }

            Navigator.pop(context);
          },
          color: Colors.amber,
        ),
      ),
      body: Column(
        children: [
          QuillToolbar.basic(
            controller: _controller,
          ),

          Expanded(
            child: QuillEditor.basic(controller: _controller, readOnly: false),
            )
        ],
      ),
    );
  }
}