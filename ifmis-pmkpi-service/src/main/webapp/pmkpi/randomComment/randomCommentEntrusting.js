if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}

if(!Ext.lt.pmkpi.randomComment){
    Ext.lt.pmkpi.randomComment = {};
}

Ext.lt.pmkpi.randomComment.entrustingIndex = function(config, service){
    var deptcmp = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var _workflow = config.workflow,
        _menuid = config.menuid,
        _agency,
        _prokind,
        _tabcode = config.tablecode,
        _tabcode,
        _tabfilter,
        _tablecode,
		_name,
        _pagetype,
        _uikey,
        _defquery,
        _orderby,
        _deltables,
        _delcols,
        _bustype,
        guids = config.guids,
        scrWidth =document.body.clientWidth,
        scrHeight =document.body.clientHeight;
    var agencydata;

    var serviceid = service;
    $(function () {
        cmp.query();
    })
    
    //查询
    cmp.query = function (obj){
        Ext.lt.pmkpi.query();
    }

    Ext.lt.pmkpi.query = function(){
        var params = {};
        params.agency = _agency;
//        params.prokind = _prokind;
        params.isleaf = Ext.lt.pmkpi.isleaf + "";
        params.menuid = _menuid;
        params.workflow = _workflow;
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.tablecode = _tablecode;
        params.pagetype = _pagetype;
        params.tabfilter = _tabfilter;
        params.tablesql = _defquery;
        params.orderby = _orderby;
        params.tabcode = _tabcode;
        params.bustype = _bustype;
        params.beanid = "pmkpi.randomcomment.RandomCommentEntrustingBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params,function(){
            Ext.lt.ui.loadingClose();
        });
        /*Ext.lt.RCP.call(serviceid , "getDatas", params, function(rs){
            datatable.setDatas(rs.data);
            if (rs && rs.data && rs.data.length == 1) {
                agencydata = rs.data[0];
            } else {
                agencydata = [];
            }
            Ext.lt.ui.loadingClose();
        },function(){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('查询失败！',function(){
            });
        });*/
    }
    Ext.lt.message.hook("queryform", "doquery",function(obj){
        Ext.lt.pmkpi.query();
    });
    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        var config = obj.table.config;
        //_tabcode = config.tabcode;
        _tablecode = uiconfig.tablecode;
        _defquery = uiconfig.defquery;
        _orderby = uiconfig.orderby;
        _pagetype = config.pagetype;
        _uikey = config.uikey;
        _bustype = config.bustype;
        _deltables = config.deltables;
        _delcols = config.delcols;
        var cols = obj.cols;
        if(!Ext.lt.isArray(cols))
            cols = [cols];
        for(var i=0; i<cols.length; i++){
            var col = cols[i];
        }
    });
    
    
    cmp.submit = function (obj){
    	debugger;
        var datas = datatable.getSelected();
        if (datas.length <= 0) {
            Ext.lt.ui.alert("请选择一条机构信息！",function(){});
            return;
        }
        if (datas.length > 1) {
            Ext.lt.ui.alert("最多选择一条机构信息！",function(){});
            return;
        }
		var config = {};
		config.datas = datas;
		config.tablecode = _tabcode;
		config.guids = guids;
		config = Ext.lt.RCP.asyncall(serviceid , "submit", config);
		if(config.error){
			Ext.lt.ui.alert(config.error);
		}else{
			Ext.lt.ui.alert("保存成功!",{icon:"sucess",timeout:2},function(){
				Ext.lt.ui.closeModalWindow();
		        parent.Ext.lt.pmkpi.query();
			});
		}
    }


    //页签方法
    cmp.clickTabpage = function(obj){
        changToolbuttonStatus(toolbutton, parseInt(obj.ordernum), obj.hidebtns);
        _tabfilter = obj.filter;
        var config = obj.config;
        var tabconfig = eval('(' + config + ')');
        _ctablecode = tabconfig.tablecode;
        Ext.lt.pmkpi.query();
    }
    return cmp;
}

//左侧树切换页签事件
function tabChange(index, cfg){
	_selectedtree= index.code;
}