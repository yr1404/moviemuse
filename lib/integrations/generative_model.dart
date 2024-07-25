class GenerativeModelRequest {
  final String model;
  final String apiKey;
  final Map<String, dynamic> generationConfig;
  final List<ChatContent> chatHistory;

  GenerativeModelRequest({
    required this.model,
    required this.apiKey,
    required this.generationConfig,
    required this.chatHistory,
  });

  Map<String, dynamic> toJson() => {
    'model': model,
    'apiKey': apiKey,
    'generationConfig': generationConfig,
    'chatHistory': chatHistory.map((content) => content.toJson()).toList(),
  };
}

class ChatContent {
  final String role;
  final List<ChatPart> parts;

  ChatContent({required this.role, required this.parts});

  Map<String, dynamic> toJson() => {
    'role': role,
    'parts': parts.map((part) => part.toJson()).toList(),
  };
}

class ChatPart {
  final String text;

  ChatPart({required this.text});

  Map<String, dynamic> toJson() => {
    'text': text,
  };
}

class GenerativeModelResponse {
  final String text;

  GenerativeModelResponse({required this.text});

  factory GenerativeModelResponse.fromJson(Map<String, dynamic> json) {
    return GenerativeModelResponse(text: json['text']);
  }
}
