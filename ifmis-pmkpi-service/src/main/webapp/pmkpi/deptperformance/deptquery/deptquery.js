if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.deptquery){
    Ext.lt.pmkpi.deptquery = {};
}
Ext.lt.pmkpi.deptquery.index = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var _menuid = config.menuid,//菜单id
        _pagetype = config.pagetype,//菜单类型，部门、财政
        _taskguid = config.taskguid,//任务guid
        _tablecode,//列表查询表
        _prolev = config.prolev,//项目级次
        _tasktype = config.tasktype,//任务类型，项目/部门/政策
        _defquery,//列表查询条件
        _tabfilter,//页签查询条件
        _tabcode,//页签编码
        _wheresql, //配置查询条件
        _deltables,
        _delcols,
        scrWidth = document.body.clientWidth,
        scrHeight = document.body.clientHeight;

    var isfirst = true;

    //查询
    cmp.query = function (obj){
        Ext.lt.pmkpi.query();
    }

    Ext.lt.pmkpi.query = function(){
        Ext.lt.ui.loadingShow();
        var params = {};
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.tablecode = _tablecode;
        params.tablesql = _defquery ;
        params.menuid = _menuid;
        params.tabcode = _tabcode;
        params.wheresql = _wheresql;
        params.beanid = "pmkpi.deptperformance.deptquery.DeptQueryBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params,function(){
            Ext.lt.ui.loadingClose();
        });
    }

    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        _defquery = uiconfig.defquery;
        _tablecode = uiconfig.tablecode;
        var config = obj.table.config;
        _deltables = config.deltables;
        _delcols = config.delcols;
    });



    /**
     * 选择部门
     */
    cmp.add = function (){
        var datas = datatable.getSelected();
        if(!datas.length || datas.length <= 0 ){
            Ext.lt.ui.alert("请选择部门！",function(){});
            return;
        }
        Ext.lt.ui.confirm('是否确定所选部门？',null,function(is){
            if(is){
                var params = {};
                params.datas = datas;
                params.tabcode = _tabcode;
                params.delcols = _delcols;
                params.deltables = _deltables;
                Ext.lt.RCP.call(service , "save", params, function(rs){
                    if (rs && rs.flg == "1") {
                        Ext.lt.ui.alert('成功！',function(){
                            Ext.lt.pmkpi.query();
                        });
                    }
                },function(){
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert('失败！',function(){
                    });
                });
            }
        })
    }

    /**
     * 取消选择
     */
    cmp.del = function (){
        var datas = datatable.getSelected();
        if(!datas.length || datas.length <= 0 ){
            Ext.lt.ui.alert("请选择要取消的部门！",function(){});
            return;
        }
        var params = {};
        params.selDatas = datas;
        Ext.lt.ui.confirm('是否取消选择部门？',null,function(is){
            if(is){
                var params = {};
                params.datas = datas;
                params.tabcode = _tabcode;
                Ext.lt.RCP.call(service , "del", params, function(rs){
                    if (rs && rs.flg == "1") {
                        Ext.lt.ui.alert('取消成功！',function(){
                            Ext.lt.pmkpi.query();
                        });
                    }
                },function(){
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert('取消失败！',function(){
                    });
                });
            }
        })
    }

    /**
     * 页签
     */
    cmp.clickTabpage = function (obj){
        changToolbuttonStatus(toolbutton, parseInt(obj.ordernum), obj.hidebtns);
        _tabfilter = obj.filter;
        _tabcode = obj.code;
        if (!isfirst) {
            Ext.lt.pmkpi.query();
        }
    }

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        Ext.lt.pmkpi.query();
    });

    /**
     * 动态配置表格的列.
     *
     * @param data --
     */
    cmp.setTableColum = function(){
        var page = {};
        page.columns = "*";
        datatable.setPage(page);
        datatable.redraw();
    }

    $(function (){
        common.initDatatable();
        if (isfirst) {
            isfirst = false;
        }
        cmp.setTableColum();
        Ext.lt.pmkpi.query();
    })

    return cmp;
}