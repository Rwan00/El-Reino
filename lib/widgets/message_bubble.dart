import 'package:el_reino/constants/consts.dart';
import 'package:el_reino/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble.first({
    super.key,
    required this.userImage,
    required this.username,
    required this.message,
    required this.isMe,
    this.lat,
    this.lng,
    required this.time,
    this.file,
  }) : isFirstInSequence = true;

  const MessageBubble.next({
    super.key,
    required this.message,
    required this.isMe,
    this.lat,
    this.lng,
    required this.time,
    this.file,
  })  : isFirstInSequence = false,
        userImage = null,
        username = null;

  final bool isFirstInSequence;

  final String? userImage;

  final String? username;
  final String? message;

  final bool isMe;
  final double? lat;
  final double? lng;

  final String? file;
  final String time;

  @override
  Widget build(BuildContext context) {
    DateTime apiDateTime = DateTime.parse(time);

    String formattedDateTime =
        DateFormat.MMMMEEEEd().addPattern("'at' HH:mm").format(apiDateTime);
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                if (isFirstInSequence) const SizedBox(height: 18),
                Container(
                  decoration: BoxDecoration(
                    color: isMe ? primaryBlue : Colors.grey[300],
                    borderRadius: BorderRadius.only(
                      topLeft: !isMe && isFirstInSequence
                          ? Radius.zero
                          : const Radius.circular(8),
                      topRight: isMe && isFirstInSequence
                          ? Radius.zero
                          : const Radius.circular(8),
                      bottomLeft: const Radius.circular(8),
                      bottomRight: const Radius.circular(8),
                    ),
                  ),
                  constraints: const BoxConstraints(maxWidth: 200),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 14,
                  ),
                  margin: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 12,
                  ),
                  child: lat != null && lng != null
                      ? GestureDetector(
                          onTap: () {
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) => MapScreen(
                            //       location: PlaceLocation(
                            //           longitude: lng,
                            //           latitude: lat,
                            //           address: ''),
                            //       isSelected: false,
                            //     ),
                            //   ),
                            // );
                          },
                          child: Text(
                            "Tap To View Location",
                            style: titleStyle.copyWith(
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        )
                      : message == null
                          ? InteractiveViewer(
                              minScale: 0.5,
                              maxScale: 4,
                              child: Container(
                                height: 260,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      "https://wdw888lb-7075.uks1.devtunnels.ms/chatFiles/$file",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            )
                          : Text(
                              message!,
                              style: isMe
                                  ? titleStyle.copyWith(color: Colors.white)
                                  : titleStyle,
                              softWrap: true,
                            ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 13,
                    right: 13,
                  ),
                  child: Text(
                    formattedDateTime,
                    style: subTitle,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
