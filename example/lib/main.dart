import 'package:chatview/chatview.dart';


import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'music/audioModel.dart';
import 'music/musicService.dart';
import 'package:voice_message_package/voice_message_package.dart';

void main() {
  runApp(const Example());
}

class Example extends StatelessWidget {
  const Example({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat UI Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xffEE5366),
        colorScheme:
            ColorScheme.fromSwatch(accentColor: const Color(0xffEE5366)),
      ),
      home: const ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  bool isDarkTheme = false;
  final sender = ChatUser(id: '1', name: 'Flutter');
  final receiver = ChatUser(id: '2', name: 'Simform');
  final _chatController = ChatController(

    initialMessageList: [
      Message(
        id: '1',
        message: "Hi",
        createdAt: DateTime.now(),
        sendBy: 'Adil',
      ),
      Message(
        id: '2',
        message: "Hello",
        createdAt: DateTime.now(),
        sendBy: 'Adil',
      ),
    ],
    scrollController: ScrollController(),
  );


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllAudio();
  }

  List<Audio> _listAudio = [];

  getAllAudio() async {
    _listAudio = await fetchAudio();
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChatView(
        sender: sender,
        receiver: receiver,
        loadingWidget: CircularProgressIndicator(),
        chatController: _chatController,
        onSendTap: _onSendTap,
        typeIndicatorConfig: TypeIndicatorConfiguration(
          
        ),


        appBar: ChatViewAppBar(
          profilePicture: 'https://source.unsplash.com/random',
          title: receiver.name,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            letterSpacing: 0.25,
          ),
          userStatus: "online",
          userStatusTextStyle: const TextStyle(color: Colors.grey),
          actions: [
            IconButton(
              onPressed: _onThemeIconTap,
              icon: Icon(
                 Icons.audiotrack_rounded
              ),
            ),
          ],
        ),
        chatBackgroundConfig: ChatBackgroundConfiguration(

          defaultGroupSeparatorConfig: DefaultGroupSeparatorConfiguration(
            textStyle: TextStyle(

              fontSize: 17,
            ),
          ),

        ),
        sendMessageConfig: SendMessageConfiguration(

            textFieldBackgroundColor: Colors.grey,
            textStyle: TextStyle(
              color: Colors.black,
            )

        ),
        chatBubbleConfig: ChatBubbleConfiguration(

          outgoingChatBubbleConfig: ChatBubble(

            linkPreviewConfig: LinkPreviewConfiguration(




            ),

          ),
          inComingChatBubbleConfig: ChatBubble(

            linkPreviewConfig: LinkPreviewConfiguration(
              linkStyle: TextStyle(

                decoration: TextDecoration.underline,
              ),



            ),


          ),
        ),
        replyPopupConfig: ReplyPopupConfiguration(



        ),
        reactionPopupConfig: ReactionPopupConfiguration(
          shadow: BoxShadow(
            color: isDarkTheme ? Colors.black54 : Colors.grey.shade400,
            blurRadius: 20,
          ),

          onEmojiTap: _chatController.setReaction,
        ),
        messageConfig: MessageConfiguration(
          
          messageReactionConfig: MessageReactionConfiguration(

          ),
          imageMessageConfig: ImageMessageConfiguration(
            shareIconConfig: ShareIconConfiguration(


            ),
          ),
        ),
        profileCircleConfig:
            ProfileCircleConfiguration(
            profileImageUrl: 'https://source.unsplash.com/random'),
        repliedMessageConfig: RepliedMessageConfiguration(
backgroundColor: Colors.blue,
          verticalBarColor: Colors.black,

          textStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.25,
          ),

        ),
        swipeToReplyConfig: SwipeToReplyConfiguration(

        ),
      ),
    );
  }

  void _onSendTap(String message, ReplyMessage replyMessage) {
    final id = int.parse('1') + 1;
    _chatController.addMessage(
      Message(
        id: id.toString(),
        messageType: MessageType.audio,
        createdAt: DateTime.now(),
        message: message,
        sendBy: sender.id,
        replyMessage: replyMessage,
      ),
    );
  }

  void _onThemeIconTap() {

    showCupertinoModalBottomSheet(
        context: context,
        builder: (context) => Scaffold(
            appBar: AppBar(
              leading: Container(),
              backgroundColor: Colors.transparent,
              elevation: 1,
              title: Text('Audio'),
            ),
            body: ListView.separated(
              itemCount: _listAudio.length,
              itemBuilder: (context, i) {
                return ListTile(
                  trailing: IconButton(
                      onPressed: () {
                        final id = int.parse('1') + 1;
                        _chatController.addMessage(
                          Message(
                            messageType: MessageType.audio,
                            id: id.toString(),
                            createdAt: DateTime.now(),
                            message: _listAudio[i].file1File!,
                            sendBy: sender.id,
                            replyMessage: null,
                          ),
                        );

                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.send)),
                  title: Column(
                    children: [
                      VoiceMessage(
                        contactBgColor: Colors.black,

                        audioSrc: _listAudio[i].file1File!,
                        played: false, // To show played badge or not.
                        me: true, // Set message side.
                        onPlay: () {}, // Do something when voice played.
                      ),
                      Text(_listAudio[i].nameText!)
                    ],
                  ),
                );
              },
              separatorBuilder: (context, i) {
                return Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey,
                );
              },
            )));
  }
}
