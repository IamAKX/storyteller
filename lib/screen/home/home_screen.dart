import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_teller/model/story_model.dart';
import 'package:story_teller/model/story_model_list.dart';
import 'package:story_teller/util/api.dart';
import 'package:story_teller/util/color.dart';
import 'package:story_teller/util/theme.dart';
import 'package:story_teller/widget/custom_text.dart';
import 'package:story_teller/widget/gaps.dart';

import '../../service/api_provider.dart';
import '../../service/auth_provider.dart';
import '../../service/snakbar_service.dart';
import '../../static_data/image_link.dart';
import '../../static_data/static_widget.dart';
import '../chat_screen/chat_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AuthProvider _auth;
  late ApiProvider _api;
  StoryModelList? topStories;
  StoryModelList? allStories;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => reloadScreen(),
    );
  }

  reloadScreen() async {
    await _api.getRequest('${Api.getStoryByTag}trend').then((value) {
      setState(() {
        topStories = StoryModelList.fromMap(value);
      });
    });
    await _api.getRequest(Api.getAllStory).then((value) {
      setState(() {
        allStories = StoryModelList.fromMap(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SnackBarService.instance.buildContext = context;
    _auth = Provider.of<AuthProvider>(context);
    _api = Provider.of<ApiProvider>(context);

    return Scaffold(
      body: _api.status == ApiStatus.loading
          ? const Center(
              child: CircularProgressIndicator(
                color: themeGrey,
              ),
            )
          : getBody(context),
    );
  }

  getBody(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: defaultPadding,
            top: defaultPadding,
          ),
          child: getSubTitle('Top Stories'),
        ),
        topStoriesCarousel(),
        Padding(
          padding: const EdgeInsets.only(
              left: defaultPadding, top: defaultPadding, right: defaultPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getSubTitle('Chat Story'),
              TextButton(
                onPressed: () {},
                child: const Text('Show All'),
              )
            ],
          ),
        ),
        for (StoryModel story in allStories?.data ?? []) ...{
          storyListTile(context, story),
          verticalGap(defaultPadding / 2),
        }
      ],
    );
  }

  Widget topStoriesCarousel() {
    if (topStories?.data?.isEmpty ?? true) {
      return Container();
    }
    return CarouselSlider(
      options: CarouselOptions(height: 180.0),
      items: topStories?.data?.map((story) {
        return Builder(
          builder: (BuildContext context) {
            return InkWell(
              onTap: () => Navigator.of(context)
                  .pushNamed(ChatScreen.routePath, arguments: story),
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: story.image ?? '',
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        height: double.maxFinite,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Container(
                          width: MediaQuery.of(context).size.width,
                          height: double.maxFinite,
                          alignment: Alignment.center,
                          child: Text(
                            'Failed to load image',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: themeGrey),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                            defaultPadding * 2,
                            defaultPadding,
                            defaultPadding * 2,
                            defaultPadding * 2),
                        child: Text(
                          story.name ?? '',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                color: white,
                              ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            getCardLabel(context, story.author?.name ?? '',
                                Icons.person_outline),
                            getCardLabel(context, story.category?.name ?? '',
                                Icons.category_outlined),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Expanded getCardLabel(BuildContext context, String label, IconData iconData) {
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            iconData,
            size: 15,
            color: textColor,
          ),
          horizontalGap(5),
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
    );
  }
}
