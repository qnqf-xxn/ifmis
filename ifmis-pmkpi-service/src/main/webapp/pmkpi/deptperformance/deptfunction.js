if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.deptfunction){
    Ext.lt.pmkpi.deptfunction = {};
}

Ext.lt.pmkpi.deptfunction = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var serviceid = service,
        _mainguid = config.mainguid,
        _saveAgency = config.saveAgency,
        _viewtype = config.viewtype,
        _tablecode,//表名
        _defquery,//表配置过滤条件
        _orderby,//表排序sql
        _busguid = config.busguid,//审核定义
        _findex,//一级指标s
        scrWidth =document.body.clientWidth,
        scrHeight =document.body.clientHeight;
    var cmp = {};


    cmp.query = function(isquery){
        var params = {};
        params.tablesql = _defquery;
        params.orderby = _orderby;
        params.tablecode = _tablecode;
        params.mainguid = _mainguid;
        params.saveAgency = _saveAgency;
        params.beanid = "pmkpi.deptperformance.func.DeptFuncBO";
        datatable.queryData(params, function () {
            Ext.lt.ui.loadingClose();
            if (isquery) {
                parent._isQuery = true;
            }
        });
        // Ext.lt.RCP.call(serviceid , "queryByFunctional", params, function(rs){
        //     datatable.setDatas(rs.data);
        //     Ext.lt.ui.loadingClose();
        // },function(){
        //     Ext.lt.ui.loadingClose();
        //     Ext.lt.ui.alert('查询失败！',function(){
        //     });
        // });
    }


    //取消
    Ext.lt.ui.closeModalWindow = function () {
        parent.Ext.lt.ui.modalWindow.close();
    }

    //确认
    cmp.confirm =function(){
        debugger;
        var data = datatable.getSelected();
        if(data.length != 1){
            Ext.lt.ui.alert("请选择一条数据！",function(){});
            return;
        }
        var params = data[0];
        params.name = data[0].fun_res_des;
        params.mainguid = _mainguid;
        params.rowtype = "add";
        params.agencyguid =_saveAgency;
        Ext.lt.pmkpi.isadd = true;
        parent.datatable.getRecordSet().addData(params);
        Ext.lt.ui.closeModalWindow();// 关闭
    }



    Ext.lt.message.hook("busdatatable", "drawed",function (obj) {
        var config = obj.config;
        _tablecode = obj.uiconfig.tablecode;
        _defquery = obj.uiconfig.defquery;
        _orderby = obj.uiconfig.orderby;
        _uikey = config.uikey;
        _findex = config.findex;
    });




    $(function () {
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        common.initDatatable();
        if (_viewtype == "query") {
            document.getElementById("add").style.display = "none";
            document.getElementById("del").style.display = "none";

        }
        cmp.query(true);
    })

    return cmp;
}