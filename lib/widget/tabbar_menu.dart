import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/service/service.dart';
import 'package:news_app/widget/newsitem.dart';

class TabBarMenu extends StatefulWidget {
  const TabBarMenu({
    Key? key,
    required this.article,
  }) : super(key: key);

  final List<Article> article;

  @override
  State<TabBarMenu> createState() => _TabBarMenuState();
}

class _TabBarMenuState extends State<TabBarMenu>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<Tab> myTab = [
    const Tab(text: 'Business'),
    const Tab(text: 'Entertainment'),
    const Tab(text: 'General'),
    const Tab(text: 'Health'),
    const Tab(text: 'Science'),
    const Tab(text: 'Sports'),
    const Tab(text: 'Technology'),
  ];

  @override
  void initState() {
    _tabController = TabController(
      length: myTab.length,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var news = News();
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          TabBar(
            tabs: myTab,
            labelColor: Colors.deepOrangeAccent,
            unselectedLabelColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.tab,
            controller: _tabController,
            indicator: const BubbleTabIndicator(
              indicatorHeight: 30,
              indicatorColor: Colors.black,
              tabBarIndicatorSize: TabBarIndicatorSize.tab,
            ),
            isScrollable: true,
          ),
          const SizedBox(height: 10.0),
          Expanded(
              child: TabBarView(
                  controller: _tabController,
                  children: myTab.map((Tab tab) {
                    return FutureBuilder(
                      future: news.getNewsByCategory(tab.text.toString()),
                      builder: (context, snapshot) => snapshot.data != null
                          ? _listNewsCategory(snapshot.data as List<Article>)
                          : const Center(child: CircularProgressIndicator()),
                    );
                  }).toList())),
        ],
      ),
    );
  }

  Widget _listNewsCategory(List<Article> article) {
    return Container(
      height: MediaQuery.of(context).size.height,
      margin: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 10.0,
      ),
      child: ListView.builder(
        itemBuilder: (context, index) => NewsItem(article: article[index]),
        itemCount: article.length,
      ),
    );
  }
}
