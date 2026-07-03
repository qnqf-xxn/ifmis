if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.perfprotrace){
    Ext.lt.pmkpi.perfprotrace = {};
}

Ext.lt.pmkpi.perfprotrace.protracetask = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};

    var _menuid = config.menuid,//菜单id
        _lefttreename,//左侧评价对象树名称 默认项目支出
        _lefthidebtn,//左侧树隐藏按钮
        _tabhidtbtn,//右侧页签隐藏按钮
        _leftmenuid,//隐藏菜单
        _lefttab = config.lefttab,//左侧树第一个页签
        _lefttabtype = _lefttab.code,//左侧树页签类型
        _deptwfststus = config.deptwfststus,//一般监控终审状态
        _jxwfststus = config.jxwfststus,//一般监控终审状态
        _tablecode,
        _workflow,//工作流guid
        _prolev = config.prolev,//项目级次
        _defquery,//列表查询条件
        _tabcode,//页签编码
        _saveAgency,//左侧树选择单位
        scrWidth = document.body.clientWidth,
        scrHeight = document.body.clientHeight;
    var isfirst = true;
    var _displaycols = [];
    var tab_filters = {};//页签过滤条件集合
    var qfdatas;

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
        params.tablesql = _defquery;
        params.menuid = _menuid;
        params.tabcode = _tabcode;
        params.prolev = _prolev;
        params.saveAgency = _saveAgency;
        params.isleaf = Ext.lt.pmkpi.isleaf+"";
        params.tabfilter = tab_filters[_lefttabtype + "_" + _tabcode];
        params.workflow = _workflow;
        params.tasktype = _lefttabtype;
        params.leftmenuid = _leftmenuid;
        params.deptwfststus = _deptwfststus;
        params.jxwfststus = _jxwfststus;
        params.beanid = "pmkpi.perfprotrace.report.ProTraceTaskBOTX";
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
     * 填报/修改
     */
    cmp.addOredit = function (){
        var data = datatable.getSelected();
        if(!data || data.length != 1){
            Ext.lt.ui.alert("请选中一条数据进行填报/修改！",function(){});
            return;
        }
        var tasktype = data[0].tasktype;//任务类型 项目/部门/政策
        var params = {};
        params.saveAgency = data[0].agencyguid;
        params.mainguid = data[0].guid;
        params.proguid = data[0].proguid;
        params.projguid = data[0].proguid;
        params.taskguid = data[0].taskguid;//监控任务guid
        params.procode = data[0].pro_code;
        //params.pro_name = data[0].name; //文件名带“--”导致填报页空白问题
        params.workflow = _workflow;
        params.prolev = _prolev;
        params.bustype = _lefttabtype;
        params.ismarkpro = data[0].ismarkpro;
        params.taskstage = data[0].taskstage;
        var url = "";
        if (tasktype && "protrace" == tasktype) { //项目支出
            if (data[0].provincetask == "1") {
                url = "/pmkpi/program/trace/report/edit.page";
            } else {
                url = "/pmkpi/program/trace/report/ordinaryedit.page";
            }
        } else if (tasktype && "depttrace" == tasktype) { //部门整体
            url = "/pmkpi/trace/report/deptedit.page";
        } else if (tasktype && "policytrace" == tasktype) { //重大政策
        }
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"绩效监控申报-"+_lefttreename);
    }

    //送审/审核
    cmp.wfAudit = function (obj){
        var datas = datatable.getSelected();
        if (datas.length <= 0) {
            Ext.lt.ui.alert("请选择要" + obj.name + "的数据！",function(){});
            return;
        }
        var wfstatus;
        for (var i=0; i < datas.length; i++) {
             wfstatus = datas[i].wfstatus;
            if (!wfstatus || wfstatus == "") {
                Ext.lt.ui.alert("请选择申报/填报状态的数据送审！",function(){});
                return;
            }
        }
        if (!wfstatus || wfstatus == "") {
            Ext.lt.ui.alert("请完善基本信息后送审数据！",function(){});
            return;
        }
        var preprovincetask;
        for (var i = 0,leni = datas.length; i < leni; i++) {
            if(!preprovincetask){
                preprovincetask = datas[i].provincetask;
            }
            if(preprovincetask != datas[i].provincetask){
                Ext.lt.ui.alert("所选择列表数据的监控类型不一致！",{timeout:1},function(){});
                return;
            }
        }
        if (!common.checkwfstatus(datas)) return false;//先校验审核状态是否一致
        var params = {};
        params.datas = datas;
        params.tablecode = _tablecode;
        params.bustype = _lefttabtype;
        params.busguid = _leftmenuid + "_" + datas[0]["wfstatus"];
        // 校验页签参数
        var tasktype = datas[0].tasktype;//任务类型 项目/部门/政策
        params.checktable = "V_PERF_T_PROMONITOR";
        if (tasktype && "protrace" == tasktype && datas[0].provincetask=="1") { //项目支出
            params.checkkey = "/pmkpi/program/trace/report/edit";  // 重点监控
        } else if (tasktype && "protrace" == tasktype && datas[0].depttask=="1" ){
            params.checkkey = "/pmkpi/program/trace/report/ordinaryedit";   // 一般监控
        } else if (tasktype && "depttrace" == tasktype) { //部门整体COMPUTETYPE
            params.checkkey = "/pmkpi/trace/report/deptedit";
        }
        if (obj.code == "sendaudit" && !common.checkTabPageData(params)) return false;//先校验
        common.doAction(obj, params);
    }

    //送审情况
    cmp.queryaudit = function (){
        common.auditquery(datatable);
    }

    //页签方法
    cmp.clickTabpage = function(obj){
        _tabhidtbtn = obj.hidebtns;
        var tabconfig = eval('(' + obj.config + ')');
        tab_filters[_lefttabtype + "_" + obj.code] = tabconfig[_lefttabtype + "filter"];
        _tabcode = obj.code;
        if (!isfirst) {
            common.changTooltoolbuttontStatus(0, _tabhidtbtn + "," + _lefthidebtn);
            Ext.lt.pmkpi.query();
        }
    }

    /**
     * 左侧页签切换触发函数.
     */
    tabChange = function (obj) {
        _saveAgency = "treeroot";
        Ext.lt.pmkpi.isleaf = '0';
        _lefttabtype = obj["code"];
        _lefttreename = obj["name"];
        _workflow = obj.leftwfid;
        _lefthidebtn = obj.hidebtns;
        _leftmenuid = obj.leftmenuid;
        var data = Ext.lt.cloneobj(qfdatas);
        var key = "/pmkpi/program/trace/report";
        common.queryformshow(data, _lefttabtype);
        cmp.setTableColum();
        common.setworkflow(_workflow);
        common.setTabNum(obj);
        queryfrom(data,key);
        if(_SYSTEMSTYLE_ == "grey"){
            $("#queryform .searchLeft").css("height","50px");
            queryform.retract();
        }
        common.changTooltoolbuttontStatus(0,  _lefthidebtn + "," + _tabhidtbtn);
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
        var _lefttab = lefttree.getActiveTabCfg();
        //查询之前处理待送审，还是被退回页签
        common.pendingtasktab();
        qfdatas = queryform.cfg.data;
        tabChange(_lefttab);
        isfirst = false;
    })

    /**
     * 动态配置表格的列.
     *
     * @param data --
     */
    cmp.setTableColum = function(){
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
        var page = {};
        page.columns = "*";
        datatable.setPage(page);
        datatable.setSelfdefconfig({config: "{}"});
        datatable.redraw();
    }

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        Ext.lt.pmkpi.query();
    });

    Ext.lt.message.hook("perfcommon", "auditquery",function(){
        Ext.lt.pmkpi.query();
    });

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
        params.workflow = _workflow;
        params.projguid = data[0].proguid;
        params.procode = data[0].pro_code;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth, scrHeight,"绩效监控申报-"+_lefttreename);
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

    Ext.lt.message.hook("datatable", "drawed",function(obj){
        var uiconfig = obj.uiconfig;
        //表配置
        _tablecode = uiconfig.tablecode;
        _defquery = uiconfig.defquery;
    });

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

    //监控导入
    cmp["impdoc"] = function(btn){
        var btncode = btn.code;
        var btnconfig = eval('(' + btn.config + ')');
        var params = {};
        var datas;
        var impexpcode;
        if (btncode == "ordimpdoc") {
            datas = datatable.getRecordSet().toArray();
            params.iscol = "true";
            impexpcode = btnconfig.impexpcode;
        } else if (btncode == "ahimpdoc" || btncode == "hfimpdoc" || btncode == "ahybimpdoc") {
            datas = datatable.getSelected();
            if (!datas || datas.length != 1) {
                Ext.lt.ui.alert("请选择一条数据进行导入！", function () {
                });
                return ;
            }
            var data = datas[0];
            var datatype;
            if (btncode == "ahimpdoc" || btncode == "hfimpdoc") {//重点监控
                datatype = data.provincetask == "1" ? data.provincetask : "0";
                if (datatype == "0") {
                    Ext.lt.ui.alert("请选择重点监控项目进行导入！", function () {
                    });
                    return;
                }
            } else if(btncode == "ahybimpdoc") {//一般监控
                datatype = data.depttask == "1" ? data.depttask : "0";
                if (datatype == "0") {
                    Ext.lt.ui.alert("请选择一般监控项目进行导入！", function () {
                    });
                    return;
                }
            }
            if (_lefttabtype == "protrace") {
                impexpcode = btnconfig.protempatecode;
            } else if (_lefttabtype == "depttrace"){
                impexpcode = btnconfig.depttempatecode;
            }
            params.datatype = datatype;
            params.mainguid = data.guid;
            params.taskstage = data.taskstage;
            params.agencyguid = data.agencyguid;
            params.impreporttype = btnconfig.impreporttype;
        }
        if (datas && datas.length > 0){
            params.impexpcode = impexpcode;
            params.beanid = "pmkpi.perfprotrace.report.ProTraceTaskBOTX";
            params.isShowExpBtn = "false";
            params.imptype = "reportimp";//导入类型，xml报告导入
            params.wfstatus = datas[0].wfstatus;//流程数据状态
            params.workflow = _workflow;
            params.leftmenuid = _leftmenuid;
            params.impServicetype = btnconfig.impServicetype;//导入业务类型，一般监控导入，模板报告导入
            params.lefttabtype = _lefttabtype;
            impexp.imp(params, function (){
                window.parent.Ext.lt.outfile.window.close();
                parent.Ext.lt.ui.alert("导入成功！", function () {
                    parent.Ext.lt.pmkpi.query();
                });
            });
        } else {
            if (btncode == "ordimpdoc") {
                Ext.lt.ui.alert("当前没有可导入的项目！", function () {
                });
            } else {
                Ext.lt.ui.alert("请选择要导入的项目！", function () {
                });
            }
        }
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