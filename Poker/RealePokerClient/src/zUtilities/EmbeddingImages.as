/*
*	@author LTP 
*/

import flash.utils.Dictionary;

[Embed(source="/assets/images/labai/999.png")]
public var labai999:Class;

[Embed(source="assets/images/labai/20.png")]
public var labai20:Class;
[Embed(source="/assets/images/labai/21.png")]
public var labai21:Class;
[Embed(source="/assets/images/labai/22.png")]
public var labai22:Class;
[Embed(source="/assets/images/labai/23.png")]
public var labai23:Class;

[Embed(source="/assets/images/labai/30.png")]
public var labai30:Class;
[Embed(source="/assets/images/labai/31.png")]
public var labai31:Class;
[Embed(source="/assets/images/labai/32.png")]
public var labai32:Class;
[Embed(source="/assets/images/labai/33.png")]
public var labai33:Class;

[Embed(source="/assets/images/labai/40.png")]
public var labai40:Class;
[Embed(source="/assets/images/labai/41.png")]
public var labai41:Class;
[Embed(source="/assets/images/labai/42.png")]
public var labai42:Class;
[Embed(source="/assets/images/labai/43.png")]
public var labai43:Class;

[Embed(source="/assets/images/labai/50.png")]
public var labai50:Class;
[Embed(source="/assets/images/labai/51.png")]
public var labai51:Class;
[Embed(source="/assets/images/labai/52.png")]
public var labai52:Class;
[Embed(source="/assets/images/labai/53.png")]
public var labai53:Class;

[Embed(source="/assets/images/labai/60.png")]
public var labai60:Class;
[Embed(source="/assets/images/labai/61.png")]
public var labai61:Class;
[Embed(source="/assets/images/labai/62.png")]
public var labai62:Class;
[Embed(source="/assets/images/labai/63.png")]
public var labai63:Class;

[Embed(source="/assets/images/labai/70.png")]
public var labai70:Class;
[Embed(source="/assets/images/labai/71.png")]
public var labai71:Class;
[Embed(source="/assets/images/labai/72.png")]
public var labai72:Class;
[Embed(source="/assets/images/labai/73.png")]
public var labai73:Class;

[Embed(source="/assets/images/labai/80.png")]
public var labai80:Class;
[Embed(source="/assets/images/labai/81.png")]
public var labai81:Class;
[Embed(source="/assets/images/labai/82.png")]
public var labai82:Class;
[Embed(source="/assets/images/labai/83.png")]
public var labai83:Class;

[Embed(source="/assets/images/labai/90.png")]
public var labai90:Class;
[Embed(source="/assets/images/labai/91.png")]
public var labai91:Class;
[Embed(source="/assets/images/labai/92.png")]
public var labai92:Class;
[Embed(source="/assets/images/labai/93.png")]
public var labai93:Class;

[Embed(source="/assets/images/labai/100.png")]
public var labai100:Class;
[Embed(source="/assets/images/labai/101.png")]
public var labai101:Class;
[Embed(source="/assets/images/labai/102.png")]
public var labai102:Class;
[Embed(source="/assets/images/labai/103.png")]
public var labai103:Class;

[Embed(source="/assets/images/labai/110.png")]
public var labai110:Class;
[Embed(source="/assets/images/labai/111.png")]
public var labai111:Class;
[Embed(source="/assets/images/labai/112.png")]
public var labai112:Class;
[Embed(source="/assets/images/labai/113.png")]
public var labai113:Class;

[Embed(source="/assets/images/labai/120.png")]
public var labai120:Class;
[Embed(source="/assets/images/labai/121.png")]
public var labai121:Class;
[Embed(source="/assets/images/labai/122.png")]
public var labai122:Class;
[Embed(source="/assets/images/labai/123.png")]
public var labai123:Class;

[Embed(source="/assets/images/labai/130.png")]
public var labai130:Class;
[Embed(source="/assets/images/labai/131.png")]
public var labai131:Class;
[Embed(source="/assets/images/labai/132.png")]
public var labai132:Class;
[Embed(source="/assets/images/labai/133.png")]
public var labai133:Class;

[Embed(source="/assets/images/labai/140.png")]
public var labai140:Class;
[Embed(source="/assets/images/labai/141.png")]
public var labai141:Class;
[Embed(source="/assets/images/labai/142.png")]
public var labai142:Class;
[Embed(source="/assets/images/labai/143.png")]
public var labai143:Class;

public var cardImg:Dictionary;

private function initAssetsImg():void{
	cardImg = new Dictionary();
	
	cardImg["20"] = labai20;
	cardImg["21"] = labai21;
	cardImg["22"] = labai22;
	cardImg["23"] = labai23;

	cardImg["30"] = labai30;
	cardImg["31"] = labai31;
	cardImg["32"] = labai32;
	cardImg["33"] = labai33;
	
	cardImg["40"] = labai40;
	cardImg["41"] = labai41;
	cardImg["42"] = labai42;
	cardImg["43"] = labai43;
	
	cardImg["50"] = labai50;
	cardImg["51"] = labai51;
	cardImg["52"] = labai52;
	cardImg["53"] = labai53;
	
	cardImg["60"] = labai60;
	cardImg["61"] = labai61;
	cardImg["62"] = labai62;
	cardImg["63"] = labai63;
	
	cardImg["70"] = labai70;
	cardImg["71"] = labai71;
	cardImg["72"] = labai72;
	cardImg["73"] = labai73;
	
	cardImg["80"] = labai80;
	cardImg["81"] = labai81;
	cardImg["82"] = labai82;
	cardImg["83"] = labai83;
	
	cardImg["90"] = labai90;
	cardImg["91"] = labai91;
	cardImg["92"] = labai92;
	cardImg["93"] = labai93;
	
	cardImg["100"] = labai100;
	cardImg["101"] = labai101;
	cardImg["102"] = labai102;
	cardImg["103"] = labai103;
	
	cardImg["110"] = labai110;
	cardImg["111"] = labai111;
	cardImg["112"] = labai112;
	cardImg["113"] = labai113;
	
	cardImg["120"] = labai120;
	cardImg["121"] = labai121;
	cardImg["122"] = labai122;
	cardImg["123"] = labai123;
	
	cardImg["130"] = labai130;
	cardImg["131"] = labai131;
	cardImg["132"] = labai132;
	cardImg["133"] = labai133;
	
	cardImg["140"] = labai140;
	cardImg["141"] = labai141;
	cardImg["142"] = labai142;
	cardImg["143"] = labai143;
}
