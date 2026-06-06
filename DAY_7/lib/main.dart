import 'package:flutter/material.dart';

void main() {
  runApp(const Day7App());
}

class Day7App extends StatelessWidget {
  const Day7App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DAY 7 Flutter State Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DAY 7: State Examples')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Choose an interactive example',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _ExampleButton(
              label: 'Counter App',
              description: 'Increment and decrement with setState',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CounterScreen()),
                );
              },
            ),
            _ExampleButton(
              label: 'Todo List',
              description: 'Add, delete, toggle and search items',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TodoScreen()),
                );
              },
            ),
            _ExampleButton(
              label: 'Form Example',
              description: 'Form state, validation, and submit handling',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FormScreen()),
                );
              },
            ),
            _ExampleButton(
              label: 'Quiz App',
              description: 'Question flow with score tracking',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const QuizScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ExampleButton extends StatelessWidget {
  final String label;
  final String description;
  final VoidCallback onTap;

  const _ExampleButton({
    required this.label,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(label),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward),
        onTap: onTap,
      ),
    );
  }
}

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int count = 0;

  void _increment() {
    setState(() {
      count += 1;
    });
  }

  void _decrement() {
    setState(() {
      count -= 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Current count', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 12),
            Text(
              count.toString(),
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: _decrement, child: const Text('-')),
                const SizedBox(width: 24),
                ElevatedButton(onPressed: _increment, child: const Text('+')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TodoItem {
  final String title;
  bool isDone;

  TodoItem({required this.title, this.isDone = false});
}

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final List<TodoItem> _items = [];
  String _filter = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _filter = _searchController.text.trim().toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _taskController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _addTask() {
    final text = _taskController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _items.add(TodoItem(title: text));
      _taskController.clear();
    });
  }

  void _toggleDone(int index) {
    setState(() {
      _items[index].isDone = !_items[index].isDone;
    });
  }

  void _removeTask(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  List<TodoItem> get _filteredItems {
    if (_filter.isEmpty) {
      return _items;
    }
    return _items
        .where((item) => item.title.toLowerCase().contains(_filter))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _taskController,
              decoration: InputDecoration(
                labelText: 'New task',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: _addTask,
                  icon: const Icon(Icons.add),
                ),
              ),
              onSubmitted: (_) => _addTask(),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search tasks',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _filteredItems.isEmpty
                  ? const Center(child: Text('No tasks yet. Add a new task.'))
                  : ListView.builder(
                      itemCount: _filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = _filteredItems[index];
                        return Dismissible(
                          key: ValueKey(item.title + index.toString()),
                          direction: DismissDirection.endToStart,
                          onDismissed: (_) {
                            final originalIndex = _items.indexOf(item);
                            if (originalIndex >= 0) {
                              _removeTask(originalIndex);
                            }
                          },
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 16),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          child: ListTile(
                            title: Text(
                              item.title,
                              style: TextStyle(
                                decoration: item.isDone
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                            leading: Checkbox(
                              value: item.isDone,
                              onChanged: (_) {
                                final originalIndex = _items.indexOf(item);
                                if (originalIndex >= 0) {
                                  _toggleDone(originalIndex);
                                }
                              },
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                final originalIndex = _items.indexOf(item);
                                if (originalIndex >= 0) {
                                  _removeTask(originalIndex);
                                }
                              },
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

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    _nameFocus.addListener(() {
      setState(() {});
    });
    _emailFocus.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _submitted = true;
      });
      FocusScope.of(context).unfocus();
    }
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }
    if (value.trim().length < 3) {
      return 'Enter at least 3 characters';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    final email = value.trim();
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(email)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form State Example')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                focusNode: _nameFocus,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: const OutlineInputBorder(),
                  suffixIcon:
                      _nameFocus.hasFocus ? const Icon(Icons.edit) : null,
                ),
                validator: _validateName,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_emailFocus);
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                focusNode: _emailFocus,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: const OutlineInputBorder(),
                  suffixIcon:
                      _emailFocus.hasFocus ? const Icon(Icons.email) : null,
                ),
                validator: _validateEmail,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _submitForm(),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
              const SizedBox(height: 16),
              if (_submitted)
                Card(
                  color: Colors.blue.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Form Submitted',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text('Name: ${_nameController.text}'),
                        Text('Email: ${_emailController.text}'),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuizQuestion {
  final String question;
  final List<String> answers;
  final int correctIndex;

  QuizQuestion({
    required this.question,
    required this.answers,
    required this.correctIndex,
  });
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<QuizQuestion> _questions = [
    QuizQuestion(
      question: 'What method rebuilds a StatefulWidget with updated state?',
      answers: ['build()', 'setState()', 'initState()', 'dispose()'],
      correctIndex: 1,
    ),
    QuizQuestion(
      question: 'Which widget holds mutable state?',
      answers: [
        'StatelessWidget',
        'InheritedWidget',
        'StatefulWidget',
        'FutureBuilder',
      ],
      correctIndex: 2,
    ),
    QuizQuestion(
      question: 'Which method is called first in a State lifecycle?',
      answers: ['dispose()', 'build()', 'initState()', 'didUpdateWidget()'],
      correctIndex: 2,
    ),
  ];
  int _currentIndex = 0;
  int _score = 0;
  bool _completed = false;

  void _answerQuestion(int selectedIndex) {
    if (_completed) return;
    final current = _questions[_currentIndex];
    setState(() {
      if (selectedIndex == current.correctIndex) {
        _score += 1;
      }
      if (_currentIndex < _questions.length - 1) {
        _currentIndex += 1;
      } else {
        _completed = true;
      }
    });
  }

  void _restartQuiz() {
    setState(() {
      _currentIndex = 0;
      _score = 0;
      _completed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz App')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _completed
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Quiz complete!',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Your score: $_score / ${_questions.length}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _restartQuiz,
                    child: const Text('Restart Quiz'),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Question ${_currentIndex + 1} of ${_questions.length}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _questions[_currentIndex].question,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ...List.generate(_questions[_currentIndex].answers.length, (
                    index,
                  ) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: ElevatedButton(
                        onPressed: () => _answerQuestion(index),
                        child: Text(_questions[_currentIndex].answers[index]),
                      ),
                    );
                  }),
                  const Spacer(),
                  Text('Score: $_score', style: const TextStyle(fontSize: 16)),
                ],
              ),
      ),
    );
  }
}
