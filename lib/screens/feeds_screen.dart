import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:el_reino/cubits/app_cubit/app_cubit.dart';
import 'package:el_reino/cubits/app_cubit/app_state.dart';
import 'package:el_reino/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/add_post_widget.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getUserData()..getPosts(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return ConditionalBuilder(
            condition: cubit.posts.isNotEmpty && cubit.userData != null ,
            builder: (context) {
              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  const SliverToBoxAdapter(
                    child: AddPostWidget(),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      height: 2,
                      width: double.infinity,
                      color: Colors.grey,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 710,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return PostWidget(
                            post: cubit.posts[index],
                            index: index,
                          );
                        },
                        itemCount: cubit.posts.length,
                      ),
                    ),
                  ),
                ],
              );
            },
            fallback: (context) {
              return Center(
                child: Image.asset(
                  "assets/loading.gif",
                  height: 65,
                  width: 65,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
