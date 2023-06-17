import 'package:cat_brochure_app/core/constants/app_colors.dart';
import 'package:cat_brochure_app/core/constants/breed_filters.dart';
import 'package:cat_brochure_app/core/utils/screen_size_util.dart';
import 'package:cat_brochure_app/core/utils/widgets/big_text.dart';
import 'package:cat_brochure_app/features/cat_list/presentation/bloc/cat_list_bloc.dart';
import 'package:cat_brochure_app/features/cat_list/presentation/widgets/cat_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  final String currentBreed;
  const HomePage({super.key, required this.currentBreed});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String selectedBreed;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    selectedBreed = widget.currentBreed;
  }

  @override
  Widget build(BuildContext context) {
    ScreenSizeUtil.context = context;

    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 40),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const BigText(text: 'Breed'),
                    SizedBox(width: 5),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: Text(
                        ".",
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(getKeyFromValue(selectedBreed)),
                  ],
                ),
                PopupMenuButton(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    onSelected: (breed) {
                      setState(() => selectedBreed = breed);
                      BlocProvider.of<CatListBloc>(context)
                          .add(FetchAnotherBreed(breed: breed));
                    },
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 5),
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.accentColor,
                        ),
                        child: const Icon(
                          Icons.filter_alt_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                    itemBuilder: (context) {
                      return breedFilters.entries
                          .map(
                            (breedEntry) => PopupMenuItem<String>(
                              value: breedEntry.value,
                              child: Text(breedEntry.key),
                            ),
                          )
                          .toList();
                    }),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<CatListBloc, CatListState>(
              builder: (context, state) {
                return state.map(
                  initial: (_) => _buildProgressIndicator(),
                  loadInProgress: (_) => _buildProgressIndicator(),
                  catsFetched: (state) {
                    return NotificationListener<ScrollNotification>(
                      onNotification: (not) =>
                          _handleScrollNotification(not, selectedBreed),
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        controller: _scrollController,
                        itemCount: state.cats.length + 1,
                        itemBuilder: (context, index) {
                          if (index >= state.cats.length) {
                            if (state.hasReachedTheEnd) {
                              return const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "No More Cats Available",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return _buildProgressIndicator();
                            }
                          } else {
                            return CatCard(cat: state.cats[index]);
                          }
                        },
                      ),
                    );
                  },
                  // An Error Screen Can be shown here.
                  loadFailure: (state) => Center(
                    child: Text(state.message),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  bool _handleScrollNotification(
      ScrollNotification notification, String breed) {
    if (notification is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0) {
      BlocProvider.of<CatListBloc>(context).add(FetchNextPage(breed: breed));
    }
    return false;
  }

  Widget _buildProgressIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
