basemap
=========
## introduction 介绍

basemap是一个基于纯as3语言制作的瓦片地图.通过设置使用的地图和相应的appkey以及设置.可以使用理论上所有基于瓦片的地图.(目前只开发mapbox模块)

## how to use 如何使用

    //使用方法.使用getInstance获取本例的单例.(推荐,否则你就自己修改代码去)
    var bm:BaseMap=BaseMap.getInstance;
    //MapSetting里面,你可以设置下地图参数.需要地图类型和appkey
    bm.config(MapSetting.getInstance);
    //初始化地图(之后可能会改)
    bm.init();
    addChild(bm);

## environment
- 理论上你用任何一个标准的sdk都可以跑起来...这根本没用任何恶心人的代码.

## demo

-  [DemoSite](www.lizeqiangd.com)

## copyright & contact
- Lizeqiangd
- Email:Lizeqiangd@gmail.com
