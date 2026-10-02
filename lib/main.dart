import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Заметки',
      home: const NotesPage(),
    );
  }
}

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final TextEditingController controller = TextEditingController();

  List<String> notes = [];

  void saveNote() {
    if (controller.text.isNotEmpty) {
      setState(() {
        notes.add(controller.text);
        controller.clear();
      });
    }
  }

  void deleteNote(int index) {
    setState(() {
      notes.removeAt(index);
    });
  }

  void editNote(int index) {
    controller.text = notes[index];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Редактирование'),
          content: TextField(
            controller: controller,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Отмена'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  notes[index] = controller.text;
                  controller.clear();
                });

                Navigator.pop(context);
              },
              child: const Text('Сохранить'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мои заметки'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Введите заметку',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: saveNote,
              child: const Text('Сохранить'),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(notes[index]),

                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          IconButton(
                            onPressed: () {
                              editNote(index);
                            },
                            icon: const Icon(Icons.edit),
                          ),

                          IconButton(
                            onPressed: () {
                              deleteNote(index);
                            },
                            icon: const Icon(Icons.delete),
                          ),

                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}