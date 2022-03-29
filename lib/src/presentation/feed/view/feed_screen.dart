import 'dart:developer';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsnews/src/core/theme/palette.dart';
import 'package:newsnews/src/di/injector.dart';
import 'package:newsnews/src/presentation/feed/cubit/news_cubit.dart';
import 'package:newsnews/src/presentation/feed/widgets/page_tab_view.dart';
import 'package:newsnews/src/presentation/feed/widgets/page_tab_view_for_you.dart';
import 'package:newsnews/src/presentation/feed/widgets/page_tab_view_with_category.dart';
import 'package:newsnews/src/widgets/circle_loading.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  late final PageController pageController;
  late final NewsCubit newsCubit;

  final listCategory = [
    "Home",
    "For you",
    "Covid-19",
    "Business",
    "Entertainment",
    "Health",
    "Technology",
    "Science",
    "Sports"
  ];
  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: listCategory.length);
    pageController = PageController();
    newsCubit = s1<NewsCubit>();
  }

  @override
  void dispose() {
    newsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: newsCubit,
      child: DefaultTabController(
        length: 10,
        child: Scaffold(
          appBar: AppBar(
            elevation: 2,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 26.sp,
              fontWeight: FontWeight.w600,
            ),
            title: const Text("NewsNews"),
            backgroundColor: Colors.white,
            bottom: TabBar(
              controller: tabController,
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.tab,
              unselectedLabelColor: Palette.unSelectedColor,
              labelColor: Colors.black87,
              indicatorWeight: 3,
              labelStyle: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
              indicatorColor: Colors.black,
              tabs: listCategory
                  .map(
                    (category) => Tab(child: Text(category.toUpperCase())),
                  )
                  .toList(),
            ),
            actions: [
              IconButton(
                  icon: Badge(
                    badgeColor: Palette.primaryColor,
                    badgeContent: const Text(
                      "3",
                      style: TextStyle(color: Palette.backgroundBoxColor),
                    ),
                    child: const Icon(
                      PhosphorIcons.bellSimple,
                    ),
                    position: const BadgePosition(top: -10, end: -6),
                  ),
                  iconSize: 26,
                  onPressed: () {}),
            ],
          ),
          body: BlocBuilder<NewsCubit, NewsState>(
            builder: (context, state) {
              if (state is NewsLoading) {
                return const CircleLoading();
              } else if (state is NewsError) {
                return Center(
                  child: Text(state.message),
                );
              } else if (state is NewsLoaded) {
                log(state.listArticle.length.toString());
                return TabBarView(controller: tabController, children: [
                  PageTabView(
                      key: ValueKey(listCategory[0]), newsCubit: newsCubit),
                  PageTabViewForYou(newsCubit: newsCubit),
                  for (int index = 2; index < listCategory.length; index++)
                    PageTabViewWithCategory(
                      category: listCategory[index],
                      categoryIndex: index,
                      key: ValueKey(listCategory[index]),
                      newsCubit: newsCubit,
                    ),
                ]);
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
