if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.adjust){
    Ext.lt.pmkpi.adjust = {};
}

Ext.lt.pmkpi.adjust.goallistservice = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};

    var _menuid = config.menuid,//菜单id
        _proguid = config.proguid,//项目guid
        _busguid = config.busguid,//审核定义guid，perf_t_busauditdefine表budguid
        _mainguid = config.mainguid,//
        _saveAgency = config.saveAgency,
        _viewtype = config.viewtype,
        _defquery,//列表查询条件
        _orderby,//排序
        _tablecode;//表名

    $(function (){
        $(function () {
            //组件配置，service不放到第一位时，组件初始化消息不走问题
            common.initDatatable();
            if (_viewtype == "query") {
                document.getElementById("add").style.display = "none";
                document.getElementById("del").style.display = "none";
            }
            Ext.lt.pmkpi.query(true);
        })
    })

    Ext.lt.pmkpi.query = function(isquery){
        var params = {};
        params.tablecode = _tablecode;
        params.tablesql = _defquery;
        params.proguid = _proguid;
        params.mainguid = _mainguid;
        Ext.lt.RCP.call(service, "getGoalList", params, function (rs) {
            datatable.setDatas(rs.data);
            if (isquery) {
                parent._isQuery = true;
            }
        }, function () {
            Ext.lt.ui.alert('查询失败！', function () {
            });
        });
    }

    /**
     * 保存方法.
     * @returns {*}
     */
    cmp.save = function () {
        if (datatable.getEditor()){
            datatable.closeEdit();
        }
        var datas = datatable.getRecordSet().toArray();
        var params = {};
        params.datas = datas;
        params.deldatas = datatable.getRemoveData();
        params.busguid = _busguid;
        params.saveAgency = _saveAgency;
        params.mainguid = _mainguid;
        params.proguid = _proguid; //申报阶段的来源
        params.tablecode = _tablecode;
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(service, "saveGoalList", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
            Ext.lt.pmkpi.query();
        }
        return rs;
    }

    /**
     * 新增行.
     */
    Ext.lt.message.hook("addRow", "uidatatable", function (editdatatable) {
        var newguid = Ext.lt.RCP.asyncall(service, "getCreateguid", null);
        var newdata = {};
        newdata.guid = newguid;
        newdata.mainguid = _mainguid;
        newdata.agencyguid = _saveAgency;
        newdata.rowtype = "add";
        newdata.yearflag = 0; //总体还是年度
        newdata.status = 3;
        datatable.getRecordSet().addData(newdata, 999);
    });


    /**
     * 刪除行.
     */
    Ext.lt.message.hook("delRow", "uidatatable", function (editdatatable) {
        var selDatas = datatable.getSelected();
        if (selDatas.size() <= 0) {
            Ext.lt.ui.alert('请选择要删除的目标数据！', function () {
            });
            return;
        }
        datatable.removeData(selDatas);
    });

    Ext.lt.message.hook("datatable", 'beforesetcols', function (obj) {
        var uiconfig = obj.table.uiconfig;
        _defquery = uiconfig.defquery;
        _orderby = uiconfig.orderby;
        _tablecode = uiconfig.tablecode;
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

    return cmp;
}