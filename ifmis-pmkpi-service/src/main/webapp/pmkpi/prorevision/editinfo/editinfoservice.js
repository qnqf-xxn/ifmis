if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.prorevision){
    Ext.lt.pmkpi.prorevision = {};
}

Ext.lt.pmkpi.prorevision.editinfoservice = function(config, service){
    window.parent.Ext.lt.pmkpi.childwindow = window;
    var deptcmp = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var serviceid = service;
    var _mainguid = config.mainguid,
        _proguid = config.proguid,//项目guid
        _prolev = config.prolev,//项目级次
        _workflow = config.workflow,//工作流guid
        _viewtype = config.viewtype,//区分是否查询:query是查询，其他可修改
        _procode = config.procode,//项目编码
        _busguid = config.busguid;//审核定义guid
    //根据组件id存放表名
    Ext.lt.pmkpi.isadd = false;
    /**
     * 基础信息保存
     */
    cmp.save = function (obj) {
        var params = {};
        params.mainguid = _mainguid;
        params.infodata = editform.getEditFormValues();
        params.busguid = _busguid;
        params.workflow = _workflow;
        var rs = Ext.lt.RCP.asyncall(serviceid , "save", params);
        return rs;
    }

    cmp.clickTabpage = function(obj) {
        // if (_viewtype != "query") {
        deptcmp.tabpageOnclick(obj, _tabData, toolbutton);
        var config = eval('(' + obj.config + ')');
        if (config.mainguid) {
            _mainguid = config.mainguid;
        }
    }
    Ext.lt.message.hook("perfcommon", "iframeinit",function(obj){
        var params = obj.params;
        params.mainguid = _mainguid;
        params.viewtype = _viewtype;
        params.workflow = _workflow;
        params.prolev = _prolev;
    });

    /**
     * 页面初始化加载，查看的话不显示按钮
     */
    $(function(){
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        deptcmp.initEditForm();
        var tablecode = infoeditform.cfg.tablecode;
        var params = {};
        params.proguid = _proguid;
        params.prolev = _prolev;
        params.tablecode = tablecode;
        params.procode = _procode;
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
            parent._isQuery = true;
        },function(){
        });
    });
    return cmp;
}