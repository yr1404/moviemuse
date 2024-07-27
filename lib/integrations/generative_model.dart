import 'package:google_generative_ai/google_generative_ai.dart';

class GenerativeModelResponse {
  final String text;

  GenerativeModelResponse({required this.text});

  factory GenerativeModelResponse.fromCandidate(Candidate candidate) {
    // Provide a default empty string if candidate.text is null
    return GenerativeModelResponse(text: candidate.text ?? '');
  }
}

