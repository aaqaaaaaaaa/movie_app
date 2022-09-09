import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/upcoming_bloc.dart';

class UpcomingPage extends StatefulWidget {
  const UpcomingPage({Key? key}) : super(key: key);

  @override
  State<UpcomingPage> createState() => _UpcomingPageState();
}

class _UpcomingPageState extends State<UpcomingPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpcomingBloc, UpcomingState>(
      builder: (context, state) {
        if (state is UpcomingInitial) {
          context.read<UpcomingBloc>().add(GetUpcomingEvent());
        }
        if (state is UpcomingLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UpcomingNoDataState) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          );
        } else if (state is UpcomingDataSuccessState) {
          return RefreshIndicator(
            onRefresh: () async =>
                context.read<UpcomingBloc>().add(GetUpcomingEvent()),
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
                    //       builder: (context) => UpcomingPhotosPage(
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
