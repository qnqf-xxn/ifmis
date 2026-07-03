if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}

if(!Ext.lt.pmkpi.deptperformance){
    Ext.lt.pmkpi.deptperformance = {};
}

Ext.lt.pmkpi.deptperformance.depterportservice = function(config, service){
    var deptcmp = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var _workflow = config.workflow,
        _menuid = config.menuid,
        _agency,
        _tablecode,
        _tabfilter,
        _tabcode,
		_name,
        _pagetype,
        _uikey,
        _defquery,
        _orderby,
        _deltables,
        _delcols,
        scrWidth =document.body.clientWidth,
        scrHeight =document.body.clientHeight;
    var agencydata;

    var serviceid = service;
    //查询
    cmp.query = function (obj){
        Ext.lt.pmkpi.query();
    }

    Ext.lt.pmkpi.query = function(){
        if(!_agency){
            _agency = "treeroot";
            Ext.lt.pmkpi.isleaf = 0;
        }
        Ext.lt.ui.loadingShow();
        var params = {};
        params.agency = _agency;
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
        Ext.lt.RCP.call(serviceid , "getDatas", params, function(rs){
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
        });
    }

    Ext.lt.message.hook("left", "click",function(obj){
        var treeNode = obj.node.data;
        if(treeNode){
            _agency = treeNode.guid;
            _name=treeNode.name;
            Ext.lt.pmkpi.isleaf = treeNode.isleaf;
        } else {
            _agency = "treeroot";
            Ext.lt.pmkpi.isleaf = '0';
        }
        cmp.query();
    });
    Ext.lt.message.hook("perfcommon", "auditquery",function(){
        Ext.lt.pmkpi.query();
    });

    Ext.lt.message.hook("perfcommon", "tablequery",function(){
        Ext.lt.pmkpi.query();
    });
    Ext.lt.message.hook("queryform", "doquery",function(obj){
        cmp.query();
    });

    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        var config = obj.table.config;
        _tablecode = uiconfig.tablecode;
        _defquery = uiconfig.defquery;
        _orderby = uiconfig.orderby;
        _pagetype = config.pagetype;
        _uikey = config.uikey;
        _deltables = config.deltables;
        _delcols = config.delcols;
        var cols = obj.cols;
        if(!Ext.lt.isArray(cols))
            cols = [cols];
        for(var i=0; i<cols.length; i++){
            var col = cols[i];
            if(col["colcode"] == "name"){
                col.fn = function(l,c,data,col){
                    return "<a herf='#' style='color:#468ac9'>" + data.name + "</a>";
                }
                col.onclick = function(td, el, l, c, d) {
                    var url = _uikey + ".page";
                    var params = {};
                    params.pagetype = "editreport";
                    params.mainguid = d.guid;
                    params.agency = d.agencyguid;
                    params.flg = "query";
                    params.workflow = _workflow;
                    url = Ext.lt.pmkpi.genPageUrl(url, params);
                    Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"部门绩效目标申报");
                };
            }
        }
    });

    /**
     * 填报/修改
     */
    cmp.save = function (obj){
//        var config = obj.config;
        var data = datatable.getSelected();
        if(config.agencyflag == 'PMKPIAGENCYALLPAY'){
	        if(data.length != 1 && (!_agency || Ext.lt.pmkpi.isleaf != "1")){
	             Ext.lt.ui.alert("请选择左侧末级单位或选中一条数据进行填报/修改！",function(){});
	             return;
	        }
        } else if(config.agencyflag == 'PMKPIAGENCY'){
            if(_agency == "treeroot" && data.length != 1){
                Ext.lt.ui.alert("请选择左侧部门或选中一条数据进行填报/修改！",function(){});
                return;
            }
        }
        var params = {};
        params.pagetype = "editreport";
        params.workflow = _workflow;
        var url = _uikey + ".page";
		if (data.length == 1) {
		    params.agency = data[0].agencyguid;
            params.mainguid = data[0].guid;
		} else {
		    if (agencydata && agencydata.guid && agencydata.guid != "") {
                params.mainguid = agencydata.guid;
            } else {
                var newguid = Ext.lt.RCP.asyncall(serviceid , "getCreateguid", null);
                params.mainguid = newguid;
            }
            params.agency = _agency;
        }
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"部门绩效目标申报");
    }

    /**
     * 删除
     */
    cmp.del = function() {
        var params = {};
        params.workflow = _workflow;
        params.tablecode = _tablecode;
        params.pagetype = _pagetype;
        params.deltables = _deltables;
        params.delcols = _delcols;
        deptcmp.deltable(datatable, params);
    }

    //送审/审核
    cmp.wfAudit = function (obj){
        var datas = datatable.getSelected();
        if (datas.length <= 0) {
            Ext.lt.ui.alert("请选择要" + obj.name + "的数据！",function(){});
            return;
        }
        if (!deptcmp.checkwfstatus(datas)) return false;//先校验审核状态是否一致
        var params = {};
        params.datas = datas;
        params.tablecode = _tablecode;
        params.workflow = _workflow;
        deptcmp.doAction(obj, params);
    }
    //送审情况
    cmp.queryaudit = function (){
        deptcmp.auditquery(datatable);
    }

    //页签方法
    cmp.clickTabpage = function(obj){
        changToolbuttonStatus(toolbutton, parseInt(obj.ordernum), obj.hidebtns);
        _tabfilter = obj.filter;
        _tabcode = obj.code;
        Ext.lt.pmkpi.query();
    }

    return cmp;
}

