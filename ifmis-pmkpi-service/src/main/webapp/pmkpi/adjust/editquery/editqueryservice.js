if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.adjust){
    Ext.lt.pmkpi.adjust = {};
}

Ext.lt.pmkpi.adjust.editqueryservice = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};

    var _menuid = config.menuid,//菜单id
        _proguid = config.proguid,//项目guid
        _mainguid = config.mainguid,//
        _saveAgency = config.saveAgency,
        _viewtype = config.viewtype,
        _defquery,//列表查询条件
        _orderby,//排序
        _tablecode;//表名

    $(function (){
        $(function () {
            //组件配置，service不放到第一位时，组件初始化消息不走问题
            common.initDatatable();
            if (_viewtype == "query") {
                if(document.getElementById("add"))
                    document.getElementById("add").style.display = "none";
                if(document.getElementById("del"))
                    document.getElementById("del").style.display = "none";
            }
            Ext.lt.pmkpi.query(true);
        })
    })

    Ext.lt.pmkpi.query = function(isquery){
        Ext.lt.ui.loadingShow();
        var params = {};
        params.tablecode = _tablecode;
        params.tablesql = _defquery;
        params.proguid = _proguid;
        params.mainguid = _mainguid;
        //params.beanid = "pmkpi.perfprotrace.depttask.DeptTaskBOTX";
        params.beanid = "pmkpi.adjust.editquery.EditQueryBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params,function(){
            Ext.lt.ui.loadingClose();
            if (isquery) {
                parent._isQuery = true;
            }
        });
    }


    cmp.save = function () {
        var params = {};
        params.datas = datatable.getRecordSet().toArray();
        params.updatas = datatable.getUpdataData();
        params.deldatas = datatable.getRemoveData();
        params.tablecode = _tablecode;
        params.proguid = _proguid;
        params.mainguid = _mainguid;
        params.saveAgency = _saveAgency;
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(service, "save", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
            Ext.lt.pmkpi.query();
        }
        return rs;
    }


    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        _defquery = uiconfig.defquery;
        _orderby = uiconfig.orderby;
        _tablecode = uiconfig.tablecode;
        var cols = obj.cols;
        if(!Ext.lt.isArray(cols))
            cols = [cols];
        for(var i=0; i<cols.length; i++){
            var col = cols[i];
            if(_viewtype == 'query' && col["name"] != "check"){
                col.style = "background-color:#f2f2f2;";
                col.oneditstart = function(table, e, l, c, d){
                    return false;
                }
            }
        }
    });

    /**
     * 新增行.
     */
    Ext.lt.message.hook("addRow", "uidatatable", function(){
        var newguid = Ext.lt.RCP.asyncall(service , "getCreateguid", null);
        var newdata ={};
        newdata.guid = newguid;
        newdata.add = '1';
        datatable.getRecordSet().addData(newdata,999);
        //amtTotal(datatable);
    });
    /**
     * 刪除行
     */
    Ext.lt.message.hook("delRow", "uidatatable", function() {
        var selDatas = datatable.getSelected();
        if (selDatas.size() <= 0) {
            Ext.lt.ui.alert('请选择要删除的数据！', function () {
            });
            return;
        }
        datatable.removeData(selDatas);
        //amtTotal(datatable);
    });

    return cmp;
}