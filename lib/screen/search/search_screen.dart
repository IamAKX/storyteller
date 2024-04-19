import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_teller/model/story_model.dart';
import 'package:story_teller/model/story_model_list.dart';
import 'package:story_teller/static_data/image_link.dart';

import '../../service/api_provider.dart';
import '../../service/auth_provider.dart';
import '../../service/snakbar_service.dart';
import '../../static_data/static_widget.dart';
import '../../util/api.dart';
import '../../util/color.dart';
import '../../util/theme.dart';
import '../../widget/custom_text.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchCtrl = TextEditingController();
  final List<String> items = [
    'Name',
    'Author',
  ];
  String selectedValue = 'Name';

  late AuthProvider _auth;
  late ApiProvider _api;

  StoryModelList? searchResults;

  @override
  void initState() {
    super.initState();
    searchCtrl.addListener(() {
      String keyword = searchCtrl.text;
      if (keyword.isEmpty) {
        setState(() {
          searchResults = null;
        });
      } else if (selectedValue == 'Name') {
        searchStoryByName(keyword);
      } else {
        searchStoryByAuthor(keyword);
      }
    });
  }

  searchStoryByName(String keyword) async {
    await _api.getRequest('${Api.getStoryByName}$keyword').then((value) {
      setState(() {
        searchResults = StoryModelList.fromMap(value);
      });
    });
  }

  searchStoryByAuthor(String keyword) async {
    await _api.getRequest('${Api.getStoryByAuthor}$keyword').then((value) {
      setState(() {
        searchResults = StoryModelList.fromMap(value);
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
                right: defaultPadding,
                bottom: defaultPadding / 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getSubTitle('Search'),
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedValue,
                    dropdownColor: inputFillColor,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          selectedValue = newValue;
                        });
                      }
                    },
                    items: items.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: ClipRRect(
              child: TextField(
                controller: searchCtrl,
                decoration: InputDecoration(
                  hintText: 'Search story',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: themeBlue,
                      width: 1,
                      // style: BorderStyle.none,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults?.data?.length ?? 0,
              itemBuilder: (context, index) => storyListTile(
                context,
                searchResults?.data?.elementAt(index) ?? StoryModel(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
