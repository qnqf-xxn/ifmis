if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.protrace){
    Ext.lt.pmkpi.protrace = {};
}

Ext.lt.pmkpi.protrace.extend = function(config, service){
    var perfcommon = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};

    var _menuid = config.menuid,//菜单id
        _proguid = config.proguid,//项目guid
        _mainguid = config.mainguid,//主单guid
        _bustype = config.bustype,//任务类型
        _taskguid = config.taskguid,//任务guid
        _busguid = config.busguid,//审核定义guid
        _saveAgency = config.saveAgency,//单位guid
        _viewtype = config.viewtype,
        _queryYear = config.queryYear,//跨年查询查询年度
        _queryProvince = config.queryProvince,//跨年查询查询区划
        _defquery,//列表查询条件
        _orderby,//排序
        _tablecode;//表名

    $(function (){
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        perfcommon.initDatatable();
        Ext.lt.pmkpi.query(true);
    })


    Ext.lt.pmkpi.query = function(isquery){
        Ext.lt.ui.loadingShow();
        var params = {};
        params.tablecode = _tablecode;
        params.tablesql = _defquery;
        params.mainguid = _mainguid;
        params.compconfigid = "datatable";
        params.url = datatable.config.pageurl;
        params.viewtype = _viewtype;
        params.queryYear = _queryYear;
        params.queryProvince = _queryProvince;
        Ext.lt.RCP.call(service , "getDatas", params, function(rs){
            datatable.setDatas(rs.data);
            setMidSaveHidButtons(rs);
            Ext.lt.ui.loadingClose();
            if (isquery) {
                setTimeout(function(){
                    parent._isQuery = true;
                },500);
            }
        },function(){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('查询失败！',function(){
            });
        });
    }


    /**
     * 新增行.
     */
    Ext.lt.message.hook("addRow", "uidatatable", function(){
        var newguid = Ext.lt.RCP.asyncall(service , "getCreateguid", null);
        var newdata ={};
        newdata.guid = newguid;
        newdata.isedit = '1';
        newdata.rowtype = "add";
        datatable.getRecordSet().addData(newdata,999);
    });
    /**
     * 刪除行
     */
    Ext.lt.message.hook("delRow", "uidatatable", function() {
        var selDatas = datatable.getSelected();
        if (selDatas.size() <= 0) {
            Ext.lt.ui.alert('请选择要删除的数据！',function(){
            });
            return;
        }
        Ext.lt.ui.confirm('是否删除已选择数据？',{icon: "warn"},function(is){
            if(is){
                datatable.removeData(selDatas);
            }
        })
    })


    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        _defquery = uiconfig.defquery;
        _orderby = uiconfig.orderby;
        _tablecode = uiconfig.tablecode;
    });

    cmp.save = function(){
        if (!datatable.checkAll()) return false;//先校验
        var params = {};
        Ext.lt.ui.loadingShow();
        var datas = datatable.getRecordSet().toArray();
        if(!datas || datas.length == 0) {
            params.success = true;
            Ext.lt.ui.loadingClose();
            return params;
        }
        params.datas = datas;
        params.updatas = datatable.getUpdataData();
        params.deldatas = datatable.getRemoveData();
        params.mainguid = _mainguid;
        params.tablecode = _tablecode;
        params.url = datatable.config.pageurl;
        params.viewtype = _viewtype;
        var rs = Ext.lt.RCP.asyncall(service, "save", params);
        Ext.lt.ui.loadingClose();
        Ext.lt.pmkpi.query();
        return rs;
    }

    /**
     * 暂存
     */
    cmp.savetmp = function (obj){
        var params = {};
        params.data = datatable.getRecordSet().toArray();
        var datas = datatable.getRecordSet().toArray();
        if(!datas || datas.length == 0) {
            params.success = true;
            return params;
        }
        params.url = datatable.config.pageurl;
        params.mainguid = _mainguid;
        params.componentid = datatable.config.server;
        params.compconfigid = "datatable";
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(service , "midsave", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
            Ext.lt.pmkpi.query();
        }
        return rs;
    }

    /**
     * 清除暂存
     */
    cmp.savetmpdel = function (obj){
        var params = {};
        params.url = datatable.config.pageurl;
        params.mainguid = _mainguid;
        params.componentid = datatable.config.server;
        params.compconfigid = "datatable";
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(service , "midsavedel", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
            cmp.query();
        }
        return rs;
    }

    return cmp;
}