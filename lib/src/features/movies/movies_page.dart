import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:outsera_challenge/src/config/injection/injection.dart';
import 'package:outsera_challenge/src/features/movies/widgets/widgets.dart';
import 'package:outsera_challenge/src/shared/shared.dart';

import 'cubit/cubit.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => MoviesPageState();
}

class MoviesPageState extends State<MoviesPage> {
  final MoviesCubit _moviesCubit = getIt();
  final _scrollController = ScrollController();
  Filters _filters = const Filters();

  @override
  void initState() {
    _moviesCubit.getMovies();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMovies(paginate: true);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies', style: context.textTheme.titleLarge),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list_outlined, size: 26.sp),
            onPressed: _showFiltersDialog,
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => _moviesCubit,
        child: BlocBuilder<MoviesCubit, MoviesState>(
          bloc: _moviesCubit,
          buildWhen: (_, state) => state is! MoviesStatePaginating,
          builder: (context, state) {
            if (state is MoviesStateLoading) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (_filters.hasFilters)
                    ActiveFilters(
                      filters: _filters,
                      onClearYear: _onClearYear,
                      onClearWinnersOnly: _onClearWinnersOnly,
                    ),
                  const MoviesListSkeleton(),
                ],
              );
            }

            if (state is MoviesStateLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (_filters.hasFilters)
                    ActiveFilters(
                      filters: _filters,
                      onClearYear: _onClearYear,
                      onClearWinnersOnly: _onClearWinnersOnly,
                    ),
                  if (state.movies.data.isEmpty)
                    Center(
                      child: Text(
                        'No movies found',
                        style: context.textTheme.headlineMedium,
                      ),
                    ),
                  if (state.movies.data.isNotEmpty)
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async => _getMovies(),
                        child: MoviesList(
                          controller: _scrollController,
                          movies: state.movies.data,
                        ),
                      ),
                    ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Future<void> _showFiltersDialog() async {
    final filters = await showDialog(
      context: context,
      builder: (context) {
        return FiltersDialog(filters: _filters);
      },
    );

    if (filters != null) {
      setState(() {
        _filters = filters;
        _moviesCubit.getMovies(
          year: _filters.hasYear ? _filters.year : null,
          winnersOnly: _filters.winnersOnly,
        );
      });
    }
  }

  void _onClearYear() {
    setState(() {
      _filters = _filters.copyWith(year: 0);
      _getMovies();
    });
  }

  void _onClearWinnersOnly() {
    setState(() {
      _filters = _filters.copyWith(winnersOnly: false);
      _getMovies();
    });
  }

  void _getMovies({bool paginate = false}) {
    _moviesCubit.getMovies(
      year: _filters.hasYear ? _filters.year : null,
      winnersOnly: _filters.winnersOnly,
      paginate: paginate,
    );
  }
}
