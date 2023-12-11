import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/news_provider.dart';
import '../../provider/scheduling_provider.dart';
import '../../services/article_service.dart';
import '../../share/notification_helper.dart';
import '../../share/style.dart';
import '../widgets/platform_widget.dart';
import 'article_list_page.dart';
import 'settings_page.dart';

class NewsListPage extends StatefulWidget {
  const NewsListPage({Key? key}) : super(key: key);

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  final NotificationHelper _notificationHelper = NotificationHelper();
  int _bottomNavIndex = 0;

  final List<Widget> _listWidget = [
    ChangeNotifierProvider<NewsProvider>(
      create: (_) => NewsProvider(articleService: ArticleService()),
      child: const ArticleListPage(),
    ),
    ChangeNotifierProvider<SchedulingProvider>(
      create: (_) => SchedulingProvider(),
      child: const SettingsPage(),
    ),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.news : Icons.public),
      label: "Headline",
    ),
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.settings : Icons.settings),
      label: "Setting",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject('/article_detail_page');
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: secondaryColor,
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: (selected) {
          setState(() {
            _bottomNavIndex = selected;
          });
        },
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: secondaryColor,
        items: _bottomNavBarItems,
      ),
      tabBuilder: (context, index) {
        return _listWidget[index];
      },
    );
  }
}
