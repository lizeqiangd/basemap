basemap
=========
## introduction 介绍
- basemap is a pure as3 map sdk base on tile map service.
- Now the library only support mapbox. You just simply set your appkey to use it.
- basemap是一个基于纯as3语言制作的瓦片地图.通过设置使用的地图和相应的appkey以及设置.可以使用理论上所有基于瓦片的地图.(目前只开发mapbox模块)

## how to use 如何使用 

	//For Englist user, just watch the code.
	//MapSetting里面,你可以设置下地图参数.需要地图类型和appkey
    MapSetting.getInstance.basemap_type = 'mapbox';
	MapSetting.getInstance.mapbox_token = '#your appkey';
	MapSetting.getInstance.mapbox_style = 'mapbox.streets';

    //使用方法.使用getInstance获取本例的单例.
    var bm:BaseMap=BaseMap.getInstance;
    //init map.
    bm.init();
    //add to stage
    addChild(bm);

## environment

- 理论上你用任何一个标准的sdk都可以跑起来.
- FlashDevelop + flex4.7sdk.   
- With default settings.

## demo

-  [DemoSite for Chinese.](http://www.lizeqiangd.com/basemap)

## copyright & contact

- Lizeqiangd
- Email:Lizeqiangd@gmail.com

