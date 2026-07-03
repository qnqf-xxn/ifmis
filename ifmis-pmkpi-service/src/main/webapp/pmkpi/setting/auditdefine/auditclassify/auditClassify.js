if(!Ext.lt.pmkpi) 
	Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.auditclassify)
	Ext.lt.pmkpi.auditclassify = {};
var scrWidth=document.body.clientWidth;
var scrHeight=document.body.clientHeight;
var windowx;
Ext.lt.pmkpi.auditclassify.index = function(config, service){
	var cmp = {};
	Ext.lt.pmkpi.auditclassify.tokenid = Ext.lt.token.getTokenid();
	Ext.lt.pmkpi.auditclassify.bobeanid = config.bobeanid;
	serviceid = config.serverid;
	
	cmp.draw = function() {
		cmp.query();
	}
    $(function () {
        cmp.query();
    })
	cmp.uidatatable = datatable;
	cmp.queryform = queryform;
    cmp.query = function () {
		var params = {};
		params.condition = queryform.getQuerySQL();
		if(queryform.getQuerySQL())params.wheresql = queryform.getQuerySQL();
		if(queryform)params.queryConfig = queryform.getQueryParam();
		params.beanid = Ext.lt.pmkpi.auditclassify.bobeanid;
		Ext.lt.bus.exportBeanid = params.beanid;
		datatable.queryData(params, null);
    }
    
    Ext.lt.message.hook("addRow", "uidatatable",function(){
    	value = {};
    	datatable.addData(value);
    }) 
    
	Ext.lt.message.hook("delRow", "uidatatable",function(){
		var delDatas = datatable.getSelected();
		if (delDatas.size() <= 0) {
			Ext.lt.ui.alert('请选择要删除的数据！',function(){
			});
			return;
		}
		Ext.lt.ui.confirm('是否删除已选择数据？',null,function(is){
			if(is){
				datatable.removeData(delDatas);
			}
		})

	}) 
	
	cmp.infosave = function (){
		if (!queryform.check()) return;//先校验
		var params = {};
		params.datas = datatable.getRecordSet().toArray();
		params.updatas = datatable.getUpdataData();
		params.deldatas = datatable.getRemoveData();
		if (!datatable.checkData(params.datas)) return;//先校验
		if (!datatable.checkData(params.updatas)) return;//先校验
		Ext.lt.ui.loadingShow();
		Ext.lt.RCP.call(serviceid , "infosave", params, function(rs){
			if(rs.error){
				Ext.lt.ui.alert(rs.error);
			} else{
				Ext.lt.ui.alert(("保存成功！"),{}, function(ret) {
				});
				Ext.lt.ui.loadingClose();
				cmp.query();
			}
		});
	}
	
	return cmp;
}



$(window).resize(function () {          //当浏览器大小变化时
	var scrWidth=document.body.clientWidth;
    var scrHeight=document.body.clientHeight;
	if(windowx){windowx.resize(scrWidth, scrHeight);}
});

