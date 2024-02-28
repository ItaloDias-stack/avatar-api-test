import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
//import 'package:flutter_3d_controller/flutter_3d_controller.dart';
import 'package:flutter_leap_v2/shared/utils/app_state.dart';
import 'package:flutter_leap_v2/shared/utils/helpers/image_picker_helper.dart';
import 'package:flutter_leap_v2/shared/utils/misc.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:get_it/get_it.dart';

import 'package:flutter_leap_v2/app/modules/home_module/presenter/stores/example_store.dart';
import 'package:loomi_ui_flutter/loomi_ui.dart';

import '../../../../../shared/utils/custom_colors.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/homeScreen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final pageViewController = PageController();
  //final controller = Flutter3DController();
  final ExampleStore _exampleStore = GetIt.I.get<ExampleStore>();
  String? chosenAnimation;
  @override
  void didChangeDependencies() {
    log(_exampleStore.appState.toString());
    super.didChangeDependencies();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _exampleStore.auth();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () async {
              if (await askCameraPermission()) {
                pushToCameraScreen(
                  context: context,
                  onFileAdded: (file) async {
                    await _exampleStore.createAvatar(
                      image: File(file),
                    );
                    setState(() {});
                  },
                );
              }
            },
            child: const Icon(Icons.camera),
          )
        ],
      ),
      backgroundColor: CustomColors.grey20,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Observer(
          builder: (context) {
            return _exampleStore.appState == AppState.loading
                ? const Center(
                    child: DefaultLoader(
                      color: Colors.red,
                    ),
                  )
                : _exampleStore.avatar3d.id.isNotEmpty
                    ? Image.network(
                        "https://models.readyplayer.me/${_exampleStore.avatar3d.id}.png?expression=rage&pose=relaxed&camera=portrait",
                      )
                    : const Center(
                        child: Text(
                          "Não foi criado nenhum avatar",
                        ),
                      );
          },
        ),
      ),
    );
  }
}
