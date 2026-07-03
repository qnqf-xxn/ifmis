if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.auditviewinfo)
    Ext.lt.pmkpi.auditviewinfo = {};

Ext.lt.pmkpi.auditviewinfo = function(config, service){
	
    var cmp = {};
    Ext.lt.pmkpi.auditviewinfo.tokenid = Ext.lt.token.getTokenid();
	Ext.lt.pmkpi.auditviewinfo.bobeanid = config.bobeanid;
	var scrWidth=document.body.clientWidth;
    var scrHeight=document.body.clientHeight;
    var serviceid = service;

	cmp.queryform = queryform;

	cmp.draw = function() {
		cmp.query();
	}
    $(function () {
        cmp.tablequery();
    })

	Ext.lt.message.hook("queryform", "doquery",function(obj){
		cmp.tablequery();
	});

    /**
     * 查询
     */
    cmp.tablequery = function(){
        var params = {};
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        Ext.lt.ui.loadingShow();
        //debugger;
        Ext.lt.RCP.call(serviceid , "getDatas", params, function(rs){
            datatable.setDatas(rs.data);
            Ext.lt.ui.loadingClose();
        },function() {
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('查询失败！',function(){
            });
        });
    }
    //新增
    cmp.addtable= function(){
    	
			
    	        var params = {};
				var url = '/pmkpi/editaudiview/edit.page';
				url = Ext.lt.pmkpi.genPageUrl(url, params);
				Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"视图登记");

    }
    
    //编辑
    
    cmp.edittable=function(){
    	 var params = {};
    	var data = datatable.getSelected();	
	    if(data.size()==1){
	    	var guid=data[0].guid;
	    	
		params.guid=data[0].guid;
		
		var url = "/pmkpi/editaudiview/edit.page";
    	url = Ext.lt.pmkpi.genPageUrl(url, params);
		Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"视图登记");
	   }
	    else{
		//Ext.lt.ui.alert('请选择一条数据！');
	    Ext.lt.ui.alert('请选择一条数据！',function(){});
	   }
    }
    
    
    cmp.deletable=function(){

		var size = datatable.getRecordSet().size();
		if(size>0){
			var selecteds = datatable.getSelected().size();
			if (selecteds <= 0) {
				//Ext.lt.ui.alert('请选择要删除的数据！');
				Ext.lt.ui.alert('请选择要删除的数据！',function(){
				});
				return;
			}
			Ext.lt.ui.confirm('是否删除已选择的视图信息？',null,function(is){
				if(is){
					var data = datatable.getSelected();
					var config = {};
					if (data.size() <= 0) {
						Ext.lt.ui.alert('请选择要删除的数据！',function(){
						});
						return;
					}
					config.list = data;
					config = Ext.lt.RCP.asyncall(serviceid , "delDatas", config);
					if(config.error){
						Ext.lt.ui.alert(config.error);
					}
					cmp.tablequery();	
				}
			});
		}else{
			Ext.lt.ui.alert('页面无数据！');
			return ;
		}
    }

    return cmp;
    
}

