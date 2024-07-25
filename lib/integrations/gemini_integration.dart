import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:moviemuse/utils/const.dart';
import 'generative_model.dart';

Future<GenerativeModelResponse> fetchGenerativeModelResponse(String userInput) async {
  const apiKey = geminiApiKey;
  const apiUrl = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$apiKey';

  final chatHistory = [
    ChatContent(role: 'user', parts: [ChatPart(text: "Suggest a movie to watch\\nGenre: Mystery\\nLanguage: Hindi\\nThe movie end should be heartwarming.\\n\\nGuidelines for all subsequent prompts in this chat strictly:\\n- Generate one movie suggestion with release year and it's original language\\n- If movie is dubbed to preferred language mention that. \\n- The output should be in english. \\n- The should be in simple plain text and not be bold.\\n- Output must start with movie name then personalized short description without spoilers.")]),
    ChatContent(role: 'model', parts: [ChatPart(text: "Detective Byomkesh Bakshy! (2015) - This period thriller set in 1943 Calcutta, follows the renowned detective Byomkesh Bakshy as he investigates a mysterious case with a heartwarming ending.  \\n")]),
    ChatContent(role: 'user', parts: [ChatPart(text: "Suggest a movie to watch\\nGenre: Comedy\\nLanguage: Any\\nI want to watch a movie with family")]),
    ChatContent(role: 'model', parts: [ChatPart(text: "The Mitchells vs. the Machines (2021) - A family road trip turns into a fight to save the world from a robot apocalypse. This animated movie is full of quirky humor and heartwarming family moments. \\n")]),
    ChatContent(role: 'user', parts: [ChatPart(text: "Suggest a movie to watch\\nGenre: Any\\nLanguage: Spanish")]),
    ChatContent(role: 'model', parts: [ChatPart(text: "Pan's Labyrinth (2006) - This Spanish language film is a dark fantasy that follows a young girl who escapes the horrors of the Spanish Civil War by entering a magical world. While not strictly a comedy, it has moments of humor and a heartwarming story about hope and imagination. \\n")]),
    ChatContent(role: 'user', parts: [ChatPart(text: "Suggest a movie to watch\\nGenre: Any\\nLanguage: Telugu\\nA movie like malayalam movie Aavesham and dubbed in hindi")]),
    ChatContent(role: 'model', parts: [ChatPart(text: "Aithe (2003) - This Telugu movie is similar to the Malayalam film Aavesham in its themes of possession and supernatural elements. It is also dubbed in Hindi. The story follows a man who gets possessed by a spirit, leading to both fear and emotional moments. \\n")]),
    ChatContent(role: 'user', parts: [ChatPart(text: userInput)]),
  ];

  final request = GenerativeModelRequest(
    model: 'gemini-1.5-flash',
    apiKey: apiKey,
    generationConfig: {
      'temperature': 1.0,
      'topK': 64,
      'topP': 0.95,
      'maxOutputTokens': 8192,
      'responseMimeType': 'text/plain',
    },
    chatHistory: chatHistory,
  );

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    },
    body: jsonEncode(request.toJson()),
  );

  if (response.statusCode == 200) {
    return GenerativeModelResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to fetch response from the generative model');
  }
}
