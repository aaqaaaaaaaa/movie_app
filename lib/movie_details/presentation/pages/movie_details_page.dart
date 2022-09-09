import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/movie_details/presentation/widgets/arc_banner_widget.dart';

import '../manager/movie_details_bloc.dart';
import '../widgets/movie_info_widget.dart';

class MovieDetailsPage extends StatefulWidget {
  const MovieDetailsPage({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => MovieDetailsBloc(),
        child: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
          builder: (context, state) {
            if (state is MovieDetailsInitial) {
              context
                  .read<MovieDetailsBloc>()
                  .add(GetMovieDetailsDataEvent(id: widget.id));
            }
            if (state is MovieDetailsLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MovieDetailsNoDataState) {
              return Center(
                child: Text(
                  state.message,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 16),
                ),
              );
            } else if (state is MovieDetailsDataSuccessState) {
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  ArcBannerImage(
                      'https://image.tmdb.org/t/p/w500/${state.list.backdropPath ?? ''}'),
                  SingleChildScrollView(
                    padding:
                        const EdgeInsets.only(top: 140, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 140,
                              height: 200,
                              child: Image.network(
                                'https://image.tmdb.org/t/p/w500/${state.list.posterPath ?? ''}',
                              ),
                            ),
                            MovieInfoWidget(
                              title: state.list.originalTitle ?? '',
                              voteAverage:
                                  state.list.voteAverage?.toStringAsFixed(1) ??
                                      '',
                              genres: state.list.genres ?? [],
                            )
                          ],
                        ),
                        const SizedBox(height: 60),
                        OverViewWidget(
                          overView: state.list.overview ?? '',
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1,
                          height: 150,
                          padding: const EdgeInsets.only(right: 20),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.list.productionCompanies?.length,
                            itemBuilder: (context, index) => ProductionCompaniesWidget(
                              logoPath: state.list.productionCompanies?[index].logoPath ?? '',
                              name: state.list.productionCompanies?[index].name ?? '',
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class OverViewWidget extends StatelessWidget {
  const OverViewWidget({
    Key? key,
    required this.overView,
  }) : super(key: key);
  final String overView;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'OverView',
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 1.1,
          child: Text(
            overView,
            style: const TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
        const SizedBox(height: 60),

      ],
    );
  }
}

class ProductionCompaniesWidget extends StatelessWidget {
  const ProductionCompaniesWidget({
    Key? key,
    required this.logoPath,
    required this.name,
  }) : super(key: key);
  final String logoPath;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.1,
      padding: const EdgeInsets.only(right: 20),
      child: Column(
        children: [
          Image.network('https://image.tmdb.org/t/p/w500/$logoPath'),
          Text(
            name,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
