if(!Ext.lt.pmkpi) 
	Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.evaltempinfoAdd)
	Ext.lt.pmkpi.evaltempinfoAdd = {};
var scrWidth=document.body.clientWidth;
var scrHeight=document.body.clientHeight;
var windowx;
var isSaveMain=false;//评价类型信息是否已保存
var curnode;//当前树节点
var tabsid; // 左侧树节点ID
var cmp;
var busIsHidden;
var mainguid;
Ext.lt.pmkpi.evaltempinfoAdd = function(config, service){
	var cmp = {};
	Ext.lt.pmkpi.evaltempinfoAdd.tokenid = config.tokenid;
	Ext.lt.pmkpi.evaltempinfoAdd.bobeanid = config.bobeanid;
	serviceid = config.serverid;
	mainguid = Ext.lt.pmkpi.evaltempinfoAdd.guid;

	cmp.infosave = function(){
		if (!editform.check()) return;//先校验
		var params = {};
		var params = editform.getEditFormValues();
		params.mainguid = config.mainguid;
		params.guid = config.guid;
		var rs = Ext.lt.RCP.asyncall(serviceid , "infosave", params);
		Ext.lt.ui.loadingClose();
		isSaveMain = true;
		// cmp.query();
		return rs;
	}

	return cmp;
}





$(window).resize(function () {          //当浏览器大小变化时
	var scrWidth=document.body.clientWidth;
    var scrHeight=document.body.clientHeight;
	if(windowx){windowx.resize(scrWidth, scrHeight);}
});

