if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.confirmdeptedit){
    Ext.lt.pmkpi.confirmdeptedit = {};
}
Ext.lt.pmkpi.confirmdeptedit = function(config, service){
    var perfcommon = Ext.lt.pmkpi.perfcommon(config, service);
    window.parent.Ext.lt.pmkpi.childwindow = window;
    var cmp = {};
    var serviceid = service;
    var _mainguid = config.mainguid,
        _workflow = config.workflow,//工作流guid
        _viewtype = config.viewtype,//区分是否查询:query是查询，其他可修改
        _bustype = config.bustype,
        _busguid = config.busguid,//审核定义guid
        _iswf = config.iswf,
        _tablecode = config.tablecode;

    //根据组件id存放表名
    Ext.lt.pmkpi.isadd = false;
    /**
     *
     * 基础信息保存
     */
    cmp.save = function (obj) {
        if (!infoeditform.check()) return false; //编辑区必填校验
        var params = {};
        params.mainguid = _mainguid;
        params.infodata = infoeditform.getEditFormValues();
        params.busguid = _busguid;
        params.workflow = _workflow;
        params.tablecode = _tablecode;
        params.bustype = _bustype;
        params.iswf = _iswf;
        var rs = Ext.lt.RCP.asyncall(serviceid , "save", params);
        return rs;
    }


    /**
     * 页面初始化加载，查看的话不显示按钮
     */
    $(function(){
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        perfcommon.initEditForm();
        _tablecode = infoeditform.cfg.tablecode;
        _iswf = infoeditform.cfg.iswf;
        var params = {};
        params.mainguid = _mainguid;
        params.tablecode = _tablecode;
        params.bustype = _bustype;
        params.iswf = _iswf;
        var editdata = Ext.lt.RCP.asyncall(serviceid , "getdeptData", params);
        if (_viewtype == "query") {
            perfcommon.editSetdisabled(infoeditform);
        }if (editdata  != null){
            infoeditform.synchEditformByObj(editdata);
        }
        parent._isQuery = true;
    });
    return cmp;
}