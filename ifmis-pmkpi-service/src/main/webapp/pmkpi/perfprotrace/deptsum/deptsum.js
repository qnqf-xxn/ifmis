if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.deptsum){
    Ext.lt.pmkpi.deptsum = {};
}

Ext.lt.pmkpi.deptsum.index = function(config, service){
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
        Ext.lt.pmkpi.query(true);
    })

    function _setFrame(obj){
        obj.setAttribute('frameBorder', 0);
        obj.style.cssText = 'border: 0 none;';
        obj.style.width = 200;
        obj.style.height = 55;
    }

    Ext.lt.pmkpi.query = function(isquery){
        Ext.lt.ui.loadingShow();
        var params = {};
        params.tablecode = _tablecode;
        params.tablesql = _defquery;
        params.proguid = _proguid;
        params.mainguid = _mainguid;
        params.bustype = _bustype;
        params.taskguid = _taskguid;
        params.agency = _saveAgency;
        params.queryYear = _queryYear;
        params.queryProvince = _queryProvince;
        Ext.lt.RCP.call(service , "getDatas", params, function(rt){
            if (rt) {
                if (_viewtype == "query") {
                    perfcommon.editSetdisabled(goaleditform);
                }
                datatablevol.setDatas(rt.datatablevol);
                datatableear.setDatas(rt.datatableear);
                datatablekey.setDatas(rt.datatablekey);
                editfrommea.synchEditformByObj(rt.editfrommea);
            }
            if (isquery) {
                setTimeout(function(){
                    parent._isQuery = true;
                },500);
            }
            Ext.lt.ui.loadingClose();
        },function(){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('查询失败！',function(){
            });
        });
    }

    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        _defquery = uiconfig.defquery;
        _orderby = uiconfig.orderby;
        _tablecode = uiconfig.tablecode;
    });

    cmp.save = function(){
        if (!editfrommea.check()) return false;//先校验
        var yes = $("#yes").val();
        var no = $("#no").val();
        var isexpfunc;
        if (yes == "1") {
            isexpfunc = "yes"
        } else if (no == "1") {
            isexpfunc = "no"
        }
        var params = {};
        params.datatablevol = datatablevol.getRecordSet().toArray();
        params.datatableear = datatableear.getRecordSet().toArray();
        params.datatablekey = datatablekey.getRecordSet().toArray();
        params.editfrommea = editfrommea.getEditFormValues();
        params.tablecode = _tablecode;
        params.busguid = _busguid;
        params.mainguid = _mainguid;
        params.saveAgency = _saveAgency;
        params.taskguid = _taskguid;
        params.proguid = _proguid;
        params.bustype = _bustype;
        params.isexpfunc = isexpfunc;//是否达到预计支出进度
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(service , "save", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
            Ext.lt.pmkpi.query();
        }
        return rs;
    }

    return cmp;
}