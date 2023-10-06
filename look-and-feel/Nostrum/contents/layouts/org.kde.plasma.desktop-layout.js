var plasma = getApiVersion(1);

var layout = {
    "desktops": [
        {
            "applets": [
                {
                    "config": {
                    },
                    "geometry.height": 0,
                    "geometry.width": 0,
                    "geometry.x": 0,
                    "geometry.y": 0,
                    "plugin": "org.kde.plasma.mediacontroller_plus",
                    "title": "Media Player +"
                }
            ],
            "config": {
                "/": {
                    "ItemGeometries-1024x768": "Applet-218:704,480,320,288,0;Applet-219:336,400,256,368,0;Applet-220:624,496,400,272,0;",
                    "ItemGeometries-1920x1080": "Applet-170:1648,32,240,240,0;",
                    "ItemGeometries-2560x1440": "Applet-221:1920,912,304,400,0;",
                    "ItemGeometries-800x600": "Applet-218:704,480,320,288,0;Applet-219:336,400,256,368,0;Applet-220:624,496,400,272,0;",
                    "ItemGeometriesHorizontal": "Applet-221:1920,912,304,400,0;",
                    "formfactor": "0",
                    "immutability": "1",
                    "lastScreen": "0",
                    "wallpaperplugin": "org.kde.image"
                },
                "/ConfigDialog": {
                    "DialogHeight": "540",
                    "DialogWidth": "720"
                },
                "/Configuration": {
                    "PreloadWeight": "0"
                },
                "/General": {
                    "ToolBoxButtonState": "topcenter",
                    "ToolBoxButtonX": "899",
                    "ToolBoxButtonY": "32",
                    "positions": "{\"2560x1440\":[]\\,\"1024x768\":[]\\,\"1920x1080\":[\"\"]\\,\"800x600\":[]}",
                    "sortMode": "-1"
                },
                "/Wallpaper/org.kde.color/General": {
                    "Color": "70,130,180"
                },
                "/Wallpaper/org.kde.image/General": {
                    "Image": "/home/mark/Downloads/2560x1440.png",
                    "SlidePaths": "/home/mark/.local/share/wallpapers/,/usr/share/wallpapers/"
                }
            },
            "wallpaperPlugin": "org.kde.image"
        }
    ],
    "panels": [
        {
            "alignment": "center",
            "applets": [
                {
                    "config": {
                        "/": {
                            "PreloadWeight": "56"
                        },
                        "/General": {
                            "favoritesPortedToKAstats": "true"
                        }
                    },
                    "plugin": "org.kde.plasma.kickoff"
                },
                {
                    "config": {
                        "/": {
                            "PreloadWeight": "0"
                        }
                    },
                    "plugin": "org.kde.plasma.marginsseparator"
                },
                {
                    "config": {
                        "/": {
                            "PreloadWeight": "0"
                        }
                    },
                    "plugin": "org.kde.plasma.appmenu"
                },
                {
                    "config": {
                        "/": {
                            "PreloadWeight": "0"
                        }
                    },
                    "plugin": "org.kde.plasma.panelspacer"
                },
                {
                    "config": {
                        "/": {
                            "PreloadWeight": "0"
                        }
                    },
                    "plugin": "org.kde.plasma.pager"
                },
                {
                    "config": {
                        "/": {
                            "PreloadWeight": "0"
                        }
                    },
                    "plugin": "org.kde.plasma.marginsseparator"
                },
                {
                    "config": {
                        "/": {
                            "PreloadWeight": "5"
                        }
                    },
                    "plugin": "org.kde.plasma.systemtray"
                },
                {
                    "config": {
                        "/": {
                            "PreloadWeight": "0"
                        },
                        "/Appearance": {
                            "enabledCalendarPlugins": "/usr/lib/qt/plugins/plasmacalendarplugins/holidaysevents.so",
                            "showDate": "false",
                            "showWeekNumbers": "true"
                        },
                        "/ConfigDialog": {
                            "DialogHeight": "540",
                            "DialogWidth": "720"
                        }
                    },
                    "plugin": "org.kde.plasma.digitalclock"
                }
            ],
            "config": {
                "/": {
                    "formfactor": "2",
                    "immutability": "1",
                    "lastScreen": "0",
                    "wallpaperplugin": "org.kde.image"
                },
                "/ConfigDialog": {
                    "DialogHeight": "82",
                    "DialogWidth": "2560"
                },
                "/Configuration": {
                    "PreloadWeight": "0"
                },
                "/Shortcuts": {
                    "global": ""
                }
            },
            "height": 1.7777777777777777,
            "hiding": "normal",
            "location": "top",
            "maximumLength": 142.22222222222223,
            "minimumLength": 142.22222222222223,
            "offset": 0
        },
        {
            "alignment": "center",
            "applets": [
                {
                    "config": {
                        "/": {
                            "PreloadWeight": "5",
                            "popupHeight": "499",
                            "popupWidth": "629"
                        },
                        "/General": {
                            "favoritesPortedToKAstats": "true"
                        }
                    },
                    "plugin": "org.kde.plasma.simplemenu"
                },
                {
                    "config": {
                        "/": {
                            "PreloadWeight": "0"
                        }
                    },
                    "plugin": "org.kde.latte.separator"
                },
                {
                    "config": {
                        "/": {
                            "PreloadWeight": "0"
                        },
                        "/General": {
                            "launchers": "preferred://browser,applications:systemsettings.desktop,preferred://filemanager,applications:org.kde.gwenview.desktop,applications:org.kde.konsole.desktop,applications:cantata.desktop"
                        }
                    },
                    "plugin": "org.kde.plasma.icontasks"
                },
                {
                    "config": {
                        "/": {
                            "PreloadWeight": "0"
                        }
                    },
                    "plugin": "org.kde.latte.separator"
                },
                {
                    "config": {
                        "/": {
                            "PreloadWeight": "0"
                        }
                    },
                    "plugin": "org.kde.plasma.trash"
                },
                {
                    "config": {
                        "/": {
                            "PreloadWeight": "0"
                        },
                        "/ConfigDialog": {
                            "DialogHeight": "510",
                            "DialogWidth": "680"
                        },
                        "/General": {
                            "showSecondHand": "true"
                        }
                    },
                    "plugin": "org.kde.plasma.analogclock"
                }
            ],
            "config": {
                "/": {
                    "formfactor": "2",
                    "immutability": "1",
                    "lastScreen": "0",
                    "wallpaperplugin": "org.kde.image"
                },
                "/ConfigDialog": {
                    "DialogHeight": "82",
                    "DialogWidth": "2560"
                },
                "/Configuration": {
                    "PreloadWeight": "0"
                }
            },
            "height": 4.111111111111111,
            "hiding": "normal",
            "location": "bottom",
            "maximumLength": 106.88888888888889,
            "minimumLength": 106.88888888888889,
            "offset": 0
        }
    ],
    "serializationFormatVersion": "1"
}
;

plasma.loadSerializedLayout(layout);
