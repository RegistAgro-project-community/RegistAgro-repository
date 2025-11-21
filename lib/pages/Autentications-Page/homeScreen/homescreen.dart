import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projecto_registagro/shared/logoText/logoText.dart';
import 'package:video_player/video_player.dart';


class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/videos/Muinho.mp4")
      ..initialize().then((_) {
        setState(() {}); // Atualiza a interface após a inicialização
        _controller.play(); // Inicia o vídeo
        _controller.setLooping(true); // Repete em loop
      });
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // _imageBackground(){
  //   return Image(
  //     image: AssetImage("assets/images/sol.jpeg"),
  //     height: double.infinity.h,
  //     width: double.infinity.w,
  //     fit: BoxFit.cover,
  //   );
  // }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          _controller.value.isInitialized ? FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: _controller.value.size.width,
              height: _controller.value.size.height,
              child: VideoPlayer(_controller),
            ),
            ) : Container(color: Colors.transparent,),
         
            Container(
                color: Colors.black.withOpacity(0.7),
                width: double.infinity.w,
                height: double.infinity.h, // ajuste a opacidade
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 80).h,
              child: Center(
                child: LogoText()
              ),
            ),
        ],
      ),
    );
  }
}