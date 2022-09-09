import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/popular_bloc.dart';

class PopularPage extends StatefulWidget {
  const PopularPage({Key? key}) : super(key: key);

  @override
  State<PopularPage> createState() => _PopularPageState();
}

class _PopularPageState extends State<PopularPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularBloc, PopularState>(
      builder: (context, state) {
        if (state is PopularInitial) {
          context.read<PopularBloc>().add(GetPopularMovies());
        }
        if (state is PopularLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PopularNoDataState) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          );
        } else if (state is PopularDataSuccessState) {
          return RefreshIndicator(
            onRefresh: () async =>
                context.read<PopularBloc>().add(GetPopularMovies()),
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
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => PopularPhotosPage(
                    //           title: state.list[index].title ?? '',
                    //           albumId: state.list[index].id ?? 1),
                    //     ));
                  },
                  child: Container(
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        FadeInImage(
                            placeholder:
                                const AssetImage('assets/launcher.png'),
                            fit: BoxFit.cover,
                            // width: MediaQuery.of(context).size.width/2,
                            image: NetworkImage(
                                'https://image.tmdb.org/t/p/w500/${state.list[index].posterPath ?? ''}')),
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
