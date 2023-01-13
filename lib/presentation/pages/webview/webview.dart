// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'package:amar_bongo_app/data/models/item_model.dart';
import 'package:amar_bongo_app/domain/entities/item.dart';
import 'package:amar_bongo_app/presentation/constants/color.dart';
import 'package:amar_bongo_app/presentation/cubits/appinfo/appinfo_cubit.dart';
import 'package:amar_bongo_app/presentation/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:share_plus/share_plus.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
// #docregion platform_imports
// Import for Android features.
import 'package:flutter_bloc/flutter_bloc.dart';
// Import for iOS features.

class WebviewPage extends StatefulWidget {
  final ItemEntity itemEntity;
  const WebviewPage({super.key, required this.itemEntity});

  @override
  State<WebviewPage> createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  late final WebViewController _controller;
  bool isFething = true;
  int loadPercentage = 0;
  List<ItemFavModel> favoriteList = [];
  late DBHelper dbHelper;
  bool isAdsShown = false;

  bool _isLoading = true;
  bool isAdpermission = false;

  bool isAlreadyFav = false;
  final _key = UniqueKey();

  fetch() async {
    favoriteList = await dbHelper.fetchList().whenComplete(() {
      setState(() {
        isFething = false;
      });
    });

    // print(widget.itemEntity.title);

    for (var element in favoriteList) {
      if (element.title!.toLowerCase() ==
          widget.itemEntity.title!.toLowerCase()) {
        isAlreadyFav = true;
        break;
      } else {
        isAlreadyFav = false;
      }
    }
  }

  @override
  void initState() {
    super.initState();

    dbHelper = DBHelper();
    fetch();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              loadPercentage = progress;
            });
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse(widget.itemEntity.url!));
    // #docregion platform_features
    // late final PlatformWebViewControllerCreationParams params;
    // if (WebViewPlatform.instance is WebKitWebViewPlatform) {
    //   params = WebKitWebViewControllerCreationParams(
    //     allowsInlineMediaPlayback: true,
    //     mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
    //   );
    // } else {
    //   params = const PlatformWebViewControllerCreationParams();
    // }

    // final WebViewController controller =
    //     WebViewController.fromPlatformCreationParams(params);
    // // #enddocregion platform_features

    // controller
    //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //   ..setBackgroundColor(const Color(0x00000000))
    //   ..setNavigationDelegate(
    //     NavigationDelegate(
    //       onProgress: (int progress) {
    //         setState(() {
    //           loadPercentage = progress;
    //         });
    //         debugPrint('WebView is loading (progress : $progress%)');
    //       },
    //       onPageStarted: (String url) {
    //         debugPrint('Page started loading: $url');
    //       },
    //       onPageFinished: (String url) {
    //         debugPrint('Page finished loading: $url');
    //         setState(() {
    //           _isLoading = false;
    //         });
    //       },
    //     ),
    //   )
    //   ..addJavaScriptChannel(
    //     'Toaster',
    //     onMessageReceived: (JavaScriptMessage message) {
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         SnackBar(content: Text(message.message)),
    //       );
    //     },
    //   )
    //   ..loadRequest(Uri.parse(widget.itemEntity.url!));

    // // #docregion platform_features
    // if (controller.platform is AndroidWebViewController) {
    //   AndroidWebViewController.enableDebugging(true);
    //   (controller.platform as AndroidWebViewController)
    //       .setMediaPlaybackRequiresUserGesture(false);
    // }
    // // #enddocregion platform_features

    // _controller = controller;
  }

  @override
  void dispose() {
    // _controller.clearCache();
    // _controller.clearLocalStorage();

    super.dispose();
  }

  InterstitialAd? _interstitialAd;

  void loadAds(String adId) {
    InterstitialAd.load(
        adUnitId: adId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print("Interstitial Ad Loaded");
            // Keep a reference to the ad so you can show it later.
            _interstitialAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error');
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await _controller.canGoBack()) {
          await _controller.goBack();
          return false;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Closed')),
          );
          if (isAdpermission) {
            if (isAdsShown == false) {
              if (_interstitialAd != null) {
                _interstitialAd!.show();
                setState(() {
                  isAdsShown = true;
                });
              }
              setState(() {});
            } else {
              print('add alrady show');
            }
            setState(() {});
          } else {
            print('no permit');
          }
          return true;
        }
      },
      child: Scaffold(
        key: _key,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          leading: IconButton(
              splashRadius: 25.0,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Theme.of(context).primaryColor,
              )),
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  widget.itemEntity.title!,
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontSize: 18.0, color: Theme.of(context).primaryColor),
                ),
              ),
            ],
          ),
          actions: [
            BlocBuilder<AppinfoCubit, AppinfoState>(
              builder: (context, state) {
                if (state is AppinfoLoaded) {
                  debugPrint(state.appInfoModel.addstatus);
                  debugPrint(state.appInfoModel.interstitialad);
                  //loadAds(state.appInfoModel.interstitialad!);
                  loadAds(state.appInfoModel.bannerad!);

                  if (state.appInfoModel.addstatus!.toLowerCase() == "on") {
                    isAdpermission = true;
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          padding: const EdgeInsets.all(0.0),
                          splashRadius: 25,
                          iconSize: 28.0,
                          onPressed: () {
                            if (!isAlreadyFav) {
                              if (widget.itemEntity.title != null) {
                                ItemFavModel itemFavModel = ItemFavModel(
                                  title: widget.itemEntity.title,
                                  image: widget.itemEntity.image,
                                  url: widget.itemEntity.url,
                                  category: widget.itemEntity.category,
                                );

                                dbHelper.insert(itemFavModel).whenComplete(() {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text('Added To Favorite'),
                                    backgroundColor: AppColor.primaryColor,
                                  ));
                                  fetch();

                                  if (isAdpermission) {
                                    if (isAdsShown == false) {
                                      if (_interstitialAd != null) {
                                        _interstitialAd!.show();

                                        isAdsShown = true;
                                        setState(() {});
                                      }
                                      setState(() {});
                                    } else {
                                      print('alrady ad show fav');
                                    }

                                    setState(() {});
                                    // _interstitialAd!.show();
                                  } else {
                                    print("ads off now");
                                  }
                                });
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('Please try again later'),
                                  backgroundColor: AppColor.redColor,
                                ));
                              }
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Already have Favorite'),
                                backgroundColor: AppColor.redColor,
                              ));
                            }
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (builder) => const FavoritePage()));
                          },
                          icon: Icon(
                            isAlreadyFav
                                ? Icons.favorite
                                : Icons.favorite_outline,
                            color: isAlreadyFav
                                ? AppColor.redColor
                                : AppColor.primaryColor,
                          )),
                      IconButton(
                          padding: const EdgeInsets.all(0.0),
                          splashRadius: 25,
                          iconSize: 28.0,
                          onPressed: () {
                            Share.share(
                                'Share From Amar Bongo App\nurl:${widget.itemEntity.url}',
                                subject: widget.itemEntity.title);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (builder) => const SearchPage()));
                          },
                          icon: const Icon(
                            Icons.share_outlined,
                            color: AppColor.goldenColor,
                          ))
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            )
          ],
          // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
        ),
        body: _isLoading == true
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const LinearProgressIndicator(
                    color: AppColor.goldenColor,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  CircleAvatar(
                    backgroundColor: AppColor.goldenColor,
                    radius: 25.0,
                    child: Text(
                      "${loadPercentage.toString()}%",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: AppColor.whiteColor),
                    ),
                  )
                ],
              )
            : WebViewWidget(controller: _controller),
      ),
    );
  }
}
