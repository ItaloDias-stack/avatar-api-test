import 'package:flutter/material.dart';
import 'package:flutter_leap_v2/app/modules/home_module/presenter/pages/components/assets_select.dart';
import 'package:flutter_leap_v2/app/modules/home_module/presenter/stores/avatar_store.dart';
import 'package:flutter_leap_v2/shared/utils/app_state.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:loomi_ui_flutter/loomi_ui.dart';

class AvatarScreen extends StatefulWidget {
  static const routeName = "/avatarScreen";
  const AvatarScreen({super.key});

  @override
  State<AvatarScreen> createState() => _AvatarScreenState();
}

class _AvatarScreenState extends State<AvatarScreen> {
  final store = GetIt.I.get<AvatarStore>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(builder: (_) {
        return store.appState == AppState.loading
            ? const Center(
                child: DefaultLoader(
                  color: Colors.red,
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.network(
                    "https://models.readyplayer.me/${store.avatar3d.id}.png?camera=portrait&blendShapes[mouthSmile]=0.5&background=102,0,153&uat=${DateTime.now().toIso8601String()}",
                  ),
                  const AssetsSelect(),
                ],
              );
      }),
    );
  }
}
