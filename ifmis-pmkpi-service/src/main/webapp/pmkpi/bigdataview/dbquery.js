if (!Ext.lt.pmkpi) {
    Ext.lt.pmkpi = {};
}
if (!Ext.lt.pmkpi.bigdataview) {
    Ext.lt.pmkpi.bigdataview = {};
}

Ext.lt.pmkpi.bigdataview.dbquery = function (config, service) {
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var _menuid = config.menuid,//菜单id
        _lefttreename,//左侧评价对象树名称 默认项目支出
        _lefthidebtn,//左侧树隐藏按钮
        _leftmenuid,//隐藏菜单
        _lefttab = config.lefttab,//左侧树第一个页签
        _lefttabtype = _lefttab.code,//左侧树页签类型
        _tablecode,
        _selfevaltablecode,//自评表
        _prolev = config.prolev,//项目级次
        _defquery,//列表查询条件
        _tabfilter,//页签查询条件
        _tabcode,//页签编码
        _saveAgency,//左侧树选择单位
        _orderby,//排序
        _queryyear = config.queryyear,
        _deptcode = config.deptcode,
        scrWidth = document.body.clientWidth,
        scrHeight = document.body.clientHeight;
    var _displaycols = [];
    var tab_filters = {};//页签过滤条件集合

    $(function (){
        common.initDatatable();
        tabChange(_lefttab);
    })

    Ext.lt.pmkpi.query = function(){
        if(!_saveAgency){
            _saveAgency = "treeroot";
            Ext.lt.pmkpi.isleaf = 0;
        }
        Ext.lt.ui.loadingShow();
        var params = {};
        params.queryConfig = queryform.getQueryParam();
        var querySql = queryform.getQuerySQL();
        //特殊处理
        if(querySql.include("WFSTATUS= '999'")){
            querySql = querySql.replace("WFSTATUS= '999'","WFSTATUS is null")
        }
        params.querySql = querySql;
        params.tablecode = _tablecode;
        params.tablesql = _defquery;
        params.menuid = _menuid;
        params.tabcode = _tabcode;
        params.prolev = _prolev;
        params.saveAgency = _saveAgency;
        params.isleaf = Ext.lt.pmkpi.isleaf+"";
        params.tabfilter = _tabfilter;
        params.tasktype = _lefttabtype;
        params.leftmenuid = _leftmenuid;
        params.deptcode = _deptcode;
        params.queryyear = _queryyear;
        params.beanid = "pmkpi.bigdataview.BigdataViewBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params, function () {
            Ext.lt.ui.loadingClose();
            setTimeout(function(){
                datatable.resetSum();
            },300);
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
            Ext.lt.pmkpi.isleaf = '0';
        }
        Ext.lt.pmkpi.query();
    });

    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        var config = obj.table.config;
        _selfevaltablecode = config.selfevaltablecode;
        _tablecode = uiconfig.tablecode;
        _defquery=uiconfig.defquery;
        _orderby=uiconfig.orderby;
        var cols = obj.cols;
        if(!Ext.lt.isArray(cols))
            cols = [cols];
        for(var i=0; i<cols.length; i++){
            var col = cols[i];
            if(col["colcode"] == "warndays"){
                col.cseditfn = function(i,j,rs, style){ //列的单元格样式.
                    style = 'style="text-align:center;"';
                    return style;
                }
                col.fn = function(l,c,data,col){
                    if (data.warn == "red") {
                        return "<a style='color:#FF0000'>" + data.warndays + "</a>";
                    } else if (data.warn == "000") {
                        return "<a style='color:#FF0000'>已超时</a>";
                    } else if (data.warndays) {
                        return "<a>" + data.warndays + "</a>";
                    }
                }
            }

            if(col["colcode"]=="bgtwarn"){ //目标值构建符号和单位
                col.cseditfn = function(i,j,rs, style){ //列的单元格样式.
                    style = 'style="text-align:center;"';
                    return style;
                }
                col.fn = function(l,c,data,val){
                    var warn = !data.bgtwarn? "" : data.bgtwarn;
                    if (warn == "red") {
                        warn = '3';
                    } else if (warn == "yellow") {
                        warn = '1';
                    } else if (warn == "green") {
                        warn = '0';
                    } else if (warn == "blue") {
                        warn = '4';
                    } else {
                        return "";
                    }
                    return '<img id="image" style="vertical-align:middle;margin-top:9px;" src="/pmkpi/themes/images/' + warn + '.gif"/>';
                }
            }

            if(col["colcode"]=="goalwarn"){ //目标值构建符号和单位
                col.cseditfn = function(i,j,rs, style){ //列的单元格样式.
                    style = 'style="text-align:center;"';
                    return style;
                }
                col.fn = function(l,c,data,val){
                    var warn = !data.goalwarn? "" : data.goalwarn;
                    if (warn == "red") {
                        warn = '3';
                    } else if (warn == "yellow") {
                        warn = '1';
                    } else if (warn == "green") {
                        warn = '0';
                    } else if (warn == "blue") {
                        warn = '4';
                    } else {
                        return "";
                    }
                    return '<img id="image" style="vertical-align:middle;margin-top:9px;" src="/pmkpi/themes/images/' + warn + '.gif"/>';
                }
            }

            if(col["colcode"]=="compwarn"){ //全年预计完成情况预警
                col.cseditfn = function(i,j,rs, style){ //列的单元格样式.
                    style = 'style="text-align:center;"';
                    return style;
                }
                col.fn = function(l,c,data,val){
                    var warn = !data.compwarn? "" : data.compwarn;
                    if (warn == "red") {
                        warn = '3';
                    } else if (warn == "yellow") {
                        warn = '1';
                    } else if (warn == "green") {
                        warn = '0';
                    } else if (warn == "blue") {
                        warn = '4';
                    } else {
                        return "";
                    }
                    return '<img id="image" style="vertical-align:middle;margin-top:9px;" src="/pmkpi/themes/images/' + warn + '.gif"/>';
                }
            }
        }
    });

    /**
     * 左侧页签切换触发函数.
     */
    tabChange = function (obj) {
        _saveAgency = "treeroot";
        Ext.lt.pmkpi.isleaf = '0';
        _lefttabtype = obj["code"];
        _lefttreename = obj["name"];
        _lefthidebtn = obj.hidebtns;
        _leftmenuid = obj.leftmenuid;
        common.changTooltoolbuttontStatus(0,  _lefthidebtn);
        cmp.setTableColum();
        var treedatas = Ext.lt.pmkpi.querytree();
        Ext.lt.pmkpi.query();
        obj.datas = treedatas;
        return obj;
    }

    Ext.lt.pmkpi.querytree = function (){
        var params = {};
        params.menuid = _menuid;
        params.tablecode = _tablecode;
        params.tasktype = _lefttabtype;
        params.leftmenuid = _leftmenuid;
        params.deptcode = _deptcode;
        params.queryyear = _queryyear;
        var datalist = Ext.lt.RCP.asyncall(service , "getTreeData", params);
        lefttree.setRecordset(datalist, 0);
        return datalist;
    }

    /**
     * 动态配置表格的列.
     *
     * @param data --
     */
    cmp.setTableColum = function(cols){
        var cols = datatable.getCols(); //获取列表所有列
        cols.push.apply(cols, _displaycols);
        _displaycols = [];
        for (var i = 0, len = cols.length; i < len; i++) {
            var col = cols[i];
            var config = eval(col.config);
            if (config && !$.isEmptyObject(config) && col.alias != "序号") {
                if (config.lefttabtype == _lefttabtype) {
                    col.display = true;
                } else {
                    _displaycols.push(col); //隐藏前暂存至sfagency;
                    col.display = false; //display置为false，隐藏
                }
            }
        }
        var page = {};//datatable.getPage();
        page.columns = "*";
        datatable.setPage(page);
        datatable.setSelfdefconfig({config: "{}"});
        datatable.redraw();
    }

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        Ext.lt.pmkpi.query();
    });

    /**
     * 查看明细
     */
    cmp.jkdetailed = function (){
        var data = datatable.getSelected();
        if (!data || data.length != 1) {
            Ext.lt.ui.alert("请选中一条数据进行查看！", function () {
            });
            return;
        }
        var params = {};
        var tasktype = "transpaytrace" == data[0].tasktype ? "protrace": data[0].tasktype ;
        var provincetask = data[0].provincetask;
        var url = "";
        if (tasktype && "protrace" == tasktype) { //项目支出
            if (provincetask && provincetask == "1") {
                url = "/pmkpi/program/trace/report/edit.page";
            } else {
                url = "/pmkpi/program/trace/report/ordinaryedit.page";
            }
        }
        params.saveAgency = data[0].agencyguid;
        params.taskguid = data[0].taskguid;//监控任务guid
        params.prolev = _prolev;
        params.bustype = _lefttabtype == "program" ? "protrace" : "";
        params.mainguid = data[0].jkguid;
        params.agency = data[0].agencyguid;
        params.viewtype = "query";
        params.projguid = data[0].proguid;
        params.procode = data[0].pro_code;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth, scrHeight,"绩效监控查看-"+_lefttreename);
    }

    /**
     * 查看明细
     */
    cmp.zpdetailed = function () {
        var data = datatable.getSelected();
        if (!data || data.length != 1) {
            Ext.lt.ui.alert("请选中一条数据进行查看！", function () {
            });
            return;
        }
        var params = {};
        var url = "/pmkpi/perfself/apply/edit.page";
        params.mainguid = data[0].zpguid;
        params.saveAgency = data[0].agencyguid;
        params.projguid = data[0].proguid;
        params.procode = data[0].pro_code;
        params.viewtype = "query";
        params.bustype = _lefttabtype;
        params.tablecode = _selfevaltablecode;
        params.wfstatus = data[0].wfstatus;
        params.querycode = true;  //部门整体目标查询条件
        params.proguid = data[0].proguid;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth, scrHeight, "绩效自评查看-" + _lefttreename);
    }

    return cmp;
}