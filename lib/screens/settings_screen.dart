import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          SizedBox(
            height: 190,
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                Align(
                  alignment: AlignmentDirectional.topCenter,
                  child: Container(
                    height: 140,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: const DecorationImage(
                        image: NetworkImage(
                          "https://i.pinimg.com/564x/66/fa/bc/66fabc32423171aa0fd850091b65d1e0.jpg",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      "https://i.pinimg.com/564x/97/f0/cb/97f0cb0bd91313be32a74ff14584d0f7.jpg",
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
