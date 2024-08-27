import 'dart:async';

import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/chat_message.dart';

class AudioMessage extends StatefulWidget {
  final ChatMessage? message;

  const AudioMessage({super.key, this.message});

  @override
  State<AudioMessage> createState() => _AudioMessageState();
}

class _AudioMessageState extends State<AudioMessage> {
  final Duration _audioDuration = const Duration(minutes: 1, seconds: 34);
  Duration _currentPosition = const Duration(minutes: 0, seconds: 0);

  bool isPlaying = false;

  late Timer timer;

  void play() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      isPlaying = true;
      if (_currentPosition.inSeconds < _audioDuration.inSeconds) {
        setState(() {
          _currentPosition = Duration(seconds: _currentPosition.inSeconds + 1);
        });
      } else {
        setState(() {
          isPlaying = false;
          _currentPosition = const Duration(minutes: 0, seconds: 0);
        });
        timer.cancel();
      }
    });
  }

  void pause() {
    isPlaying = false;
    timer.cancel();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.55,
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding * 0.75,
        vertical: kDefaultPadding / 2.5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: kPrimaryColor.withOpacity(widget.message!.isSender ? 1 : 0.1),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              if (isPlaying) {
                pause();
                return;
              }
              play();
            },
            icon: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow,
              color: widget.message!.isSender ? Colors.white : kPrimaryColor,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
              child: SliderTheme(
                data: SliderThemeData(
                  trackHeight: 2,
                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                  overlayShape: const RoundSliderOverlayShape(overlayRadius: 2),
                  inactiveTrackColor: kPrimaryColor.withOpacity(0.24),
                  activeTrackColor: kPrimaryColor,
                  trackShape: const RoundedRectSliderTrackShape(),
                ),
                child: Slider(
                  value: _currentPosition.inSeconds.toDouble(),
                  min: 0,
                  thumbColor: kPrimaryColor,
                  max: _audioDuration.inSeconds.toDouble(),
                  onChanged: (_) {},
                ),
              ),
            ),
          ),
          Text(
            "${_currentPosition.inMinutes.padNumber}.${_currentPosition.inSeconds.padNumber}",
            style: TextStyle(fontSize: 12, color: widget.message!.isSender ? Colors.white : null),
          ),
        ],
      ),
    );
  }
}

extension PadX on int {
  String get padNumber {
    if (this < 10) {
      return "0$this";
    }
    return "$this";
  }
}
