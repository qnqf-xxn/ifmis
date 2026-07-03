if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.deptperfinfo){
    Ext.lt.pmkpi.deptperfinfo = {};
}

Ext.lt.pmkpi.deptperfinfo = function(config, service){
    var serviceid = service,
        _mainguid = config.mainguid,
        _projguid = config.projguid,
        _saveAgency = config.saveAgency,
        _tablecode,//表名
        _defquery,//表配置过滤条件
        _orderby,//表排序sql
        _busguid,//审核定义
        _findex;//一级指标
    var cmp = {};
    
    Ext.lt.message.hook("editform", "drawed",function(obj){
    	var config = obj.configs;
    	_tablecode = config[0].tablecode;
    });

    cmp.query = function(){
        var params = {};
        params.tablesql = _defquery;
        params.orderby = _orderby;
        params.tablecode = _tablecode;
        params.mainguid = _mainguid;
        params.projguid = _projguid;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid , "getDatas", params, function(rs){
        	var editobject = rs.data[0];
        	editform.synchEditformByObj(editobject);
            Ext.lt.ui.loadingClose();
        },function(){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('查询失败！',function(){
            });
        });
    }

    cmp.save = function(){
        if (!editform.check()) return false;//先校验
        var params = {};
        params.datas = editform.getEditFormValues();
        params.tablecode = _tablecode;
        params.mainguid = _mainguid;
        params.projguid = _projguid;
        params.busguid = _busguid;
        var rs = Ext.lt.RCP.asyncall(serviceid , "save", params);
        cmp.query();
        return rs;
    }

    $(function () {
        debugger
        cmp.query();
    })

    return cmp;
}