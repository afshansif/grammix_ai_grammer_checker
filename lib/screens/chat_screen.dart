import 'package:flutter/material.dart';
import '../models/chat_message.dart';
import '../services/file_service.dart';
import '../services/grammar_service.dart';
import '../theme/app_theme.dart';
import '../widgets/chat_input.dart';
import '../widgets/message_bubble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messages = <ChatMessage>[];
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  final _service = GrammarService();
  final _fileService = FileService();

  bool _isLoading = false;

  Future<void> _sendMessage() async {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    final historyBeforeSend = List<ChatMessage>.from(_messages);

    setState(() {
      _messages.add(ChatMessage(text: text, sender: MessageSender.user));
      _isLoading = true;
    });
    _textController.clear();
    _scrollToBottom();

    try {
      final reply = await _service.checkGrammar(historyBeforeSend, text);
      setState(() {
        _messages.add(ChatMessage(text: reply, sender: MessageSender.assistant));
      });
    } on GrammarServiceException catch (e) {
      setState(() {
        _messages.add(ChatMessage(
          text: e.message,
          sender: MessageSender.assistant,
          isError: true,
        ));
      });
    } finally {
      setState(() => _isLoading = false);
      _scrollToBottom();
    }
  }

  Future<void> _attachFile() async {
    try {
      final content = await _fileService.pickTextFile();
      if (content == null) return;
      setState(() => _textController.text = content);
    } catch (_) {
      setState(() {
        _messages.add(const ChatMessage(
          text: 'Could not read that file. Please try a plain .txt file.',
          sender: MessageSender.assistant,
          isError: true,
        ));
      });
      _scrollToBottom();
    }
  }

  void _saveMessage(ChatMessage message) {
    final corrected = _fileService.extractCorrectedText(message.text);
    _fileService.saveTextFile(corrected, filename: 'corrected.txt');
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: _messages.isEmpty
                    ? Center(
                        child: Text(
                          'Send a sentence, or attach a .txt file to check its grammar.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      )
                    : ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        itemCount: _messages.length,
                        itemBuilder: (context, index) {
                          final message = _messages[index];
                          final isAssistantReply =
                              message.sender == MessageSender.assistant &&
                                  !message.isError;
                          return MessageBubble(
                            message: message,
                            onSave:
                                isAssistantReply ? () => _saveMessage(message) : null,
                          );
                        },
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
              child: ChatInput(
                controller: _textController,
                isLoading: _isLoading,
                onSend: _sendMessage,
                onAttach: _attachFile,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.accent.withOpacity(0.1)),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppColors.accent,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          const Text(
            'Grammix',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 19,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}
