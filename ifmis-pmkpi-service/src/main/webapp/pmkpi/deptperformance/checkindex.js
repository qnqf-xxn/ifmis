if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}

if(!Ext.lt.pmkpi.deptperformance){
    Ext.lt.pmkpi.deptperformance = {};
}

Ext.lt.pmkpi.deptperformance.deptcheckindex = function(config, service){
	window.parent.Ext.lt.pmkpi.childwindow = window;
	var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var serviceid = service,
        _sindex = config.sindex,
		_mainguid = config.mainguid;

    Ext.lt.pmkpi.query = function(){
        Ext.lt.ui.loadingShow();
        var params = {};
        params.sindex = _sindex;
        params.saveAgency=config.saveAgency;
        Ext.lt.RCP.call(serviceid , "indexcheck", params, function(rs){
			datatable.setDatas(rs.data);
            Ext.lt.ui.loadingClose();
        },function(){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('查询失败！',function(){
            });
        });
    }


	cmp.infosave =  function() {
		//被选中的数据
		var params = {};
		var newdatas = new Array();
		var datas = datatable.getSelected();
		if(datas!=null && datas.length > 0){
			for(var i=0;i<datas.length;i++){
				var data = datas[i];
				var newguid = Ext.lt.RCP.asyncall(serviceid , "getCreateguid", null);
				data.guid = newguid;
				data.rowtype = "add";
				data.mainguid = _mainguid;
				data.indexval = data.indexvalue;
				data.superid = _sindex;
				data.levelno = 3;
				data.isleaf = 1;
			}
			window.parent.Ext.lt.pmkpi.addrow(datas);
			parent.Ext.lt.ui.modalWindow.close();
		}else{
			alert('请选择列表数据！');
		}
	}

	$(function(){
		//组件配置，service不放到第一位时，组件初始化消息不走问题
		common.initDatatable();
		Ext.lt.pmkpi.query();
	})

	cmp.close = function(){
		parent.Ext.lt.ui.modalWindow.close();
	}
    return cmp;
}
