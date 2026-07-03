if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.autoview){
	Ext.lt.pmkpi.autoview = {};
}

Ext.lt.pmkpi.autoview.viewreport = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var _menuid = config.menuid,//菜单id
        _tablecode,
        _defquery,//列表查询条件
        _saveAgency,//左侧树选择单位
        _orderby,//排序
        _querykey = config.querykey,
        _querydata = config.querydata,
        _coldatas = config.coldatas,
        _tabledata = config.tabledata,
        _tabletitle,
        scrWidth = document.body.clientWidth,
        scrHeight = document.body.clientHeight;

    var cmp = {};

    Ext.lt.pmkpi.query = function(){
        if(!_saveAgency){
            _saveAgency = "treeroot";
            Ext.lt.pmkpi.isleaf = 0;
        }
        Ext.lt.ui.loadingShow();
        var params = {};
        params.queryConfig = queryform.getQueryParam();
        var querySql = queryform.getQuerySQL();
        params.querySql = querySql;
        params.tablecode = _tablecode;
        params.tablesql = _defquery;
        params.menuid = _menuid;
        params.agency = _saveAgency;
        params.isleaf = Ext.lt.pmkpi.isleaf+"";
        params.beanid = "pmkpi.autoview.ReportBOTX";
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
            Ext.lt.pmkpi.isleaf = '0';
        }
        Ext.lt.pmkpi.query();
    });

    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        var config = obj.table.config;
        var cols = obj.cols;
        if(!Ext.lt.isArray(cols))
            cols = [cols];
        for(var i=0; i<cols.length; i++){
            var col = cols[i];

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


    Ext.lt.pmkpi.querytree = function (){
        var params = {};
        params.menuid = _menuid;
        params.tablecode = _tablecode;
        params.tasktype = _lefttabtype;
        params.leftmenuid = _leftmenuid;
        var datalist = Ext.lt.RCP.asyncall(service , "getTreeData", params);
        lefttree.setRecordset(datalist, 0);
        return datalist;
    }


    $(function (){
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        common.initDatatable();
        _defquery = _tabledata.defquery;
        _tablecode = _tabledata.tablecode;
        _orderby = _tabledata.orderby;
        _tabletitle = _tabledata.config.titile;
        if(_tabletitle){
            $("#datatable").find(".titlename").html(_tabletitle);
        }
        var page = {};
        page.columns = "*";
        datatable.setPage(page);
        datatable.setSelfdefconfig({config: "{}"});
        datatable.redraw();
        // cmp.setTableColum(_coldatas);
        queryfrom(_querydata,_querykey);
        Ext.lt.pmkpi.query();
    })

    function queryfrom(data, key) {
        var configqueryform = {
            id: "queryform",
            fastquery : true,
            datatable : 'datatable',
            drawmode :'div',
            key: key,
            label: "快速查询",
            labelwidth: "120",
            appid: "pmkpi",
            config: null,
            serverid: key,
            amtmaxlength:18,
            columnsize: 5,
            data: data
        }
        queryform = new Ext.lt.bus.ui.querypanel(configqueryform);
        queryform.draw($(".busquerypanel_outline")[0]);
    }


    Ext.lt.message.hook("queryform", "doquery",function(obj){
        Ext.lt.pmkpi.query();
    });

    /**
     * 查看明细
     */
    cmp.detailed = function (){
        var data = datatable.getSelected();
        if (!data || data.length != 1) {
            Ext.lt.ui.alert("请选中一条数据进行查看！", function () {
            });
            return;
        }
        var tasktype = data[0].tasktype;//任务类型 项目/部门/政策
        var provincetask = data[0].provincetask;
        var url = "";
        if (tasktype && "protrace" == tasktype) { //项目支出
            if (provincetask && provincetask == "1") {
                url = "/pmkpi/program/trace/report/edit.page";
            } else {
                url = "/pmkpi/program/trace/report/ordinaryedit.page";
            }
        } else if (tasktype && "depttrace" == tasktype) { //部门整体
            url = "/pmkpi/trace/report/deptedit.page";
        } else if (tasktype && "policytrace" == tasktype) { //重大政策
        }
        var params = {};
        params.saveAgency = data[0].agencyguid;
        params.taskguid = data[0].taskguid;//监控任务guid
        params.prolev = _prolev;
        params.bustype = _lefttabtype;
        params.mainguid = data[0].guid;
        params.agency = data[0].agencyguid;
        params.viewtype = "query";
        params.projguid = data[0].proguid;
        params.procode = data[0].pro_code;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth, scrHeight,"绩效监控申报-"+_lefttreename);
    }


    /**
     * 查看整改详情
     */
    cmp.rectify = function(){
        var data = datatable.getSelected();
        var params = {};
        params.projguid = data[0].proguid;
        params.pro_code = data[0].pro_code;  //项目编码
        params.taskguid = data[0].taskguid;  //监控任务名称
        params.lefttabtype = _lefttabtype;
        params.rectype = "rectifytrace";
        var is = Ext.lt.RCP.asyncall(service , "getDatas", params);
        if (is){
            if(data.size()==1){
                if (_lefttabtype == "protrace") { //项目支出
                    params.bustype = '1';
                    params.workflow = "D7F6D15AB0E27ECFE0533315A8C04610";
                    var url = '/pmkpi/rectification/program/edit.page';
                } else if (_lefttabtype == "depttrace") { //部门整体
                    params.bustype = '3';
                    params.workflow = "D7F6D15AB0E37ECFE0533315A8C04610";
                    var url = '/pmkpi/rectification/dept/edit.page';
                }
                var datalist = Ext.lt.RCP.asyncall(service , "getDataList", params);
                params.projguid = datalist[0].proguid;
                params.pro_code = datalist[0].pro_code;  //项目编码
                params.mainguid = datalist[0].guid;
                params.guid = datalist[0].guid;
                params.saveAgency = datalist[0].agencyguid;
                params.rectifyType = datalist[0].type;
                params.pagetype = "editreport";
                params.viewtype = "query";
                params.lefttabtype = _lefttabtype;
                params.lefttreename = _lefttreename;
                params.menuid = _menuid;
                url = Ext.lt.pmkpi.genPageUrl(url, params);
                Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"整改通知详情 - "+_lefttreename);
            } else if(data.size() > 1) {
                Ext.lt.ui.alert('只能查看一条数据！',function(){});
            } else {
                Ext.lt.ui.alert('请选择要查看的数据！',function(){});
            }
        }else{
            Ext.lt.ui.alert("数据未发起整改！", function () {
            });
            return;
        }
    }

    return cmp;
}