if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.naturesaudit)
    Ext.lt.pmkpi.naturesaudit = {};

Ext.lt.pmkpi.naturesaudit = function(config, service){
    var cmp = {};
    var serviceid = service,
        _tablecode,
        _tablesql,
        _tableorderby;

    Ext.lt.message.hook("addRow", "uidatatable", function(editdatatable){
        var newguid = Ext.lt.RCP.asyncall(serviceid , "getCreateguid", null);
        var newdata ={};
        newdata.guid = newguid;
        newdata.rowtype = "add";
        datatable.getRecordSet().addData(newdata,999);
    });

    Ext.lt.message.hook("delRow", "uidatatable", function(editdatatable){
        var selDatas = datatable.getSelected();
        if (selDatas.size() <= 0) {
            Ext.lt.ui.alert('请选择要删除的数据！',function(){
            });
            return;
        }
        Ext.lt.ui.confirm('是否删除已选择数据？',null,function(is){
            if(is){
                datatable.removeData(selDatas);
            }
        })
    });
    /**
     *
     */
    Ext.lt.message.hook("busdatatable", "drawed",function (obj) {
        _tablecode = obj.uiconfig.tablecode;
        _tablesql = obj.uiconfig.defquery;
        _tableorderby = "order by ordernum";
    });

    /**
     * 基础信息保存
     */
    cmp.tablesave = function (obj){
        if (!datatable.check()) return;//先校验
        var params= {};
        params.tablecode = _tablecode;
        params.tablesql = _tablesql;
        params.tableorderby = _tableorderby;
        params.datas = datatable.getRecordSet().toArray();
        params.updatas = datatable.getUpdataData();
        params.deldatas = datatable.getRemoveData();
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
     * 查询
     */
    cmp.query = function(){
        var params = {};
        try{
            if (!queryform)params.queryConfig = queryform.getQueryParam();
            params.querySql = queryform.getQuerySQL();
        }catch (e) {}
        params.tablecode = _tablecode;
        params.tablesql = _tablesql;
        params.tableorderby = _tableorderby;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid , "getDatas", params, function(rs){
            datatable.setDatas(rs.data);
            Ext.lt.ui.loadingClose();
        },function(){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('查询失败！',function(){
            });
        });
    }

    $(function () {
        cmp.query();
    })

    return cmp;
}

