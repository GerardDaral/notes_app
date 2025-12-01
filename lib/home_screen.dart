// home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'note_cubit.dart';
import 'note.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final noteCubit = context.read<NoteCubit>();
    final titleController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Note App'),
      ),
      body: Column(
        children: [
          // Input field to add new note
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      hintText: 'Enter note',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    final text = titleController.text.trim();
                    if (text.isNotEmpty) {
                      noteCubit.addNote(text);
                      titleController.clear();
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          ),

          // Notes list
          Expanded(
            child: BlocBuilder<NoteCubit, List<Note>>(
              builder: (context, notes) {
                if (notes.isEmpty) {
                  return const Center(
                    child: Text('No notes yet.'),
                  );
                }

                return ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    final note = notes[index];

                    return ListTile(
                      title: Text(
                        note.title,
                        style: TextStyle(
                          decoration: note.isDone
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      leading: Checkbox(
                        value: note.isDone,
                        onChanged: (_) => noteCubit.toggleNoteStatus(index),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => noteCubit.deleteNote(index),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
