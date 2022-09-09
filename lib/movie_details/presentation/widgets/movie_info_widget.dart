import 'package:flutter/material.dart';

class MovieInfoWidget extends StatelessWidget {
  const MovieInfoWidget({
    Key? key,
    required this.title,
    required this.voteAverage,
    required this.genres,
  }) : super(key: key);

  final String title;
  final String voteAverage;
  final List genres;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20, left: 10, top: 90),
      width: MediaQuery.of(context).size.width / 2.1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    voteAverage,
                    style: TextStyle(
                        fontSize: 30, color: Theme.of(context).primaryColor),
                  ),
                  const Text(
                    'Reytinglar',
                    style: TextStyle(fontSize: 10),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2.1,
                    padding: const EdgeInsets.only(top: 15),
                    child: Wrap(children: [
                      for (var item in genres)
                        Container(
                          margin: const EdgeInsets.only(right: 5, bottom: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            item.name ?? '',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ),
                    ]),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
