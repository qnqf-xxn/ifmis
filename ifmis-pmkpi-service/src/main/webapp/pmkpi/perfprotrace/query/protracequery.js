if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.perfprogram){
	Ext.lt.pmkpi.perfprogram = {};
}

Ext.lt.pmkpi.perfprogram.protracequery = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};

    var _menuid = config.menuid,//菜单id
        _lefttreename,//左侧评价对象树名称 默认项目支出
        _lefthidebtn,//左侧树隐藏按钮
        _leftmenuid,//隐藏菜单
        _lefttab = config.lefttab,//左侧树第一个页签
        _lefttabtype = _lefttab.code,//左侧树页签类型
        _deptwfststus = config.deptwfststus,//一般监控终审状态
        _jxwfststus = config.jxwfststus,//一般监控终审状态
        _tablecode,
        _prolev = config.prolev,//项目级次
        _defquery,//列表查询条件
        _tabfilter,//页签查询条件
        _tabcode,//页签编码
        _saveAgency,//左侧树选择单位
        _orderby,//排序
        _deptcode = config.deptcode,//数据分析大屏跳转-只查询本部门数据
        scrWidth = document.body.clientWidth,
        scrHeight = document.body.clientHeight;
    var _displaycols = [];
    var qfdatas;

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
        params.deptwfststus = _deptwfststus;
        params.jxwfststus = _jxwfststus;
        params.deptcode = _deptcode;//数据分析大屏跳转-只查询本部门数据
        params.beanid = "pmkpi.perfprotrace.query.ProTraceQueryBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params,function(){
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

    //送审情况
    cmp.queryaudit = function (){
        common.auditquery(datatable);
    }

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
        var data = Ext.lt.cloneobj(qfdatas);
        var key = "/pmkpi/program/trace/report";
        common.queryformshow(data, _lefttabtype);
        common.changTooltoolbuttontStatus(0,  _lefthidebtn);
        cmp.setTableColum();
        queryfrom(data,key);
        if(_SYSTEMSTYLE_ == "grey"){
            $("#queryform .searchLeft").css("height","50px");
            queryform.retract();
        }
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
        params.deptcode = _deptcode;//数据分析大屏跳转-只查询本部门数据
        var datalist = Ext.lt.RCP.asyncall(service , "getTreeData", params);
        lefttree.setRecordset(datalist, 0);
        return datalist;
    }

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

    $(function (){
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        common.initDatatable();
        qfdatas = queryform.cfg.data;
        tabChange(_lefttab);
    })

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
        datatable.redraw();
    }

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        Ext.lt.pmkpi.query();
    });

    //审核情况
    cmp.queryaudit = function (){
        common.auditquery(datatable);
    }

    /**
     * 附件上传
     */
    cmp.uploadFile = function(){
        var data = datatable.getSelected();
        var params = {};
        params.filebustype ="traceaudit";
        params.saveAgency = data[0].agencyguid;
        params.mainguid = data[0].guid;
        params.projguid = data[0].proguid;
        params.viewtype = "query";
        var url = "/pmkpi/upload/file/index.page";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"绩效监控附件上传-"+_lefttreename);
    }

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
        var params = {};
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
            params.proguid = data[0].proguid;
        } else if (tasktype && "policytrace" == tasktype) { //重大政策
        }
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
     * 河北导出ftl监控报告
     * @param obj
     */
    cmp.hbexpdoc = function(obj){
        var datas = datatable.getSelected();
        if(!datas || datas.length == 0){
            Ext.lt.ui.alert("请最少选中一条数据！",function(){});
            return;
        }
        var btnconfig = eval('(' + obj.config + ')');
        var _tempate = btnconfig.tempatecode;
        var guids = [];
        for(var i=0;i<datas.length;i++) {
            var _proguid = datas[i]["guid"];
            guids.push(_proguid);
        }
        exportFtlFile(guids, _tempate);
    }

    exportFtlFile = function (guids, templatecode) {
        var idObject = document.getElementById("downloadfileform");
        if (idObject != null){
            idObject.parentNode.removeChild(idObject);
        }
        var url = "/pmkpi/export/hbftl.do?tokenid=" + Ext.lt.token.getTokenid();
        var form=$("<form>");//定义一个form表单
        form.attr("id","downloadfileform");
        form.attr("style","display:none");
        form.attr("target","");
        form.attr("method","post"); //请求类型
        form.attr("action",url); //请求地址
        $("body").append(form);//将表单放置在web中

        var input1=$("<input>");
        input1.attr("type","hidden");
        input1.attr("id","guids");
        input1.attr("name","guids");
        input1.attr("value",guids);
        form.append(input1);

        var input2=$("<input>");
        input2.attr("type","hidden");
        input2.attr("id","templatecode");
        input2.attr("name","templatecode");
        input2.attr("value",templatecode);
        form.append(input2);

        var bobeanid = "pmkpi.perfcommon.expdoc.ExpDocBOTX";
        var input3=$("<input>");
        input3.attr("type","hidden");
        input3.attr("id","bobeanid");
        input3.attr("name","bobeanid");
        input3.attr("value",bobeanid);
        form.append(input3);
        form.submit();
    }

    /**
     * 查看项目明细
     */
    cmp.prodetailed = function (){
        var params = {};
        var data = datatable.getSelected();
        params.submenu = _menuid;
        params.pro_code = data[0].pro_code;
        common.proinfoview(datatable,params);
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

    //监控模板导出
    cmp["expdoc"] = function(btn){
        var datas = datatable.getSelected();
        if(datas.length <= 0){
            Ext.lt.ui.alert("请选择数据！", function () {
            });
            return;
        }
        var btncode = btn.code;
        var btnconfig = eval('(' + btn.config + ')');
        var _tempatecode;
        var reporttype;//导出报告类型，一般监控报告，项目、部门整体报告
        var guids = [];
        var procodes = {};
        var taskstage = "";
        var pro_codes = [];
        var param = {};
        var isreturn = true;
        var alertname = "";
        if (btncode == "ordexpdoc") {
            _tempatecode = btnconfig.tempatecode;
            reporttype = "ordprogram";
            for (var i=0; i<datas.length;i++){
                var data = datas[i];
                var tage = data.taskstage;
                if (data.provincetask == "1") {
                    Ext.lt.ui.alert("请选择一般监控项目进行导出！", function () {
                    });
                    return;
                }
                if (i == 0 || tage == taskstage) {
                    procodes[data["guid"]] = data["pro_code"];
                    pro_codes.push(data["pro_code"]);
                } else {
                    Ext.lt.ui.alert("请选择同一监控阶段的一般监控项目进行导出！", function () {
                    });
                    return;
                }
                taskstage = tage;
            }
            param.procodes = procodes;
            param.pro_codes = pro_codes;
        } else if (btncode == "ahexpdoc" || btncode == "hfexpdoc" || btncode == "ahybexpdoc") {
            if (_lefttabtype == "protrace") {
                _tempatecode = btnconfig.protempatecode;
                reporttype = btnconfig.proexptype;
            } else if (_lefttabtype == "depttrace") {
                _tempatecode = btnconfig.depttempatecode;
                reporttype = btnconfig.deptexptype;
            }
        }
        for (var i=0; i<datas.length;i++){
            var data = datas[i];
            var datatype;
            if (btncode == "ahexpdoc" || btncode == "hfexpdoc") {//重点监控
                datatype = data.provincetask == "1" ? data.provincetask : "0";
                if (datatype == "0") {
                    alertname = "重点";
                    isreturn = false;
                    break;
                }
            } else if(btncode == "ahybexpdoc") {//一般监控
                datatype = data.depttask == "1" ? data.depttask : "0";
                if (datatype == "0") {
                    alertname = "一般";
                    isreturn = false;
                    break;
                }
            }
            guids.push(data["guid"]);
        }
        if (!isreturn) {
            Ext.lt.ui.alert("请选择" + alertname + "监控项目进行导出！", function () {
            });
            return;
        }
        param.taskstage = datas[0].taskstage;
        param.guids = guids;
        param.templatecode = _tempatecode;
        param.exptype = _lefttabtype;
        param.reporttype = reporttype;
        param.bobeanid = "pmkpi.perfprotrace.report.ProTraceTaskBOTX";
        param.rcp = true;
        if (datas.length >= 5) {
            if (Ext.lt.ui.confirm("当前导出数据较多，需时间较长，导出完成后自行关闭进度窗口，是否确认导出！")) {
                Ext.lt.RCPConsole.processdown("pmkpi.perfcommon.expdoc.ExpDocService",'createWord&rcpconsole=process&noserveranalyselog=true',param,"downframe");
                setTimeout(common.colspross_function(1),1000);
            } else {
                return;
            }
        } else {
            param.rcp = false;
            Ext.lt.RCPConsole.processdown("pmkpi.perfcommon.expdoc.ExpDocService",'createWord',param,"downframe");
            var rcpconsole=document.getElementsByClassName('rcpconsole');
            for(i=0;i<rcpconsole.length;i++){
                rcpconsole.item(i).style.display = 'none';
            }
            Ext.lt.ui.loadingClose();
        }
    }

    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        //表配置
        _tablecode = uiconfig.tablecode;
        _defquery = uiconfig.defquery;
    });

    /**
     * 成果查看
     */
    cmp.uploadresults = function (obj) {
        var data = datatable.getSelected();
        if(data.length != 1){
            Ext.lt.ui.alert( "请选择一条数据！",function(){
            });
            return;
        }
        var url = "/pmkpi/protrace/thirdaudit/opinion.page";
        var params = {};
        if (obj.code == "resultsquery") {
            params.viewtype = "query";
        }
        params.mainguid = data[0].guid;
        params.projguid = data[0].proguid;
        params.agency = data[0].agencyguid;
        // params.workflow = data[0].wfid;
        params.wfstatus = data[0].wfstatus;
        params.bustype = _lefttabtype;
        params.taskguid = data[0].taskguid;
        params.pagetype = _lefttabtype;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth, scrHeight,"成果上传");
    }


    /**
     * 批量导出指标完成情况及其他附件
     */
    cmp.indexFileExp = function(obj) {
        var buttonconfig = eval('(' + obj.config + ')');
        var data = datatable.getSelected();
        if(data.length < 1){
            Ext.lt.ui.alert( "请选择数据进行附件导出！",function(){
            });
            return;
        }
        var list = [];
        for (var i = 0; i < data.size(); i++) {
            var params = {};
            params.guid = data[i].guid;//数据id
            params.name = data[i].name;//名称
            params.code = data[i].pro_code;//项目编码
            params.taskstage = data[i].taskname +"1-"+ data[i].taskstage+"月";//监控任务 监控阶段
            params.agency = data[i].agencyguid;//单位
            list.push(params);
        }
        var params = {};
        params.bustype =  _lefttabtype + "traceindexfile" ; // 文件表类型
        params.fileexptype = "trace"; //附件导出类型: 监控
        params.list = list;
        params.tokenid = Ext.lt.token.getTokenid();
        params.zipname = buttonconfig.zipname;
        var ins = Ext.lt.RCP.down("pmkpi.perfcommon.fileexp.FileExpService",'indexFileExp',params,'downframe');
    }

    /**
     * 查看项目资金来源
     */
    cmp.querySourceFund = function (){
        var cols = [];
        cols.push("agencyguid");
        cols.push("proguid");
        cols.push("pro_code");
        var url = "/pmkpi/program/sourcefund.page";
        common.queryDataList(cols, url);
    }

    return cmp;
}