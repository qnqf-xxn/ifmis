if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.promod){
    Ext.lt.pmkpi.promod = {};
}

Ext.lt.pmkpi.promod.rpservice = function(config, service){
    var cmp = {};
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var _menuid = config.menuid,//菜单id
        _tablecode,
        _datasource,//数据源集合
        _workflow = config.workflow,//工作流guid
        _prolev = config.prolev,//项目级次
        _modtype = config.modtype,
        _tablesql,
        _defquery,//列表查询条件
        _tabfilter,//页签查询条件
        _tabcode,//页签编码
        _saveAgency,//左侧树选择单位
        _lefttreename = "项目支出",//左侧评价对象树名称 默认项目支出
        _lefttabtype = "program",//左侧树页签guid 默认项目支出
        scrWidth = document.body.clientWidth,
        scrHeight = document.body.clientHeight;
    var isfirst=true;

    $(function (){
        common.initDatatable();
        Ext.lt.pmkpi.query();
        isfirst = false;
    })

    //查询
    cmp.query = function (obj){
        Ext.lt.pmkpi.query();
    }

    Ext.lt.pmkpi.query = function(){
        if(!_saveAgency){
            _saveAgency = "treeroot";
            Ext.lt.pmkpi.isleaf = 0;
        }
        Ext.lt.ui.loadingShow();
        var params = {};
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.tablecode = _tablecode;
        params.tablesql = _tablesql;
        params.menuid = _menuid;
        params.tabcode = _tabcode;
        params.prolev = _prolev;
        params.saveAgency = _saveAgency;
        params.isleaf = Ext.lt.pmkpi.isleaf+"";
        params.tabfilter = _tabfilter;
        params.workflow = _workflow;
        params.modtype = _modtype;
        params.beanid = "pmkpi.perfpromod.ProModRpBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        common.setColDatasource(_datasource, datatable);
        datatable.queryData(params,function(){
            Ext.lt.ui.loadingClose();
        });
    }

    /**
     * 左侧树点击
     */
    Ext.lt.message.hook("left", "click",function(obj){
        var treeNode = obj.node.data;
        if(treeNode){ //不选择预算单位按类型查询
            _saveAgency = treeNode.guid;
            Ext.lt.pmkpi.isleaf = treeNode.isleaf;
        } else {
            _saveAgency = "treeroot";
            Ext.lt.pmkpi.isleaf = '0';
        }
        cmp.query();
    });

    //送审情况
    cmp.queryaudit = function (){
        common.auditquery(datatable);
    }

    //页签方法
    cmp.clickTabpage = function(obj){
        common.changTooltoolbuttontStatus(0,obj.hidebtns);
        _tabfilter = obj.filter;
        _tabcode = obj.code;
        if (!isfirst) {
            Ext.lt.pmkpi.query();
        }
    }

    /**
     *工作流.
     */
    cmp.wfAudit = function (obj){
        var datas = datatable.getSelected();
        if (datas.length <= 0) {
            Ext.lt.ui.alert("请选择要" + obj.name + "的数据！",function(){});
            return;
        }
        if (!common.checkwfstatus(datas)) return false;//先校验审核状态是否一致
        var params = {};
        params.datas = datas;
        params.tablecode = _tablecode;
        params.busguid = _menuid + "_" + datas[0]["wfstatus"];
        common.doAction(obj, params);
    }

    /**
     * 修订
     */
    cmp.revisionment = function (){
        var data = datatable.getSelected();
        if(!data || data.length != 1){
            Ext.lt.ui.alert("请选中一条数据进行修订！",function(){});
            return;
        }
        var guid = data[0].guid;
        var params = {};
        params.saveAgency = data[0].agencyguid;
        params.mainguid = guid;
        params.projguid = data[0].proguid;
        params.workflow = _workflow;
        params.prolev = _prolev;
        var url;
        if(_modtype == 'total'){
            url = "/pmkpi/program/mod/totaledit.page";
        }else {
            url = "/pmkpi/program/mod/yearedit.page";
        }
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"绩效修订");
    }

    /**
     * 选择项目
     */
    cmp.checkprogram = function(){
        if(_saveAgency == "" ){
            _saveAgency = 'treeroot';
        }
        var params = {};
        params.workflow = _workflow;
        params.prolev = _prolev;
        params.saveAgency = _saveAgency;
        params.bustype = _lefttabtype;
        params.isleaf = Ext.lt.pmkpi.isleaf+"";
        params.modtype = _modtype;
        var url = "/pmkpi/program/mod/report/procheck.page";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,scrWidth - 200,scrHeight - 200,"选择项目-"+_lefttreename);
    }

    /**
     * 查看明细
     */
    cmp.detailed = function (){
        var data = datatable.getSelected();
        if(!data || data.length != 1){
            Ext.lt.ui.alert("请选中一条数据进行查看！",function(){});
            return;
        }
        var params = {};
        params.saveAgency = data[0].agencyguid;
        params.mainguid = data[0].guid;
        params.projguid = data[0].proguid;
        params.workflow = _workflow;
        params.prolev = _prolev;
        params.viewtype = "query";
        var url = "";
        if(_modtype == 'total'){
            url = "/pmkpi/program/mod/totaledit.page";
        }else {
            url = "/pmkpi/program/mod/yearedit.page";
        }
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"绩效修订-"+_lefttreename);
    }

    cmp.delrevision = function (){
        var data = datatable.getSelected();
        for(var i=0;i<data.length;i++){
            var wfstatus = data[i].wfstatus;
            if(wfstatus != "000"){
                Ext.lt.ui.alert("请选中未送审的数据进行删除！",function(){});
                return;
            }
        }
        Ext.lt.ui.confirm('是否删除已选中项目？',null,function(is){
            if(is){
                Ext.lt.ui.loadingShow();
                var params = {};
                params.datas = data;
                params.tablecode = _tablecode;
                Ext.lt.RCP.call(service , "delDatas", params, function(rs){
                    Ext.lt.ui.loadingClose();
                    if (rs.success) {
                        Ext.lt.ui.alert('删除成功！',function(){
                            cmp.query();
                        });
                    }
                },function(){
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert('删除失败！',function(){
                    });
                });
            }
        })
    }

    Ext.lt.message.hook("perfcommon", "auditquery",function(){
        Ext.lt.pmkpi.query();
    });

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        Ext.lt.pmkpi.query();
    });

    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        var config = obj.table.config;
        _tablecode = uiconfig.tablecode;
        if(_modtype == "total"){
            _tablesql = config.totalwheresql;
        }else {
            _tablesql = config.yearwheresql;
        }
    });

    return cmp;
}