import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:story_teller/model/story_model.dart';
import 'package:story_teller/model/subscription_model.dart';
import 'package:story_teller/screen/chat_screen/chat_screen.dart';

import '../util/color.dart';
import '../util/theme.dart';
import '../widget/gaps.dart';

ListTile storyListTile(BuildContext context, StoryModel story) {
  return ListTile(
    onTap: () =>
        Navigator.of(context).pushNamed(ChatScreen.routePath, arguments: story),
    title: Text(
      story.name ?? '',
      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: white),
    ),
    subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          story.tags ?? '',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: themeGrey),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              story.author?.name ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.grey),
            ),
            Text(
              story.category?.name ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ],
    ),
    isThreeLine: true,
    leading: ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: CachedNetworkImage(
        imageUrl: story.image ?? '',
        fit: BoxFit.cover,
        width: 100,
        height: 100,
        placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => Container(
          width: 100,
          height: 100,
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
  );
}

Widget buildSubscriptionCard(
    BuildContext context, SubscriptionModel subscriptionModel) {
  return Column(
    children: [
      Expanded(
        child: Card(
          color: inputFillColor,
          elevation: 5,
          child: Stack(
            children: [
              Column(
                children: [
                  verticalGap(75),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      subscriptionModel.title ?? '',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                    ),
                  ),
                  verticalGap(defaultPadding),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      '₹ ${subscriptionModel.amount}',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: themeBlue,
                                fontWeight: FontWeight.bold,
                                fontSize: 35,
                              ),
                    ),
                  ),
                  verticalGap(defaultPadding),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding),
                      child: Text(
                        subscriptionModel.description ?? '',
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: themeGrey,
                            ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.all(defaultPadding),
                      width: double.infinity,
                      height: 50,
                      color: themeBlue,
                      alignment: Alignment.center,
                      child: Text(
                        'BUY',
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                      ),
                    ),
                  )
                ],
              ),
              Visibility(
                visible: subscriptionModel.otherInfo?.isNotEmpty ?? false,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(4),
                  height: 30,
                  color: themeRed,
                  alignment: Alignment.center,
                  child: Text(
                    subscriptionModel.otherInfo ?? '',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
