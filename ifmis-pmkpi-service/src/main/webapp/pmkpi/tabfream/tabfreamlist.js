if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}

if(!Ext.lt.pmkpi.tabfreamlist){
    Ext.lt.pmkpi.tabfreamlist = {};
}

Ext.lt.pmkpi.tabfreamlist = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var serviceid = service,
        _workflow = config.workflow,//工作流guid
        _menuid = config.menuid,//菜单guid
        _saveAgency,//左侧树选择单位
        _tablecode,//表名
        _tabfilter,//页签过滤条件
        _tabcode,//页签编码
        _uikey,//跳转编辑页key
        _defquery,//表配置过滤条件
        _orderby,//表排序sql
        _deltables,//删除主单时关联的子表名称集合
        _delcols,//删除主单时子表关联的字段编码集合，不传默认为mainguid
        _repeatflag,//部门整体重复申报标识(1.false 代表不可以重复提交)
        _treesource = config.treesource,//左侧树数据源类型,部门/单位
        _isPilot = config.isPilot,// 是否湖北试点部门
        scrWidth =document.body.clientWidth,//页面宽度
        scrHeight =document.body.clientHeight;//页面高度
    var agencydata;//存在数据不用选择数据点击左侧树即可编辑
    var isfirst=true;//首次进入

    $(function (){
        common.initDatatable();
        //处理首页代办点击后跳转页签问题
        if (isfirst) {
            isfirst = false;
            common.pendingtasktab(config);
        }
    })

    //查询
    cmp.query = function (obj){
        Ext.lt.pmkpi.query();
    }

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        Ext.lt.pmkpi.query();
    });

    Ext.lt.pmkpi.query = function(){
        if(!_saveAgency){
            _saveAgency = "treeroot";
            Ext.lt.pmkpi.isleaf = 0;
        }
        Ext.lt.ui.loadingShow();
        var params = {};
        params.saveAgency = _saveAgency;
        params.isleaf = Ext.lt.pmkpi.isleaf + "";
        params.menuid = _menuid;
        params.workflow = _workflow;
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.tablecode = _tablecode;
        params.tabfilter = _tabfilter;
        params.tablesql = _defquery;
        params.orderby = _orderby;
        params.tabcode = _tabcode;
        params.treesource = _treesource;
        params.beanid = "pmkpi.tabfream.TabfreamBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params,function(){
            Ext.lt.ui.loadingClose();
        });
    }

    /**
     * 左侧树点击
     */
    Ext.lt.message.hook("left", "click",function(obj){
        var treeNode = obj.node.data;
        if(treeNode){
            _saveAgency = treeNode.guid;
            Ext.lt.pmkpi.isleaf = treeNode.isleaf;
        } else {
            _saveAgency = "treeroot";
            Ext.lt.pmkpi.isleaf = 0;
        }
        cmp.query();
    });
    Ext.lt.message.hook("perfcommon", "auditquery",function(){
        Ext.lt.pmkpi.query();
    });
    /**
     * 查询消息
     */
    Ext.lt.message.hook("perfcommon", "tablequery",function(){
        Ext.lt.pmkpi.query();
    });
    /**
     * 列配置
     */
    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        var config = obj.table.config;
        //表配置
        _tablecode = uiconfig.tablecode;
        _defquery = uiconfig.defquery;
        _orderby = uiconfig.orderby;
        //bus_t_pageconsolecomconfig表中对应组件config配置
        _uikey = config.uikey;
        _deltables = config.deltables;//删除主单时关联的子表名称集合
        _delcols = config.delcols;//删除主单时子表关联的字段编码集合，不传默认为mainguid
        _repeatflag =config.repeatflag;//部门整体重复申报标识(1.false 代表不可以重复提交)

        var cols = obj.cols;
        if(!Ext.lt.isArray(cols))
            cols = [cols];
        for(var i=0; i<cols.length; i++){
            var col = cols[i];
            if(col["colcode"] == "name"){
                col.fn = function(l,c,data,col){
                    return "<a herf='#' style='color:#468ac9'>" + data.name + "</a>";
                }
                col.onclick = function(td, el, l, c, d) {
                    var url = _uikey + ".page";
                    var params = {};
                    params.mainguid = d.guid;
                    params.saveAgency = d.agencyguid;
                    params.viewtype = "query";
                    params.workflow = _workflow;
                    url = Ext.lt.pmkpi.genPageUrl(url, params);
                    Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"绩效目标申报");
                };
            }
        }
    });




    /**
     * 填报/修改
     */
    cmp.addOredit = function (obj){
        var data = datatable.getSelected();
        if(_treesource == 'PMKPIAGENCYALLPAY'){ //单位
            if(data.length != 1 && (!_saveAgency || Ext.lt.pmkpi.isleaf != "1")){
                Ext.lt.ui.alert("请选择左侧末级单位或选中一条数据进行填报/修改！",function(){});
                return;
            }
        } else if(_treesource == 'PMKPIDEPT'){//部门
            if(_saveAgency == "treeroot" && data.length != 1){
                Ext.lt.ui.alert("请选择左侧部门或选中一条数据进行填报/修改！",function(){});
                return;
            }
        }
        var params = {};
        params.workflow = _workflow;
        var url = _uikey + ".page";
        if (data.length == 1) {
            params.saveAgency = data[0].agencyguid;
            params.mainguid = data[0].guid;
        } else {
            //先查询已申报数据
            params.saveAgency = _saveAgency;
            if (_repeatflag && _repeatflag == 'false'){
                var rs = Ext.lt.RCP.asyncall(serviceid , "getDeclareData", params);
                if (rs && rs.data && rs.data.length >= 1) {
                    Ext.lt.ui.alert("同一部门只能申报一次,不可重复申报！",function(){});
                    Ext.lt.ui.closeModalWindow();
                    return;
                }
            }
            if (agencydata && agencydata.guid && agencydata.guid != "") {
                params.mainguid = agencydata.guid;
            } else {
                var newguid = Ext.lt.RCP.asyncall(serviceid , "getCreateguid", null);
                params.mainguid = newguid;
            }
            params.saveAgency = _saveAgency;
        }
        if( _isPilot == "false"){
            params.hidetab = ['deptperftest']; // 隐藏页签
        }
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"绩效目标申报");
    }

    /**
     * 删除
     */
    cmp.del = function() {
        var params = {};
        params.tablecode = _tablecode;
        params.deltables = _deltables;
        params.delcols = _delcols;
        common.deltable(datatable, params);
    }

    //送审/审核
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
        // 校验页签参数
        params.checkkey = _uikey;
        params.checktable = _tablecode;
        if (obj.code == "sendaudit" && !common.checkTabPageData(params)) return false;//先校验
        common.doAction(obj, params);
    }

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

    return cmp;
}

