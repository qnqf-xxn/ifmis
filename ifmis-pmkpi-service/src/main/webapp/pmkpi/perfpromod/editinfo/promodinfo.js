if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.promod){
    Ext.lt.pmkpi.promod = {};
}

Ext.lt.pmkpi.promod.modeditinfo = function(config, service){
    window.parent.Ext.lt.pmkpi.childwindow = window;
    var cmp = {};
    var serviceid = service;
    var _mainguid = config.mainguid,
        _programinfo = config.programinfo;
        _proguid = config.proguid,//项目guid
        _prolev = config.prolev,//项目级次
        _workflow = config.workflow,//工作流guid
        _viewtype = config.viewtype,//区分是否查询:query是查询，其他可修改
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


    /**
     * 页面初始化加载，查看的话不显示按钮
     */
    $(function(){
        if(_viewtype == 'query'){
            var cols = editform.cfg.data;
            var c = {};
            for (var i=0; i<cols.length; i++) {
                c[cols[i].colcode.toLowerCase()] = true;
            }
            editform.setdisabled(c);//设置基本信息不可编辑
        }
        editform.synchEditformByObj(_programinfo);
    });
    return cmp;
}