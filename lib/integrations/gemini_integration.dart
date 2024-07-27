import 'package:google_generative_ai/google_generative_ai.dart';
import 'generative_model.dart';
import 'package:moviemuse/utils/const.dart';

Future<GenerativeModelResponse> fetchGenerativeModelResponse(String userInput) async {
  final model = GenerativeModel(
    model: 'gemini-1.5-flash',
    apiKey: geminiApiKey,
    generationConfig: GenerationConfig(maxOutputTokens: 100),
  );

  // Initialize the chat with the provided history
  final chat = model.startChat(history: [
    Content.text(
        "Suggest a movie to watch\nGenre: Mystery\nLanguage: Hindi\nThe movie end should be heartwarming.\n\nGuidelines for all subsequent prompts in this chat strictly:\n- Generate one movie suggestion with release year and its original language\n- If movie is dubbed to preferred language mention that.\n- The output should be in English.\n- The should be in simple plain text and not be bold.\n- Output must start with movie name then personalized short description without spoilers."
    ),
    Content.model([
      TextPart(
          "Detective Byomkesh Bakshy! (2015) - This period thriller set in 1943 Calcutta, follows the renowned detective Byomkesh Bakshy as he investigates a mysterious case with a heartwarming ending."
      )
    ]),
    Content.text(
        "Suggest a movie to watch\nGenre: Comedy\nLanguage: Any\nI want to watch a movie with family"
    ),
    Content.model([
      TextPart(
          "The Mitchells vs. the Machines (2021) - A family road trip turns into a fight to save the world from a robot apocalypse. This animated movie is full of quirky humor and heartwarming family moments."
      )
    ]),
    Content.text(
        "Suggest a movie to watch\nGenre: Any\nLanguage: Spanish"
    ),
    Content.model([
      TextPart(
          "Pan's Labyrinth (2006) - This Spanish language film is a dark fantasy that follows a young girl who escapes the horrors of the Spanish Civil War by entering a magical world. While not strictly a comedy, it has moments of humor and a heartwarming story about hope and imagination."
      )
    ]),
    Content.text(
        "Suggest a movie to watch\nGenre: Any\nLanguage: Telugu\nA movie like malayalam movie Aavesham and dubbed in hindi"
    ),
    Content.model([
      TextPart(
          "Aithe (2003) - This Telugu movie is similar to the Malayalam film Aavesham in its themes of possession and supernatural elements. It is also dubbed in Hindi. The story follows a man who gets possessed by a spirit, leading to both fear and emotional moments."
      )
    ]),
    Content.text(userInput)
  ]);

  // Send a message
  var response = await chat.sendMessage(Content.text(userInput));

  // Extract the first candidate and convert the response to GenerativeModelResponse
  final firstCandidate = response.candidates.first;
  return GenerativeModelResponse.fromCandidate(firstCandidate);
}
