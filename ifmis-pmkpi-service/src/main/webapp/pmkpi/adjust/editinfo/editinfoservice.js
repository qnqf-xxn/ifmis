if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.adjust){
    Ext.lt.pmkpi.adjust = {};
}

Ext.lt.pmkpi.adjust.editinfoservice = function(config, service){
    window.parent.Ext.lt.pmkpi.childwindow = window;
    var cmp = {};
    var serviceid = service;
    var _mainguid = config.mainguid,
        _proguid = config.proguid,//项目guid
        _prolev = config.prolev,//项目级次
        _procode = config.procode,//项目编码
        _bustype = config.bustype,//业务类型
        _workflow = config.workflow,//工作流guid
        _viewtype = config.viewtype,//区分是否查询:query是查询，其他可修改
        _queryYear = config.queryYear,//跨年查询查询年度
        _queryProvince = config.queryProvince,//跨年查询查询区划
        _busguid = config.busguid;//审核定义guid
    //根据组件id存放表名
    Ext.lt.pmkpi.isadd = false;
    /**
     * 基础信息保存
     */
    cmp.save = function (obj) {
        if (!editform.check()) return;//先校验
        var params = {};
        params.mainguid = _mainguid;
        params.infodata = editform.getEditFormValues();
        params.busguid = _busguid;
        params.procode = _procode;
        params.bustype = _bustype;
        var rs = Ext.lt.RCP.asyncall(serviceid , "save", params);
        return rs;
    }


    /**
     * 页面初始化加载，查看的话不显示按钮
     */
    $(function(){
        var tablecode = infoeditform.cfg.tablecode;
        var params = {};
        params.proguid = _proguid;
        params.prolev = _prolev;
        params.tablecode = tablecode;
        params.procode = _procode;
        params.bustype = _bustype;
        params.queryYear = _queryYear;//跨年查询查询年度
        params.queryProvince = _queryProvince;//跨年查询查询区划
        var editdata = Ext.lt.RCP.asyncall(serviceid , "getEditInfo", params);
        var cols = infoeditform.cfg.data;
        var c = {};
        for (var i=0; i<cols.length; i++) {
            c[cols[i].colcode.toLowerCase()] = true;
        }
        infoeditform.setdisabled(c);//设置基本信息不可编辑
        infoeditform.synchEditformByObj(editdata);
        params.mainguid = _mainguid;
        Ext.lt.RCP.call(serviceid , "getMaininfo", params, function(data){
            data.guid = _mainguid;
            data.proguid = _proguid;
            editform.synchEditformByObj(data);
            if ("query" == _viewtype){
                var cols = editform.cfg.data;
                var c = {};
                for (var i=0; i<cols.length; i++) {
                    c[cols[i].colcode.toLowerCase()] = true;
                }
                editform.setdisabled(c);//设置基本信息不可编辑
            }
            parent._isQuery = true;
        },function(){
        });
    });
    return cmp;
}