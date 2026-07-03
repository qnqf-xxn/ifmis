if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.fundtemp)
	Ext.lt.pmkpi.fundtemp = {};

Ext.lt.pmkpi.fundtemp = function(config, service){
    var cmp = {};
    var serviceid = service;	
    
    $(function () {
        cmp.query();
    })
    /**
     * 保存
     */
    cmp.tablesave = function(){
    	if(!datatable.checkAll())return;
    	var params={};
    	params.datas = datatable.getRecordSet().toArray();
    	Ext.lt.RCP.call(serviceid, "save", params, function(rs){
    		if (rs && rs.success) {
                Ext.lt.ui.alert('保存成功！',function(){
                    cmp.query();
                });
            }
    		Ext.lt.ui.loadingClose();
    	}, function(){
    		Ext.lt.ui.alert('保存失败！',function(){
    		});
    		Ext.lt.ui.loadingClose();
    	});
    }
    
    /**
     * 查询
     */
    cmp.query = function(){
    	Ext.lt.ui.loadingShow();
    	Ext.lt.RCP.call(serviceid, "getFundData", null, function(rs){
    		datatable.setDatas(rs.data);
    		Ext.lt.ui.loadingClose();
    	},function(){
    		Ext.lt.ui.alert('查询失败！', function(){});
    		Ext.lt.ui.loadingClose();
    	});
    }
    
    /**
     * 表格添加行
     */
    Ext.lt.message.hook("addRow", "uidatatable", function(editdatatable){
    	var newguid = Ext.lt.RCP.asyncall(serviceid, "getCreateguid", null);
    	var newdata = {};
    	newdata.guid = newguid;
    	datatable.getRecordSet().addData(newdata, 100);
    });
    
    /**
     * 表格删除行
     */
    Ext.lt.message.hook("delRow", "uidatatable", function(editdatatable){
    	var selDatas = datatable.getSelected();
    	if(selDatas.size() <= 0){
    		Ext.lt.ui.alert('请选择要删除的数据！', function(){});
    		return;
    	}
    	Ext.lt.ui.confirm('是否删除已选择的数据!', null, function(is){
    		if(is){
    			datatable.removeData(selDatas);
    		}
    	});
    });
    
    return cmp;
}