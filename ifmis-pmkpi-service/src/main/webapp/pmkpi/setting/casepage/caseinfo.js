if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.case){
    Ext.lt.pmkpi.case = {};
}

Ext.lt.pmkpi.case.infoservice = function(config, service){
    var perfcommon = Ext.lt.pmkpi.perfcommon(config, service);
    window.parent.Ext.lt.pmkpi.childwindow = window;
    var cmp = {};
    var serviceid = service;
    var _mainguid = config.mainguid,
        _workflow = config.workflow,//工作流guid
        _viewtype = config.viewtype,//区分是否查询:query是查询，其他可修改
        _bustype = config.bustype,
        _casetype = config.casetype,
        _tablecode,
        _saveAgency = config.saveAgency,//单位
        _finintorgguid = config.finintorgguid,//处室
        _busguid = config.busguid;//审核定义guid
    //根据组件id存放表名
    Ext.lt.pmkpi.isadd = false;
    /**
     * 基础信息保存
     */
    cmp.save = function (obj){
        if (!editform.check()) return false;
        var params = {};
        params.mainguid = _mainguid;
        params.infodata = editform.getEditFormValues();
        params.busguid = _busguid;
        params.bustype = _bustype;
        params.workflow = _workflow;
        params.tablecode = _tablecode;
        params.tablecode = _tablecode;
        params.finintorgguid = _finintorgguid;
        params.saveAgency = _saveAgency;
        params.casetype = _casetype;
        var rs = Ext.lt.RCP.asyncall(serviceid , "save", params);
        if (rs && rs.success){
            cmp.query();
        }
        return rs;
    }

    cmp.query = function (isquery){
        var params = {};
        params.tablecode = _tablecode;
        params.bustype = _bustype;
        params.mainguid = _mainguid;
        Ext.lt.RCP.call(serviceid , "getMaininfo", params, function(data){
            editform.synchEditformByObj(data);
            if (isquery) {
                parent._isQuery = true;
            }
        },function(){
        });
    }

    /**
     * 页面初始化加载，查看的话不显示按钮
     */
    $(function(){
        if (_viewtype == "query") {
            perfcommon.editSetdisabled(editform);
        }
        _tablecode = editform.cfg.tablecode;
        cmp.query(true);
    });
    return cmp;
}