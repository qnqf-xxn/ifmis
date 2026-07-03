if(!Ext.lt.pmkpi) 
	Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.editdefine)
	Ext.lt.pmkpi.editdefine = {};
var scrWidth=document.body.clientWidth;
var scrHeight=document.body.clientHeight;
var windowx;
var auditsql;
Ext.lt.pmkpi.editdefine = function(config, service){
	var cmp = {};
	Ext.lt.pmkpi.editdefine.tokenid = Ext.lt.token.getTokenid();
	Ext.lt.pmkpi.editdefine.bobeanid = config.bobeanid;
	serviceid = config.serverid;
	_tabcode = config.tabcode;

	
	if(config.auditdefined != null && config.auditdefined != ""){
		Ext.lt.pmkpi.editdefine.auditdefined = config.auditdefined;
	}
	
    $(function(){
    	if (Ext.lt.pmkpi.editdefine.auditdefined != null) {
			editform.synchEditformByObj(Ext.lt.pmkpi.editdefine.auditdefined);
		}
    });
	
	cmp.infosave = function (){
		if (!editform.check()) return;//先校验
		var params = editform.getEditFormValues();
		//审核类型根据tab获取
		params.auditdetype = _tabcode;
		Ext.lt.ui.loadingShow();
		Ext.lt.RCP.call(serviceid , "save", params, function(rs){
			if (rs && rs.success) {
				Ext.lt.ui.alert('保存成功！',function(){
					// parent.Ext.lt.pmkpi.query();
					window.parent.Ext.lt.pmkpi.query();
					Ext.lt.ui.closeModalWindow();
				});
			} else {
				Ext.lt.ui.alert('保存失败！',function(){
				});
			}
			Ext.lt.ui.loadingClose();
		});
	}

	Ext.lt.message.hook("editform", "drawed",function(resp){
		var resp;
		var viewguid_eva = {
			viewguid:{
				change:function(param){
					//选择报表
					var viewguid = param._value.text;
					if (viewguid && viewguid != "") {
						viewguid = viewguid.split("-")[0];
					}
					//组成sql
					auditsql = "select * from  " + viewguid +" where #AUTHRULE# ";
					//param.formpanel.configs[7].config.format= auditsql;
					var audsql = {};
					audsql.auditsql=auditsql;
					editform.getCol("auditsql").bind(audsql);
				}
			}
		}
		resp.editformpanel.attachEvent(viewguid_eva);
	});

	return cmp;
}





$(window).resize(function () {          //当浏览器大小变化时
	var scrWidth=document.body.clientWidth;
    var scrHeight=document.body.clientHeight;
	if(windowx){windowx.resize(scrWidth, scrHeight);}
});

