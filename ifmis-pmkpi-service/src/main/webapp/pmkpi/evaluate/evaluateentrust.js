if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.evaluate){
    Ext.lt.pmkpi.evaluate = {};
}
if(!Ext.lt.pmkpi.evaluate.evaluateentrustservice){
    Ext.lt.pmkpi.evaluate.evaluateentrustservice = {};
}

var _selectedtree = null;
Ext.lt.pmkpi.evaluate.evaluateentrustservice = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var serviceid = service;
    var cmp = {};
    var _menuid = config.menuid,//菜单id
        _workflow = config.workflow,//工作流guid
        _mainguid = config.guid,
        _maintablecode = config.maintablecode,//工作流主表
        _remark = config.remark,
        _tablecode,
        _datasource,//数据源集合
        _defquery//列表查询条件
        ;
    window.parent.Ext.lt.pmkpi.childwindow = window;

    $(function (){
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        common.initDatatable();
        Ext.lt.pmkpi.query();
        Ext.lt.pmkpi.querysel();
    })

    /**
     * 查询已选专家
     */
    Ext.lt.pmkpi.querysel = function(){
        Ext.lt.ui.loadingShow();
        var params = {};
        params.mainguid = _mainguid;
        var rs = Ext.lt.RCP.asyncall(serviceid , "queryselintermediary", params);
        if(rs && rs.success){
            seldatatable.setDatas(rs.data);
        }
        Ext.lt.ui.loadingClose();
    }

    /**
     * 查询
     */
    Ext.lt.pmkpi.query = function(){
        Ext.lt.ui.loadingShow();
        var params = {};
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.tablecode = _tablecode;
        params.mainguid = _mainguid;
        params.beanid = "pmkpi.evaluate.EvaluateEntrustBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params,function(){
            Ext.lt.ui.loadingClose();
        });
    }

    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        var config = obj.table.config;
        if(config.id == "datatable"){
            _defquery = uiconfig.defquery;
            _tablecode = uiconfig.tablecode;
        }
    });

    /**
     * 保存
     */
    cmp.save = function(){
        var saveDatas = checkSaveDatas();
        if (!saveDatas) {
            return;
        }
        var params = {};
        params.datas = saveDatas;
        try{
            params.prodatas = window.parent.datatable.getSelected();
        }catch (e) {
            params.prodatas = window.parent.parent.datatable.getSelected();
        }
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(service , "save", params, function(rs) {
            if(rs && rs.success){
                Ext.lt.ui.alert('保存成功！',function(){
                    Ext.lt.pmkpi.querysel();
                });
            }
            Ext.lt.ui.loadingClose();
        }, function(rt) {
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('保存失败！' + rt, function(){
            });
        });
    }

    function checkSaveDatas(){
        var datas = datatable.getSelected();
        var seldatas = seldatatable.getRecordSet().toArray();
        if (seldatas.length == 0 && (!datas || datas.length == 0)) {
            Ext.lt.ui.alert("请选中'中介库'中的专家信息！",function(){});
            return false;
        }
        var saveDatas = [];
        //已选择的专家数据
        if (seldatas.length > 0) {
            saveDatas = Ext.lt.cloneobj(seldatas);
            if (datas.length > 0) {
                for (var i=0; i<datas.length; i++) {
                    var issel = false;
                    for (var j=0; j<saveDatas.length; j++) {
                        if (saveDatas[j].intermediary == datas[i].guid) {
                            issel = true;
                            break;
                        }
                    }
                    if (!issel) {
                        saveDatas.push(datas[i]);
                    }
                }
            }
        } else {
            saveDatas = Ext.lt.cloneobj(datas);
        }
        return saveDatas;
    }

    /**
     * 删除
     */
    cmp.del = function(){
        var datas = seldatatable.getSelected();
        if (!datas || datas.length == 0) {
            Ext.lt.ui.alert("请选中'已选专家'表中的专家信息！",function(){});
            return;
        }
        var params = {};
        try{
            params.prodatas = window.parent.datatable.getSelected();
        }catch (e) {
            params.prodatas = window.parent.parent.datatable.getSelected();
        }
        params.datas = datas;
        Ext.lt.ui.confirm('是否删除已选择专家数据？',null,function(is){
            if(is){
                Ext.lt.ui.loadingShow();
                Ext.lt.RCP.call(service , "del", params, function(rs) {
                    if(rs && rs.success){
                        Ext.lt.ui.alert('删除成功！',function(){
                            Ext.lt.pmkpi.querysel();
                        });
                    }
                    Ext.lt.ui.loadingClose();
                }, function(rt) {
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert('删除失败！' + rt, function(){
                    });
                });
            }
        })
    }

    /**
     * 保存并送审
     */
    cmp.saveaudit = function(obj){
        var saveDatas = checkSaveDatas();
        if (!saveDatas) {
            return;
        }
        var params = {};
        if (obj.code == "saveaudit") {
            params.datas = saveDatas;
        }
        params.workflow = _workflow;
        var busguid;
        try{
            params.prodatas = window.parent.datatable.getSelected();
            busguid = window.parent._leftmenuid;
        }catch (e) {
            params.prodatas = window.parent.parent.datatable.getSelected();
            busguid = window.parent.parent._leftmenuid;
        }
        params.maintablecode = _maintablecode;
        params.remark = _remark;
        params.busguid = busguid + "_" + params.prodatas[0].wfstatus;
        Ext.lt.ui.confirm('是否确认' + obj.name +'？',null,function(is){
            if(is){
                Ext.lt.ui.loadingShow();
                Ext.lt.RCP.call(service , obj.code, params, function(rs) {
                    if(rs && rs.success){
                        Ext.lt.ui.alert(obj.name + '成功！',function(){
                            try {
                                window.parent.Ext.lt.pmkpi.query();
                                Ext.lt.ui.closeModalWindow();
                            } catch (e) {
                                window.parent.parent.Ext.lt.pmkpi.query();
                                parent.Ext.lt.ui.closeModalWindow();
                            }
                        });
                    }
                    Ext.lt.ui.loadingClose();
                }, function(rt) {
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert(obj.name + '失败！' + rt ,function(){
                    });
                });
            }
        })
    }

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        Ext.lt.pmkpi.query();
    });
    return cmp;
}




