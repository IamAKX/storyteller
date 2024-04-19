import 'package:flutter/material.dart';
import 'package:story_teller/screen/bookmark/bookmark_screen.dart';
import 'package:story_teller/screen/home/home_screen.dart';
import 'package:story_teller/screen/search/search_screen.dart';
import 'package:story_teller/screen/settings/settings_screen.dart';
import 'package:story_teller/util/color.dart';

class HomeContainer extends StatefulWidget {
  const HomeContainer({super.key});
  static const String routePath = '/homeContainer';

  @override
  State<HomeContainer> createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  final List<Tab> tabList = [
    const Tab(
      icon: Icon(
        Icons.home_outlined,
        color: themeGrey,
      ),
    ),
    const Tab(
      icon: Icon(
        Icons.bookmark_outline,
        color: themeGrey,
      ),
    ),
    const Tab(
      icon: Icon(
        Icons.search_outlined,
        color: themeGrey,
      ),
    ),
    const Tab(
      icon: Icon(
        Icons.settings_outlined,
        color: themeGrey,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabList.length,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              TabBar(
                tabs: tabList,
                indicatorColor: themeBlue,
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    HomeScreen(), // Content for Tab 1
                    BookmarScreen(), // Content for Tab 2
                    SearchScreen(), // Content for Tab 3
                    SettingsScreen(), // Content for Tab 3
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
