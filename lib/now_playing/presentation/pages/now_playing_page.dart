import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../movie_details/presentation/pages/movie_details_page.dart';
import '../manager/now_playing_bloc.dart';

class NowPlayingPage extends StatefulWidget {
  const NowPlayingPage({Key? key}) : super(key: key);

  @override
  State<NowPlayingPage> createState() => _NowPlayingPageState();
}

class _NowPlayingPageState extends State<NowPlayingPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NowPlayingBloc, NowPlayingState>(
      builder: (context, state) {
        if (state is NowPlayingInitial) {
          context.read<NowPlayingBloc>().getNews();
        }
        if (state is NowPlayingLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is NowPlayingNoDataState) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          );
        } else if (state is NowPlayingDataSuccessState) {
          return RefreshIndicator(
            onRefresh: () async => context.read<NowPlayingBloc>().getNews(),
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemCount: state.list.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MovieDetailsPage(
                                  id: state.list[index].id ?? 0,
                                )));
                  },
                  child: Container(
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        CachedNetworkImage(
                          imageUrl:
                              'https://image.tmdb.org/t/p/w500/${state.list[index].posterPath ?? ''}',
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                                  child: CircularProgressIndicator(
                                      value: downloadProgress.progress)),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                        GridTile(
                            child: GridTileBar(
                          title: Text(
                            '${state.list[index].title}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                          backgroundColor: Colors.black45,
                        )),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
        return Container();
      },
    );
  }
}
