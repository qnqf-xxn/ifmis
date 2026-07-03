if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.randomProblemEdit){
    Ext.lt.pmkpi.randomProblemEdit = {};
}

Ext.lt.pmkpi.randomProblemEdit = function(config, service){
    var serviceid = service,
        _projguid = config.projguid,
        _mainguid = config.mainguid,
        _procode = config.procode,
        _tablecode = config.tablecode,//表名
        _defquery,//表配置过滤条件
        _orderby,//表排序sql
        _busguid,//审核定义
        _modelguid,//指标模板guid
        _uikey
    ;
    var cmp = {};

    $(function () {
        debugger
        cmp.query();
    })
    
    cmp.query = function(){
        var params = {};
        params.tablecode = _tablecode;
        params.projguid = _projguid;
        params.mainguid = _mainguid;
        params.procode = _procode;
        var xmxxEditobject = Ext.lt.RCP.asynserver("pmkpi.randomcomment.RandomProblemEditService", "getDatas", params);
		editform.synchEditformByObj(xmxxEditobject);
    }

    cmp.save = function(){
        if (!editform.check()) return false;//先校验
        var params = {};
        var datas = new Array();
        datas[0] = editform.getEditFormValues();
        params.datas =datas;
        params.tablecode = _tablecode;
        params.mainguid = _mainguid;
        params.projguid = _projguid;
        params.busguid = _busguid;
        params.procode = _procode;
        var rs = Ext.lt.RCP.asyncall(serviceid , "save", params);
        cmp.query();
        return rs;
    }
    
    return cmp;
}