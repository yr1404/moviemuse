import 'package:flutter/material.dart';
import 'package:moviemuse/integrations/generative_model.dart';
import 'package:moviemuse/integrations/gemini_integration.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final TextEditingController _textController = TextEditingController();
  String? _selectedGenre = 'Any';
  String? _selectedLanguage = 'Any';
  String? _submittedDescription;
  String? _submittedGenre;
  String? _submittedLanguage;

  final List<String> _genres = [
    'Action',
    'Comedy',
    'Drama',
    'Fantasy',
    'Horror',
    'Mystery',
    'Romance',
    'Thriller',
    'Western',
    'Any'
  ];

  final List<String> _languages = [
    'Hindi',
    'Malayalam',
    'Tamil',
    'Telugu',
    'English',
    'Spanish',
    'French',
    'German',
    'Chinese',
    'Japanese',
    'Korean',
    'Italian',
    'Any'
  ];

  void _submitForm() {
    setState(() {
      _submittedDescription = _textController.text;
      _submittedGenre = _selectedGenre;
      _submittedLanguage = _selectedLanguage;
    });
    // Handle further actions, like sending the data to a backend or displaying it
    _getSuggestion();
  }

  String _response = '';

  void _getSuggestion() async {
    final userInput = "Suggest a movie to watch\\nGenre: $_submittedGenre\\nLanguage: $_submittedLanguage\\n$_submittedDescription";
    try {
      final response = await fetchGenerativeModelResponse(userInput);
      setState(() {
        _response = response.text;
      });
    } catch (e) {
      setState(() {
        _response = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie Suggestions"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DropdownButtonFormField<String>(
              value: _selectedGenre,
              // hint: Text('Genre'),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedGenre = newValue;
                });
              },
              items: _genres.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: const InputDecoration(
                labelText: 'Genre',
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedLanguage,
              // hint: const Text('Select Language'),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedLanguage = newValue;
                });
              },
              items: _languages.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: const InputDecoration(
                labelText: 'Preferred Language',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                labelText: 'Any other details',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Submit'),
            ),
            const SizedBox(height: 20),
            Text(
              _response,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
