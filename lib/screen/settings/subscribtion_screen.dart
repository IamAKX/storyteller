import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_teller/model/subscription_model_list.dart';
import 'package:story_teller/static_data/static_widget.dart';
import 'package:story_teller/util/color.dart';

import '../../service/api_provider.dart';
import '../../service/auth_provider.dart';
import '../../service/snakbar_service.dart';
import '../../util/api.dart';
import '../../util/theme.dart';
import '../../widget/custom_text.dart';
import '../../widget/gaps.dart';

class SubscribtionScreen extends StatefulWidget {
  const SubscribtionScreen({super.key});
  static const String routePath = '/subscribtionScreen';

  @override
  State<SubscribtionScreen> createState() => _SubscribtionScreenState();
}

class _SubscribtionScreenState extends State<SubscribtionScreen> {
  SubscriptionModelList? subscriptionList;
  late AuthProvider _auth;
  late ApiProvider _api;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => reloadScreen(),
    );
  }

  reloadScreen() async {
    await _api.getRequest(Api.getAllSubscription).then((value) {
      setState(() {
        subscriptionList = SubscriptionModelList.fromMap(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SnackBarService.instance.buildContext = context;
    _auth = Provider.of<AuthProvider>(context);
    _api = Provider.of<ApiProvider>(context);

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: defaultPadding,
            ),
            child: getSubTitle('Subscription'),
          ),
          verticalGap(defaultPadding),
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/member-card.png',
              width: 60,
            ),
          ),
          verticalGap(defaultPadding),
          Align(
            alignment: Alignment.center,
            child: Text('Get your premium access today',
                style: Theme.of(context).textTheme.titleLarge),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              'and enjoy exciting benifits',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: themeGrey),
            ),
          ),
          verticalGap(defaultPadding * 2),
          _api.status == ApiStatus.loading
              ? Container()
              : CarouselSlider(
                  options: CarouselOptions(
                    height: 400.0,
                    enlargeCenterPage: true,
                    viewportFraction: 0.7,
                    aspectRatio: 2.0,
                    initialPage: 2,
                  ),
                  items: subscriptionList?.data?.map((subscription) {
                    return Builder(
                      builder: (BuildContext context) {
                        return buildSubscriptionCard(context, subscription);
                      },
                    );
                  }).toList(),
                ),
          verticalGap(defaultPadding),
          Align(
            alignment: Alignment.center,
            child: Text(
              'By purchasing you agree out sales and payment policy',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: themeGrey),
            ),
          ),
          verticalGap(defaultPadding)
        ],
      ),
    );
  }
}
