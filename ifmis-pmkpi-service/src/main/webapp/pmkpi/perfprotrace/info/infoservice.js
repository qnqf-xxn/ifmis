if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.protrace){
    Ext.lt.pmkpi.protrace = {};
}

Ext.lt.pmkpi.protrace.infoservice = function(config, service){
    var perfcommon = Ext.lt.pmkpi.perfcommon(config, service);
    window.parent.Ext.lt.pmkpi.childwindow = window;
    var cmp = {};
    var serviceid = service;
    var _mainguid = config.mainguid,
        _prolev = config.prolev,//项目级次
        _workflow = config.workflow,//工作流guid
        _viewtype = config.viewtype,//区分是否查询:query是查询，其他可修改
        _traceInfo = config.traceInfo,//监控数据
        _infoMap = config.infoMap,//项目基本信息
        _busguid = config.busguid;//审核定义guid
    //根据组件id存放表名
    Ext.lt.pmkpi.isadd = false;
    /**
     * 基础信息保存
     */
    cmp.save = function (obj){
        if (!traceeditform.check()) return false;
        var params = {};
        params.mainguid = _mainguid;
        params.infodata = traceeditform.getEditFormValues();
        params.editdata = infoeditform.getEditFormValues();
        params.busguid = _busguid;
        params.workflow = _workflow;
        var rs = Ext.lt.RCP.asyncall(serviceid , "save", params);
        return rs;
    }

    /**
     * 页面初始化加载，查看的话不显示按钮
     */
    $(function(){
        setMidSaveHidButtons({hidButtons:"暂存"});
        parent._issavetmp = false;
        editSetdisabled(infoeditform);
        if (_viewtype == "query") {
            perfcommon.editSetdisabled(infoeditform);
            perfcommon.editSetdisabled(traceeditform);
        }
        infoeditform.synchEditformByObj(_infoMap);
        if (_traceInfo) {
            traceeditform.synchEditformByObj(_traceInfo);
        }
        parent._isQuery = true;
    });
    return cmp;
}
/**
 * 设置编辑区不可编辑
 */
function editSetdisabled(editfrom){
    var cols = editfrom.cfg.data;
    var c = {};
    for (var i=0; i<cols.length; i++) {
        //广西新增 填报人和填报人联系方式 字段要求可编辑
        if(cols[i].colcode == "FillMAN" || cols[i].colcode == "FillCONTACTTYPE"){
            c[cols[i].colcode.toLowerCase()] = false;
        }else{
            c[cols[i].colcode.toLowerCase()] = true;

        }
    }
    editfrom.setdisabled(c);//设置基本信息不可编辑
}