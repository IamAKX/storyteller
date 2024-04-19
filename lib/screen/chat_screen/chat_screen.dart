import 'dart:async';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:provider/provider.dart';
import 'package:story_teller/enums/chat_sender.dart';
import 'package:story_teller/enums/message_type.dart';
import 'package:story_teller/main.dart';
import 'package:story_teller/model/story_chat_model.dart';
import 'package:story_teller/model/story_chat_model_list.dart';
import 'package:story_teller/model/story_model.dart';
import 'package:story_teller/util/color.dart';
import 'package:story_teller/util/theme.dart';

import '../../service/api_provider.dart';
import '../../service/auth_provider.dart';
import '../../service/snakbar_service.dart';
import '../../util/api.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.story});
  static const String routePath = '/chatScreen';
  final StoryModel story;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isBookMarked = false;
  late AuthProvider _auth;
  late ApiProvider _api;
  StoryChatModelList? chatList;

  int index = 0;
  List<ChatBubble> messages = [];
  // Timer? timer;
  ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    // timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // _startTimer();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => reloadScreen(),
    );
  }

  reloadScreen() async {
    _api
        .getRequest('${Api.getStoryChatByStoryId}${widget.story.id}')
        .then((value) {
      setState(() {
        chatList = StoryChatModelList.fromMap(value);
        int bookmarkedIndex = prefs.getInt('story_${widget.story.id}') ?? 0;
        log('bookmarked index : $bookmarkedIndex');
        while (bookmarkedIndex >= 0) {
          _addMessage();
          bookmarkedIndex--;
          log('loop bookmarked index : $bookmarkedIndex');
          log('loop current index : $index');
        }
      });
    });
  }

  // void _startTimer() {
  //   timer = Timer.periodic(Duration(seconds: 1), (timer) {
  //     _addMessage();
  //   });
  // }

  _addMessage() {
    if (index < (chatList?.data?.length ?? 0)) {
      setState(() {
        StoryChatModel chatModel = chatList!.data!.elementAt(index);
        messages.add(
          ChatBubble(
            elevation: 5,
            clipper: ChatBubbleClipper5(
              type: chatModel.sender == ChatSender.ME.name
                  ? BubbleType.sendBubble
                  : BubbleType.receiverBubble,
            ),
            alignment: chatModel.sender == ChatSender.ME.name
                ? Alignment.topRight
                : Alignment.topLeft,
            margin: const EdgeInsets.only(top: 10),
            backGroundColor: chatModel.sender == ChatSender.ME.name
                ? themeBlue
                : Colors.white,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              child: Column(
                crossAxisAlignment: chatModel.sender == ChatSender.ME.name
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    chatModel.sender == ChatSender.ME.name
                        ? chatModel.story!.userMe!
                        : chatModel.story!.userOther!,
                    style: TextStyle(
                      color: chatModel.sender == ChatSender.ME.name
                          ? Colors.black
                          : Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  chatModel.messageType == MessageType.TEXT.name
                      ? Text(
                          chatModel.text?.trim() ?? '',
                          style: TextStyle(
                            color: chatModel.sender == ChatSender.ME.name
                                ? Colors.white
                                : background,
                          ),
                          textAlign: chatModel.sender == ChatSender.ME.name
                              ? TextAlign.right
                              : TextAlign.left,
                        )
                      : CachedNetworkImage(
                          imageUrl: '${chatModel.mediaUrl}',
                          fit: BoxFit.fitWidth,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) => const Center(
                            child: Text('Image not loaded'),
                          ),
                        ),
                ],
              ),
            ),
          ),
        );
        index++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SnackBarService.instance.buildContext = context;
    _auth = Provider.of<AuthProvider>(context);
    _api = Provider.of<ApiProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.story.name}',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: white),
            ),
            Text(
              'By ${widget.story.author?.name}',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: themeGrey),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (prefs.containsKey('story_${widget.story.id}')) {
                prefs.remove('story_${widget.story.id}');
              } else {
                prefs.setInt('story_${widget.story.id}', index);
              }
              setState(() {});
            },
            icon: Icon(prefs.containsKey('story_${widget.story.id}')
                ? Icons.bookmark
                : Icons.bookmark_outline),
          )
        ],
      ),
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    if (_api.status == ApiStatus.loading) {
      return const Center(
        child: CircularProgressIndicator(
          color: themeGrey,
        ),
      );
    }
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: scrollController,
            itemCount: messages.length,
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            itemBuilder: (context, i) {
              return messages.elementAt(i);
            },
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            _addMessage();
            scrollController.animateTo(
              scrollController.position.maxScrollExtent + 200,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut,
            );
          },
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(inputFillColor)),
          child: const SizedBox(
            width: double.infinity,
            child: Center(
              child: Text('Next'),
            ),
          ),
        )
      ],
    );
  }
}
