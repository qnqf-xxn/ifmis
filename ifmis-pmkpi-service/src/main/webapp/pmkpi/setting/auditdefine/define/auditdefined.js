if(!Ext.lt.pmkpi) 
	Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.auditdefine)
	Ext.lt.pmkpi.auditdefine = {};
var scrWidth=document.body.clientWidth;
var scrHeight=document.body.clientHeight;
var windowx;
Ext.lt.pmkpi.auditdefine = function(config, service){
	var cmp = {};
	var _tabcode;//页签编码
	Ext.lt.pmkpi.auditdefine.tokenid = Ext.lt.token.getTokenid();
	Ext.lt.pmkpi.auditdefine.bobeanid = config.bobeanid;
	serviceid = config.serverid;
	cmp.queryform = queryform;
	
	cmp.draw = function() {
		cmp.query();
	}
    $(function () {
		Ext.lt.pmkpi.query();
    })

	//查询
	cmp.query = function (){
		Ext.lt.pmkpi.query();
	}

	Ext.lt.pmkpi.query = function(){
		var params = {};
		params.queryConfig = queryform.getQueryParam();
		params.querySql = queryform.getQuerySQL();
		params.auditdetype = _tabcode;
		Ext.lt.ui.loadingShow();
		Ext.lt.RCP.call(serviceid , "getData", params, function(rs){
			datatable.setDatas(rs.data);
			Ext.lt.ui.loadingClose();
		},function() {
			Ext.lt.ui.loadingClose();
			Ext.lt.ui.alert('查询失败！',function(){
			});
		});

	}

	cmp.toAdd = function(){
        var params = {};
        if (_tabcode == "singletable"){//视图
			var url = '/pmkpi/auditdefine/viewedit.page';
		}else if(_tabcode == "procedure"){ //存储过程
			var url = '/pmkpi/auditdefine/edit.page';
		}else if(_tabcode == "auditbeanid"){//auditbeanid
			var url = '/pmkpi/auditdefine/editbeanid.page';
		}
		params.tabcode = _tabcode;
		url = Ext.lt.pmkpi.genPageUrl(url, params);
		Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"审核属性");
	}
	
	cmp.toEdit = function (){
   	 var params = {};
		var data = datatable.getSelected();
		if(data.size()==1){
			var guid=data[0].guid;
			params.guid=guid;
	        if (_tabcode == "singletable"){//视图
				var url = '/pmkpi/auditdefine/viewedit.page';
			}else if(_tabcode == "procedure"){ //存储过程
				var url = '/pmkpi/auditdefine/edit.page';
			}else if(_tabcode == "auditbeanid"){//auditbeanid
				var url = '/pmkpi/auditdefine/editbeanid.page';
			}
			params.tabcode = _tabcode;
			url = Ext.lt.pmkpi.genPageUrl(url, params);
			Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"审核属性");
		} else if(data.size() > 1) {
			Ext.lt.ui.alert('每次只能修改一条数据！');
		} else {
			Ext.lt.ui.alert('请选择要修改的数据！');
		}
	}
    
	cmp.del = function (){
		var size = datatable.getRecordSet().size();
		if(size>0){
			var selecteds = datatable.getSelected().size();
			if (selecteds <= 0) {
				Ext.lt.ui.alert('请选择要删除的数据！');
				return;
			}
			Ext.lt.ui.confirm('是否删除已选择审核定义信息？',null,function(is){
				if(is){
					var data = datatable.getSelected();
					var config = {};
					if (data.size() <= 0) {
						Ext.lt.ui.alert('请选择要删除的数据！',function(){
						});
						return;
					}
					config.deldatas = data;
					config = Ext.lt.RCP.asyncall(serviceid , "deldatas", config);
					if(config.error){
						Ext.lt.ui.alert(config.error);
					}
					cmp.query();
				}
			});
		}else{
			Ext.lt.ui.alert('页面无数据！');
			return ;
		}
	}
	
    //页签方法
    cmp.clickTabpage = function(obj){
        changToolbuttonStatus(toolbutton, parseInt(obj.ordernum), obj.hidebtns);
        _tabfilter = obj.filter;
        _tabcode = obj.code;
        cmp.query();
    }
    
	return cmp;
}



$(window).resize(function () {          //当浏览器大小变化时
	var scrWidth=document.body.clientWidth;
    var scrHeight=document.body.clientHeight;
	if(windowx){windowx.resize(scrWidth, scrHeight);}
});

