import 'package:el_reino/widgets/post_widget.dart';
import 'package:flutter/material.dart';

import '../widgets/add_post_widget.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        const SliverToBoxAdapter(
          child: AddPostWidget(),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 710,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return const SizedBox(height: 525, child: PostWidget());
              },
              itemCount: 10,
            ),
          ),
        ),
      ],
    );
  }
}
