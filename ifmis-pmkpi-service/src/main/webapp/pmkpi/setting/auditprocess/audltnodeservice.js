if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.auditnode)
    Ext.lt.pmkpi.auditnode = {};

Ext.lt.pmkpi.auditnode = function(config, service){
    var cmp = {};
    var serviceid = service,
        _wfid;

    Ext.lt.message.hook("left", "click",function(obj){
        var treeNode = obj.node.data;
        if(treeNode && treeNode.isleaf == 1){
            _wfid = treeNode.guid;
            cmp.query();
        }
    });

    /**
     * 基础信息保存
     */
    cmp.tablesave = function (obj){
        if (!datatable.checkAll()) return;//先校验
        var params= {};
        params.datas = datatable.getRecordSet().toArray();
        params.wfid = _wfid;
        Ext.lt.RCP.call(serviceid , "save", params, function(rs){
            if (rs && rs.success) {
                Ext.lt.ui.alert('保存成功！',function(){
                    cmp.query();
                });
            }
            Ext.lt.ui.loadingClose();
        },function(){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('保存失败！',function(){
            });
        });
    }

    /**
     * 查询
     */
    cmp.query = function(){
        var params = {};
        try{
            if (!queryform)params.queryConfig = queryform.getQueryParam();
            params.querySql = queryform.getQuerySQL();
        }catch (e) {}
        params.wfid = _wfid;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid , "getDatas", params, function(rs){
            datatable.setDatas(rs.data);
            Ext.lt.ui.loadingClose();
        },function() {
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('查询失败！',function(){
            });
        });
    }

    return cmp;
}

