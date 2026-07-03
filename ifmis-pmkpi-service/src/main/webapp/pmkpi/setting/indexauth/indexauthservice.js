if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.indexauthservice)
    Ext.lt.pmkpi.indexauthservice = {};

Ext.lt.pmkpi.indexauthservice = function(config, service){
    var serviceid = service,
        _authtype = config.authtype,
        _tablecode,
        _tablesql,
        _tableorderby;
    var cmp = {};

    $(function () {
        cmp.query();
    })

    Ext.lt.pmkpi.query = function(){
        cmp.query();
    }

    /**
     * 查询数据
     */
    cmp.query = function(){
        var params = {};
        params.authtype = _authtype;
        params.tablecode = _tablecode;
        params.tablesql = _tablesql;
        params.tableorderby = _tableorderby;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid , "getData", params, function(rs){
            datatable.setDatas(rs);
            Ext.lt.ui.loadingClose();
        },function(){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('查询失败！',function(){
            });
        });
    }

    /**
     * 表格保存
     */
    cmp.save = function (obj){
        if (!datatable.check()) return;//先校验
        var params= {};
        params.authtype = _authtype;
        params.tablecode = _tablecode;
        params.datas = datatable.getRecordSet().toArray();
        Ext.lt.RCP.call(serviceid , "save", params, function(rs){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('保存成功！',function(){
                cmp.query();
            });
        },function(){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('保存失败！',function(){
            });
        });
    }

    /**
     * 授权
     */
    cmp.openStatus = function (obj){
        var params= {};
        params.tablecode = _tablecode;
        params.datas = datatable.getSelected();
        params.status = obj.param;
        params.msg = '开启授权';
        cmp.isopenandsown(params);
    }

    /**
     * 取消授权
     */
    cmp.closeStatus = function (obj){
        if (!datatable.check()) return;//先校验
        var params= {};
        params.tablecode = _tablecode;
        params.datas = datatable.getSelected();
        params.status = obj.param;
        params.msg = '取消授权';
        cmp.isopenandsown(params);
    }

    cmp.isopenandsown = function(params){
        var selDatas = datatable.getSelected();
        if (selDatas.size() <= 0) {
            Ext.lt.ui.alert('请选择要' + params.msg + '的数据！',function(){
            });
            return;
        }
        Ext.lt.RCP.call(serviceid , "isopenandsown", params, function(rs){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert(params.msg + '成功！',function(){
                cmp.query();
            });
        },function(){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert(params.msg + '失败！',function(){
            });
        });
    }

    Ext.lt.message.hook("busdatatable", "drawed",function (obj) {
        _tablecode = obj.uiconfig.tablecode;
        _tablesql = obj.uiconfig.defquery;
        _tableorderby = "order by ordernum";
    });

    return cmp;
}