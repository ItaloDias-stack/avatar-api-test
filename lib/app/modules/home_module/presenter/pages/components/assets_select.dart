import 'package:flutter/material.dart';
import 'package:flutter_leap_v2/app/modules/home_module/presenter/pages/components/shimmer.dart';
import 'package:flutter_leap_v2/app/modules/home_module/presenter/stores/avatar_store.dart';
import 'package:flutter_leap_v2/shared/utils/app_state.dart';
import 'package:flutter_leap_v2/shared/utils/custom_colors.dart';
import 'package:flutter_leap_v2/shared/utils/misc.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';

class AssetsSelect extends StatefulWidget {
  const AssetsSelect({super.key});

  @override
  State<AssetsSelect> createState() => _AssetsSelectState();
}

class _AssetsSelectState extends State<AssetsSelect> {
  final store = GetIt.I.get<AvatarStore>();
  final assetController = ScrollController();
  @override
  void initState() {
    assetController.addListener(() {
      if (assetController.position.extentAfter == 0) {
        store.getAssets(type: store.selectedAssetType);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: store.assetColors.length,
              itemBuilder: (context, index) {
                return ColorComponent(
                  color: store.assetColors[index],
                  onTap: () {
                    store.updateAvatar(
                      assetKey: "${store.selectedAssetType}Color",
                      assetValue: "$index",
                    );
                  },
                  isSelected: store
                          .avatar3d.assets["${store.selectedAssetType}Color"] ==
                      "$index",
                );
              },
            ),
          ),
          const SizedBox(height: 5),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 60,
            child: Row(
              children: [
                if (store.assets.isNotEmpty)
                  AssetComponent(
                    isEmpty: true,
                    onTap: () {
                      store.updateAvatar(
                        assetKey: getAssetKeyByName(store.selectedAssetType),
                        assetValue: "",
                      );
                    },
                    isSelected: store.selectedAssetType ==
                        store.avatar3d
                            .assets[getAssetKeyByName(store.selectedAssetType)],
                  ),
                Expanded(
                  child: ListView.builder(
                    controller: assetController,
                    scrollDirection: Axis.horizontal,
                    itemCount: store.appState != AppState.loadingMore
                        ? store.assets.length
                        : 20,
                    itemBuilder: (context, index) {
                      return store.appState == AppState.loadingMore
                          ? const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CustomSkeleton(
                                height: 50,
                                width: 50,
                              ),
                            )
                          : AssetComponent(
                              isEmpty: false,
                              image: store.assets[index].iconUrl,
                              onTap: () {
                                store.updateAvatar(
                                  assetKey: getAssetKeyByName(
                                      store.selectedAssetType),
                                  assetValue: store.assets[index].id,
                                );
                              },
                              isSelected: store.assets[index].id ==
                                  store.avatar3d.assets[getAssetKeyByName(
                                      store.selectedAssetType)],
                            );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 40,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  AssetType(
                    title: "Cabelo",
                    onTap: () async {
                      await store.getAssets(
                        type: "hair",
                      );
                      await store.getAssetColors(
                        type: "hair",
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  AssetType(
                    title: "Pele",
                    onTap: () async {
                      store.assets.clear();
                      await store.getAssetColors(
                        type: "skin",
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  AssetType(
                    title: "Barba",
                    onTap: () async {
                      store.assets.clear();
                      await store.getAssets(type: "beard");
                      await store.getAssetColors(
                        type: "beard",
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  AssetType(
                    title: "Olhos",
                    onTap: () async {
                      store.assetColors.clear();
                      await store.getAssets(type: "eye");
                    },
                  ),
                  const SizedBox(width: 10),
                  AssetType(
                    title: "Sobrancelha",
                    onTap: () async {
                      await store.getAssets(
                        type: "eyebrows",
                      );
                      await store.getAssetColors(
                        type: "eyebrow",
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  AssetType(
                    title: "Óculos",
                    onTap: () async {
                      store.assetColors.clear();
                      await store.getAssets(
                        type: "glasses",
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  AssetType(
                    title: "Nariz",
                    onTap: () async {
                      store.assetColors.clear();
                      await store.getAssets(
                        type: "noseshape",
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  AssetType(
                    title: "Boca",
                    onTap: () async {
                      store.assetColors.clear();
                      await store.getAssets(
                        type: "lipshape",
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  AssetType(
                    title: "Maquiagem",
                    onTap: () async {
                      store.assetColors.clear();
                      await store.getAssets(
                        type: "facemask",
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  AssetType(
                    title: "Máscara",
                    onTap: () async {
                      store.assetColors.clear();
                      await store.getAssets(
                        type: "facewear",
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  AssetType(
                    title: "Chapéu",
                    onTap: () async {
                      store.assetColors.clear();
                      await store.getAssets(
                        type: "headwear",
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
        ],
      );
    });
  }
}

class AssetType extends StatelessWidget {
  final String title;
  final Function() onTap;
  const AssetType({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: Text(
          title,
        ),
      ),
    );
  }
}

class AssetComponent extends StatelessWidget {
  final bool isSelected;
  final String image;
  final bool isEmpty;
  final Function() onTap;
  const AssetComponent({
    super.key,
    required this.isEmpty,
    this.image = "",
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: isSelected
              ? Border.all(
                  color: Colors.black,
                )
              : null,
          borderRadius: BorderRadius.circular(5),
        ),
        child: isEmpty
            ? const Icon(
                Icons.block,
                size: 30,
              )
            : Image.network(image),
      ),
    );
  }
}

class ColorComponent extends StatelessWidget {
  final Function() onTap;
  final String color;
  final bool isSelected;
  const ColorComponent({
    super.key,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });
  Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.only(right: 10),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Color(
                int.parse("ff" + color.replaceAll("#", "").replaceAll("ff", ""),
                    radix: 16),
              ), //fromHex(color),
              border: Border.all(color: Colors.white, width: 3),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
        if (isSelected)
          Positioned(
            bottom: 10,
            right: 10,
            child: Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                color: CustomColors.danger,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
      ],
    );
  }
}
