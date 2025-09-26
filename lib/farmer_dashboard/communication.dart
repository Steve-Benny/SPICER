// lib/messaging_center_page.dart

import 'package:flutter/material.dart';

// --- Data Models ---

class ChatThread {
  final String partnerName;
  final String partnerType; // 'Buyer', 'Investor', 'Retailer'
  final String lastMessage;
  final DateTime lastActive;
  // REMOVED: final bool hasUnread;
  final Color typeColor;

  ChatThread({
    required this.partnerName,
    required this.partnerType,
    required this.lastMessage,
    required this.lastActive,
    // REMOVED: this.hasUnread = false,
    required this.typeColor,
  });
}

// --- Messaging Center Page Widget ---

class MessagingCenterPage extends StatefulWidget {
  const MessagingCenterPage({super.key});

  @override
  State<MessagingCenterPage> createState() => _MessagingCenterPageState();
}

class _MessagingCenterPageState extends State<MessagingCenterPage> {
  // Mock data for chat threads (hasUnread is removed from the data)
  final List<ChatThread> _threads = [
    ChatThread(
      partnerName: 'Priya Sharma (Retailer)',
      partnerType: 'Retailer',
      lastMessage: 'Ready for the next cardamom batch.',
      lastActive: DateTime.now().subtract(const Duration(minutes: 5)),
      typeColor: Colors.purple,
    ),
    ChatThread(
      partnerName: 'Alex Johnson (Investor)',
      partnerType: 'Investor',
      lastMessage: 'How is the new vanilla crop coming along?',
      lastActive: DateTime.now().subtract(const Duration(hours: 2)),
      typeColor: Colors.blueAccent,
    ),
    ChatThread(
      partnerName: 'Global Exporters Inc.',
      partnerType: 'Buyer',
      lastMessage: 'Confirmed payment for PB002.',
      lastActive: DateTime.now().subtract(const Duration(days: 1)),
      typeColor: Colors.indigo,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messaging Center'),
        backgroundColor: Colors.redAccent,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: _threads.length,
        itemBuilder: (context, index) {
          final thread = _threads[index];
          return _buildThreadTile(context, thread);
        },
      ),
    );
  }

  // Builder for an individual chat thread tile
  Widget _buildThreadTile(BuildContext context, ChatThread thread) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundColor: thread.typeColor,
            child: Text(
              thread.partnerName[0],
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                thread.partnerName,
                // REMOVED: Boldness based on hasUnread
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                _formatTime(thread.lastActive),
                // REMOVED: Color change based on hasUnread
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          subtitle: Text(
            thread.lastMessage,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            // REMOVED: Style change based on hasUnread
            style: TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.grey.shade600,
            ),
          ),
          // REMOVED: Trailing unread indicator widget
          onTap: () {
            // Navigate to the Chat Detail Page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatDetailPage(thread: thread),
              ),
            );
            // NOTE: The mechanism to mark as read is no longer needed here.
          },
        ),
        const Divider(height: 1, indent: 70), // Divider for clean separation
      ],
    );
  }

  // Simple time formatting helper (unchanged)
  String _formatTime(DateTime time) {
    final difference = DateTime.now().difference(time);
    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Now';
    }
  }
}

// --- Chat Detail Page (Mock) (unchanged) ---

class ChatDetailPage extends StatelessWidget {
  final ChatThread thread;
  const ChatDetailPage({super.key, required this.thread});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(thread.partnerName),
        backgroundColor: Colors.redAccent,
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                thread.partnerType,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          // Mock Chat Messages Area
          Expanded( 
            child: ListView(
              reverse: true, // Show most recent messages at the bottom
              padding: const EdgeInsets.all(16.0),
              children: const <Widget>[
                // Placeholder messages
                _MockChatMessage(text: "That's great news!", isMe: false),
                _MockChatMessage(text: "The harvest is scheduled for next week.", isMe: true),
                _MockChatMessage(text: "Please send an update on the pepper delivery.", isMe: false),
                _MockChatMessage(text: "Hello! Thank you for your inquiry.", isMe: true),
              ].reversed.toList(), // Reverse the order to display chronologically
            ),
          ),
          // Input Bar
          _buildMessageInput(),
        ],
      ),
    );
  }

  // Input Bar Widget
  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: SafeArea(
        top: false, // Input bar should respect the bottom notch/gesture area
        child: Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.attach_file, color: Colors.grey),
              onPressed: () {},
            ),
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send, color: Colors.redAccent),
              onPressed: () {
                // TODO: Implement send message logic
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Mock Chat Message Bubble (unchanged)
class _MockChatMessage extends StatelessWidget {
  final String text;
  final bool isMe;

  const _MockChatMessage({required this.text, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isMe ? Colors.redAccent.shade100 : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(15.0).copyWith(
            topRight: isMe ? const Radius.circular(0) : const Radius.circular(15),
            topLeft: isMe ? const Radius.circular(15) : const Radius.circular(0),
          ),
        ),
        child: Text(text, style: TextStyle(color: isMe ? Colors.black87 : Colors.black)),
      ),
    );
  }
}