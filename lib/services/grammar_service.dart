import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/chat_message.dart';

class GrammarServiceException implements Exception {
  final String message;
  GrammarServiceException(this.message);
}

class GrammarService {
  static String get _apiKey => dotenv.env['GEMINI_API_KEY'] ?? '';
  static const _model = 'gemini-3.6-flash';
  static const _endpoint =
      'https://generativelanguage.googleapis.com/v1beta/openai/chat/completions';

  static const _systemPrompt = '''
You are a grammar-checking assistant. You only help with grammar, spelling, punctuation correction, sentence rephrasing, and alternative wordings.

For every grammar-related message, correct the grammar, spelling, and punctuation, then briefly list the changes you made as bullet points. If the user asks for alternative phrasings or different ways to say something, include those as well.

Respond in this format:
Corrected:
<corrected text>

Changes:
<bullet list>

If the user sends a message that is not about grammar, spelling, punctuation, or wording (general knowledge questions, or anything unrelated to language), politely explain that you only handle grammar-related requests, and ask them to share text they'd like checked instead. Do not answer the unrelated question.
''';

  Future<String> checkGrammar(
    List<ChatMessage> history,
    String userMessage,
  ) async {
    if (_apiKey.isEmpty) {
      throw GrammarServiceException(
        'The app is missing its API key. Restart it with your Gemini API key set.',
      );
    }

    final messages = [
      {'role': 'system', 'content': _systemPrompt},
      for (final m in history)
        {
          'role': m.sender == MessageSender.user ? 'user' : 'assistant',
          'content': m.text,
        },
      {'role': 'user', 'content': userMessage},
    ];

    http.Response response;
    try {
      response = await http
          .post(
            Uri.parse(_endpoint),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $_apiKey',
            },
            body: jsonEncode({'model': _model, 'messages': messages}),
          )
          .timeout(const Duration(seconds: 30));
    } catch (_) {
      throw GrammarServiceException(
        'Could not reach the server. Check your connection and try again.',
      );
    }

    if (response.statusCode == 401 || response.statusCode == 403) {
      throw GrammarServiceException(
        'The API key was rejected. Check your key and try again.',
      );
    }
    if (response.statusCode == 429) {
      throw GrammarServiceException(
        'Rate limit or quota exceeded. Please wait a moment and try again.',
      );
    }
    if (response.statusCode != 200) {
      throw GrammarServiceException(
        'Something went wrong on the server side. Please try again.',
      );
    }

    try {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final content = data['choices'][0]['message']['content'] as String;
      return content.trim();
    } catch (_) {
      throw GrammarServiceException(
        'Received an unexpected response. Please try again.',
      );
    }
  }
}
