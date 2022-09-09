import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/now_playing/presentation/pages/now_playing_page.dart';
import 'package:movie_app/popular/presentation/pages/popular_page.dart';
import 'package:movie_app/upcoming/presentation/pages/upcoming_page.dart';

import '../bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;
  late PageController pageController;
  List<Widget> pages = [
    const NowPlayingPage(),
    const UpcomingPage(),
    const PopularPage(),
    // const GalleryPage(),
    // const CheckPage(),
    // const ContactsPage(),
  ];

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: 0,
    );
  }

  void onButtonPressed(int index) {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 800), curve: Curves.decelerate);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(HomeChangeEvent(0)),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is ChangeIndexState) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Fluttery Movies'),
                centerTitle: true,
                actions: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
                ],
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(40),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                          child: Container(
                        height: 35,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        margin: const EdgeInsets.only(bottom: 6, left: 10),
                        padding: const EdgeInsets.only(left: 10),
                        child: const TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none),
                        ),
                      )),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 35,
                          ))
                    ],
                  ),
                ),
              ),
              body: PageView(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                allowImplicitScrolling: true,
                children: pages,
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: state.index,
                onTap: (index) {
                  context.read<HomeBloc>().add(HomeChangeEvent(index));
                  onButtonPressed(index);
                },
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.event_seat), label: "Now Playing"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.event), label: "Upcoming"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite), label: "Popular"),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
