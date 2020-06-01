import 'dart:async';

import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
    final int seconds;
    final Widget contentAfterImages;
    final Color backgroundColor;
    final TextStyle styleTextUnderTheLoader;
    final dynamic navigateAfterSeconds;
    final double imageRadius;
    final dynamic onClick;
    final Color loaderColor;
    final Image image;
    final Text loadingText;
    final ImageProvider imageBackground;
    final Gradient gradientBackground;

    Splash({
        this.loaderColor,
        @required this.seconds,
        this.imageRadius,
        this.onClick,
        this.navigateAfterSeconds,
        this.contentAfterImages,
        this.backgroundColor = Colors.white,
        this.styleTextUnderTheLoader = const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.black
        ),
        this.image,
        this.loadingText  = const Text(""),
        this.imageBackground,
      	this.gradientBackground
      });

    SplashState createState() {
        return SplashState();
    }
}

class SplashState extends State<Splash> {
    @override
    void initState() {
        super.initState();
        if (widget.seconds != 0) {
            Timer(
                Duration(seconds: widget.seconds),() {
                    if (widget.navigateAfterSeconds is String) {
                        // It's fairly safe to assume this is using the in-built material
                        // named route component
                        Navigator.of(context).pushReplacementNamed(widget.navigateAfterSeconds);
                    } else if (widget.navigateAfterSeconds is Widget) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => widget.navigateAfterSeconds));
                    } else {
                        throw ArgumentError(
                            'widget.navigateAfterSeconds must either be a String or Widget'
                        );
                    }
                }
            );
        }
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
        body: InkWell(
            onTap: widget.onClick,
            child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                    Container(
                        decoration: BoxDecoration(
                            image: widget.imageBackground == null
                                ? null
                                : DecorationImage(
                                    fit: BoxFit.cover,
                                    image: widget.imageBackground,
                                ),
                            gradient: widget.gradientBackground,
                            color: widget.backgroundColor,
                        ),
                    ),
                    Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                        Expanded(
                        flex: 2,
                        child: Container(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    child: Container(
                                        child: widget.image
                                    ),
                                    radius: widget.imageRadius,
                                ),
                                widget.contentAfterImages
                                ],
                            )),
                        ),
                        Expanded(
                        flex: 1,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[

                            CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(widget.loaderColor),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                            ),
                            widget.loadingText
                            ],
                        ),
                        ),
                    ],
                    ),
                ],
            ),
        ),
        );
    }
}