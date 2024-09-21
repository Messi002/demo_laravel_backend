import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomLoader extends StatelessWidget {
  final bool isFullScreen;
  final bool isPagination;
  final double strokeWidth;
  final Color loaderColor;

  const CustomLoader({
    super.key,
    this.isFullScreen = false,
    this.isPagination = false,
    this.strokeWidth = 1,
    this.loaderColor = Colors.red,
  });

  @override
  Widget build(BuildContext context) {
    return isFullScreen
        ? SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: const Center(
                child: SpinKitThreeBounce(
              color: Colors.red,
              size: 20.0,
            )),
          )
        : isPagination
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: LoadingIndicator(
                    strokeWidth: strokeWidth,
                  ),
                ),
              )
            : SizedBox(
                height: 300,
                child: Center(
                  child: SpinKitThreeBounce(
                    color: loaderColor,
                    size: 20.0,
                  ),
                ),
              );
  }
}

class LoadingIndicator extends StatelessWidget {
  final double strokeWidth;
  const LoadingIndicator({super.key, this.strokeWidth = 1});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      padding: const EdgeInsets.all(10),
      // ignore: prefer_const_constructors
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: const CircularProgressIndicator(
        color: Colors.red,
        strokeWidth: 3,
      ),
    );
  }
}
