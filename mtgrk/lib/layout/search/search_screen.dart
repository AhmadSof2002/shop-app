import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mtgrk/cubit/cubit.dart';
import 'package:mtgrk/layout/search/cubit.dart';
import 'package:mtgrk/layout/search/states.dart';
import 'package:mtgrk/shared/components/components.dart';
import 'package:mtgrk/shared/styles/colors.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormField(
                        controller: searchController,
                        type: TextInputType.text,
                        label: 'Search',
                        onSubmit: (String text) {
                          SearchCubit.get(context).search(text);
                        },
                        prefix: Icons.search,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Enter text to search';
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 15,
                    ),
                    if (state is SearchLoadingState) LinearProgressIndicator(),
                    if(state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return buildListProduct(SearchCubit.get(context)
                              .model!
                              .data!
                              .data![index],context,isSearch: true);
                          },
                          separatorBuilder: (context, index) => myDivider(),
                          itemCount: SearchCubit.get(context)
                              .model!
                              .data!
                              .data!
                              .length),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }

}
