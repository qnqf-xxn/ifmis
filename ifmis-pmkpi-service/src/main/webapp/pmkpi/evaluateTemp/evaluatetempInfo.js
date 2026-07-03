if(!Ext.lt.pmkpi) 
	Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.evaluatetempinfo)
	Ext.lt.pmkpi.evaluatetempinfo = {};
var scrWidth=document.body.clientWidth;
var scrHeight=document.body.clientHeight;
var windowx;
var isSaveMain=false;//评价类型信息是否已保存
var curnode;//当前树节点
var tabsid; // 左侧树节点ID
var cmp;
var busIsHidden;
var _mainguid;
Ext.lt.pmkpi.evaluatetempinfo = function(config, service){
	var cmp = {};
	Ext.lt.pmkpi.evaluatetempinfo.tokenid = config.tokenid;
	Ext.lt.pmkpi.evaluatetempinfo.bobeanid = config.bobeanid;
	serviceid = config.serverid;
	_mainguid = config.mainguid;
	cmp.draw = function() {
		cmp.query();
	}
	$(function () {
		cmp.query();
	})

	//查询
	cmp.query = function (){
		Ext.lt.pmkpi.query();
	}

	Ext.lt.pmkpi.query = function(){
		var params = {};
		Ext.lt.ui.loadingShow();
		params.mainguid = _mainguid;
		Ext.lt.RCP.call(serviceid , "getData", params, function(rs){
			datatable.setDatas(rs.data);
			Ext.lt.ui.loadingClose();
		},function() {
			Ext.lt.ui.loadingClose();
			Ext.lt.ui.alert('查询失败！',function(){
			});
		});

	}

	cmp.tempsave = function(){
		if (!datatable.checkAll()) return false;//先校验
		var params = {};
		params.datas = datatable.getRecordSet().toArray();
		params.updatas = datatable.getUpdataData();
		params.deldatas = datatable.getRemoveData();
		Ext.lt.ui.loadingShow();
		var rs = Ext.lt.RCP.asyncall(serviceid , "save", params);
		Ext.lt.ui.loadingClose();
		cmp.query();
		return rs;
	}


	cmp.toAdd = function(){
/*
		var params = {};
		var url = '/pmkpi/evaluatetemp/tempAdd.page';
		params.mainguid = _mainguid;
		var newguid = Ext.lt.RCP.asyncall(serviceid , "getCreateguid", null);
		params.guid = newguid;
		url = Ext.lt.pmkpi.genPageUrl(url, params);
		Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"新增评价模板");
*/

		var data = {};
		var newguid = Ext.lt.RCP.asyncall(serviceid , "getCreateguid", null);
		data.guid = newguid;
		data.mainguid = _mainguid;
		data.rowtype = "add";
		data.levelno = 1;
		data.isleaf = 0;
		datatable.getRecordSet().addData(data,999);
	}

	return cmp;
}





$(window).resize(function () {          //当浏览器大小变化时
	var scrWidth=document.body.clientWidth;
    var scrHeight=document.body.clientHeight;
	if(windowx){windowx.resize(scrWidth, scrHeight);}
});

Ext.lt.message.hook("datatable", 'beforesetcols',function(data){
	var cols = data.cols;
	if(!Ext.lt.isArray(cols))
		cols = [cols];
	for(var i=0; i<cols.length; i++){
		var col = cols[i];
		if(col["colcode"]=="obligate1"){
			col.fn = function(l,c,data,col){
				var html = "";
				if(data.levelno == "1" || data.levelno == '2'){//层次
					html += '&nbsp;&nbsp;&nbsp;&nbsp';
					html += '<a title = "新增" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:indexadd("'+data.guid+'","'+data.levelno+'")\'>新增</a>';
				}else{
					html += '&nbsp;&nbsp;&nbsp;&nbsp';
				}
				html += '&nbsp;&nbsp;&nbsp;&nbsp';
				html += '<a title = "删除" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:indexdel("'+data.guid+'")\'>删除</a>';
				return html;
			}
		}
	}
});

function indexadd(superid,levelno) {
	var data = {};
	var newguid = Ext.lt.RCP.asyncall(serviceid , "getCreateguid", null);
	data.guid = newguid;
	data.rowtype = "add";
	data.mainguid = _mainguid;
	data.superid = superid;
	data.levelno = parseInt(levelno)+1;
	data.isleaf = 1;
	Ext.lt.pmkpi.isadd = true;
	datatable.getRecordSet().addData(data,999);
}

function indexdel(guid) {
	var datas = datatable.getRecordSet().toArray();
	if (datas != null && datas.length > 0) {
		for (var i = 0; i < datas.length; i++) {
			var selectDatas = datas[i];
			//如果有下级则不可删除
			if(guid ==selectDatas.superid){
				Ext.lt.ui.alert('该数据有下级 不可删除！');
				return;
			}
		}
	}
	Ext.lt.ui.confirm("你确定删除选定的数据？", {icon: "warn"}, function (ret) {
		if (ret) {
			if (datas != null && datas.length > 0) {
				for (var i = 0; i < datas.length; i++) {
					var selectDatas = datas[i];
					if (guid == selectDatas.guid) {
						datatable.removeData(selectDatas);
					}
				}
			}
		}
	});
}


