if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.thirdparty){
    Ext.lt.pmkpi.thirdparty = {};
}

Ext.lt.pmkpi.thirdparty = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var serviceid = service,
        _mainguid = config.mainguid,
        _tablecode,//表名
        _defquery,//保存的表
        _orderby,//表排序sql
        _viewtype = config.viewtype,
        _busguid = config.busguid;//审核定义guid
    var cmp = {};

    $(function () {
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        common.initDatatable();
        cmp.query(true);
        if (_viewtype == "query") {
            if(document.getElementById("add"))
                document.getElementById("add").style.display = "none";
            if(document.getElementById("del"))
                document.getElementById("del").style.display = "none";
        }
    })

    cmp.query = function(isquery){
        var params = {};
        params.tablesql = _defquery;
        params.orderby = _orderby;
        params.tablecode = _tablecode;
        params.mainguid = _mainguid;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid , "getDatas", params, function(rs){
            datatable.setDatas(rs.data);
            Ext.lt.ui.loadingClose();
            if (isquery) {
                setTimeout(function(){
                    parent._isQuery = true;
                },500);
            }
        },function(){
            Ext.lt.ui.alert('查询失败！',function(){
                Ext.lt.ui.loadingClose();
            });
        });
    }

    /**
     * 保存.
     * @returns {*}
     */
    cmp.save = function(){
        var params = {};
        params.datas = datatable.getRecordSet().toArray();
        params.deldatas = datatable.getRemoveData();
        params.tablecode = _tablecode;
        params.busguid = _busguid;
        var rs = Ext.lt.RCP.asyncall(serviceid , "save", params);
        if (rs && rs.success) {
            cmp.query();
        }
        return rs;
    }

    Ext.lt.message.hook("busdatatable", "drawed",function (obj) {
        _tablecode = obj.uiconfig.tablecode;
        _defquery = obj.uiconfig.defquery;
        _orderby = obj.uiconfig.orderby;
    });

    Ext.lt.message.hook("datatable", 'beforesetcols',function(obj){
        var cols = obj.cols;
        if(!Ext.lt.isArray(cols))
            cols = [cols];
        for(var i=0; i<cols.length; i++){
            var col = cols[i];
            if(_viewtype == 'query' && col["name"] != "check"){
                col.style = "background-color:#f2f2f2;";
                col.oneditstart = function(table, e, l, c, d){
                    return false;
                }
            }
        }
    });
    Ext.lt.message.hook("addRow", "uidatatable", function(editdatatable){
        var newdata ={};
        newdata.mainguid = _mainguid;
        newdata.rowtype = "add";
        Ext.lt.pmkpi.isadd = true;
        datatable.getRecordSet().addData(newdata,999);
    });

    Ext.lt.message.hook("delRow", "uidatatable", function(editdatatable){
        var selDatas = datatable.getSelected();
        if (selDatas.size() <= 0) {
            Ext.lt.ui.alert('请选择要删除的数据！',function(){});
            return;
        }
        Ext.lt.ui.confirm('是否删除已选择数据？',null,function(is){
            if(is){
                datatable.removeData(selDatas);
            }
        })
    });



    return cmp;
}