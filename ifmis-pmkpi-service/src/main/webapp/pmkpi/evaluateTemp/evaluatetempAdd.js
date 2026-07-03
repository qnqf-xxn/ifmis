if(!Ext.lt.pmkpi) 
	Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.evaluatetempAdd)
	Ext.lt.pmkpi.evaluatetempAdd = {};
var scrWidth=document.body.clientWidth;
var scrHeight=document.body.clientHeight;
var windowx;
var isSaveMain=false;//评价类型信息是否已保存
var curnode;//当前树节点
var tabsid; // 左侧树节点ID
var cmp;
var busIsHidden;
var mainguid;
var _viewtype;
Ext.lt.pmkpi.evaluatetempAdd = function(config, service){
	var cmp = {};
	//var cmp = new Ext.lt.bus.bill.billManage(config, service);

	Ext.lt.pmkpi.evaluatetempAdd.tokenid = config.tokenid;
	Ext.lt.pmkpi.evaluatetempAdd.bobeanid = config.bobeanid;
	serviceid = config.serverid;
	mainguid = Ext.lt.pmkpi.evaluatetempAdd.guid;
	_viewtype = config.viewtype;
	if(config.evaluateTemp!=null && config.evaluateTemp!=""){
		isSaveMain = true;
		Ext.lt.pmkpi.evaluatetempAdd.evaluateTemp = config.evaluateTemp;
		Ext.lt.pmkpi.evaluatetempAdd.guid = config.evaluateTemp.guid;
	}

	$(function () {
		//cmp.init(config);
		cmp.writeBack();
	})

	cmp.writeBack = function(){
		if (_viewtype != "add") {
			if (Ext.lt.pmkpi.evaluatetempAdd.evaluateTemp != null) {
				editform.synchEditformByObj(Ext.lt.pmkpi.evaluatetempAdd.evaluateTemp);
			}
		}
	}




	cmp.infosave = function(){
		if (!editform.check()) return;//先校验
		var params = {};
		var params = editform.getEditFormValues();
		params.mainguid = config.mainguid;
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

