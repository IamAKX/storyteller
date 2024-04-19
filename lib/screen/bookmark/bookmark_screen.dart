import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_teller/main.dart';
import 'package:story_teller/model/story_model.dart';

import '../../model/story_model_list.dart';
import '../../service/api_provider.dart';
import '../../service/auth_provider.dart';
import '../../service/snakbar_service.dart';
import '../../static_data/image_link.dart';
import '../../static_data/static_widget.dart';
import '../../util/api.dart';
import '../../util/theme.dart';
import '../../widget/custom_text.dart';

class BookmarScreen extends StatefulWidget {
  const BookmarScreen({super.key});

  @override
  State<BookmarScreen> createState() => _BookmarScreenState();
}

class _BookmarScreenState extends State<BookmarScreen> {
  late AuthProvider _auth;
  late ApiProvider _api;
  StoryModelList? allStories;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => reloadScreen(),
    );
  }

  reloadScreen() async {
    await _api.getRequest(Api.getAllStory).then((value) {
      setState(() {
        allStories = StoryModelList.fromMap(value);
        List<int> savedIdList = [];
        prefs.getKeys().forEach((element) {
          if (element.startsWith('story_')) {
            savedIdList.add(int.parse(element.split('_')[1]));
          }
        });
        allStories?.data
            ?.retainWhere((element) => savedIdList.contains(element.id));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SnackBarService.instance.buildContext = context;
    _auth = Provider.of<AuthProvider>(context);
    _api = Provider.of<ApiProvider>(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: defaultPadding,
              top: defaultPadding,
            ),
            child: getSubTitle('Bookmarks'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: allStories?.data?.length ?? 0,
              itemBuilder: (context, index) {
                return storyListTile(
                    context, allStories!.data!.elementAt(index));
              },
            ),
          )
        ],
      ),
    );
  }
}
