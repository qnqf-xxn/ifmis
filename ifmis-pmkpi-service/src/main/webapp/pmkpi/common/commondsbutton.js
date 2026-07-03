if(!Ext.lt.pmkpi) 
	Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.commondsbutton)
	Ext.lt.pmkpi.commondsbutton = {};
if(!Ext.lt.bus.bill)
	Ext.lt.bus.bill = {};
if(!Ext.lt.bus.bill.dcservice)
	Ext.lt.bus.bill.dcservice = {};

Ext.lt.bus.bill.dcservice = function(config, service){
	var cmp = new Ext.lt.bus.dc.base.index(config, service);
	var _initsave = cmp.save;
	cmp.save = function() {
		var datas = cmp.uidatatable.getTableData();
		var errorMsg = cmp.uidatatable.verifyMustCol();
		if(errorMsg){
			alert(errorMsg);
			return;
		}	
		
		for(var i=0,n=datas.length; i<n; i++){
			datas[i].KEYGUID = dcserviceKeyGuid;
			datas[i].PROJGUID = dcserviceProjGuid;
		}
		
		var params = {};
		params["tableCode"] = cmp.uidatatable.tableCode;
		params["modelId"] = cmp.uidatatable.modelId;
		params["datas"] = datas;
		params["dcserviceProjGuid"] = dcserviceProjGuid;
		params["wheresql"] = "agencyguid = '' or projguid = '"+dcserviceProjGuid+"'";
//		Ext.lt.message.send("dctable", "save",params);
		Tools.rcp(dcserviceid, params,"saveCjb", function(rs){
			cmp.uidatatable.resetModifyMark();
			Tools.alert("保存成功");
		});
    }
	cmp.query = function(){
		var table = null;
		if(obj && obj.id && obj.id.indexOf("datatable")>0){
			table = obj;
		}else{
			table = cmp.uidatatable;
		}
		var params = {};
		params.urlparameters = Ext.lt.ui.getUrlParameters();
		params.beanid = dcserviceBoBeanId;
		params.cjlbquery = "1";
//		params.cjkeyguid = dcserviceKeyGuid;
		params.cjprojguid = dcserviceProjGuid;
		params.cjvcol31 = dcserviceVcol31;
		params.tabsid = "CJB";
		if(cmp.queryform)params.cjcondition = queryform.getQuerySQL();
		Ext.lt.message.send("dctable", "query",params);
		table.queryData(params,function(rs){
			cmp.wheresql = params.wheresql;
			Ext.lt.message.send("dctable", "queryed",{params:params,rs:rs});
		});
	}
	return cmp;
}

var tempConfig={};
tempConfig["bobeanid"]="datacommon.base.DataCommonBOTx";//采集表bobean
var dcObj = new Ext.lt.bus.bill.dcservice(tempConfig, _APPID_PATH_+"/datacommon/preview/index/indexservice");

Ext.lt.pmkpi.commondsbutton.cjsave = function(){
	dcObj.save();
}
Ext.lt.pmkpi.commondsbutton.cjdelete = function (){
	dcObj["delete"]();
}
Ext.lt.pmkpi.commondsbutton.cjadd = function (){
	dcObj.add();
}
Ext.lt.pmkpi.commondsbutton.cjquery = function (){
	dcObj["uidatatable"] = info_load.viewcomponent["uidatatable"];
	dcObj.query();
}

Ext.lt.pmkpi.commondsbutton.adopt = function(){
	var url = '/pmkpi/projPerfGoalAudit/audit';
	url = url + '.page?tokenid=' + Ext.lt.token.getTokenid();
	url = url + '&goalguid=' + dcserviceKeyGuid;
	url = url + '&isPass=pass';
	url = url + '&adjust='+ adjust;
	Ext.lt.ui.openModalWindow(url,800,550,"审核意见");
}

Ext.lt.pmkpi.commondsbutton.back = function(){
	var url = '/pmkpi/projPerfGoalAudit/audit';
	url = url + '.page?tokenid=' + Ext.lt.token.getTokenid();
	url = url + '&goalguid=' + dcserviceKeyGuid;
	url = url + '&isPass=back';
	url = url + '&adjust='+ adjust;
	Ext.lt.ui.openModalWindow(url,800,550,"审核意见");
}

Ext.lt.pmkpi.commondsbutton.obsolete = function(){
	var goalguid = Ext.lt.pmkpi.projPerfGoalAudit.add.guid;
	var url = '/pmkpi/projPerfGoalAudit/audit';
	url = url + '.page?tokenid=' + Ext.lt.token.getTokenid();
	url = url + '&goalguid=' + dcserviceKeyGuid;
	url = url + '&isPass=obsolete';
	url = url + '&adjust='+ adjust;
	Ext.lt.ui.openModalWindow(url,800,550,"审核意见");
}

Ext.lt.pmkpi.commondsbutton.doaction = function(){}

Ext.lt.pmkpi.commondsbutton.cjreply = function(){
	var params = {};
	params.goalguid = dcserviceKeyGuid;
	Ext.lt.ui.confirm("是否确定批复?",null,function(is){
		if(is){
			var result = Ext.lt.RCP.asyncall(dcserviceServiceId , "saveAuditReply", params);
			if(result.error){
				Ext.lt.ui.alert(config.error);
			} else {
				Ext.lt.ui.alert('操作成功！',function(){
					Ext.lt.ui.loadingClose();
					Ext.lt.ui.closeModalWindow();// 关闭
					parent.cmp.query();
				});
			}
		}
	});
}