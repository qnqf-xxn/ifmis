if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.perfprogram){
    Ext.lt.pmkpi.perfprogram = {};
}

Ext.lt.pmkpi.perfprogram.protracethirdaudit = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};

    var _menuid = config.menuid,//菜单id
        _lefttreename,//左侧评价对象树名称 默认项目支出
        _lefthidebtn,//左侧树隐藏按钮
        _tabhidtbtn,//右侧页签隐藏按钮
        _leftmenuid,//隐藏菜单
        _lefttab = config.lefttab,//左侧树第一个页签
        _lefttabtype = _lefttab.code,//左侧树页签类型
        _tablecode,
        _workflow,//工作流guid
        _prolev = config.prolev,//项目级次
        _defquery,//列表查询条件
        _tabcode,//页签编码
        _saveAgency,//左侧树选择单位
        _orderby,//排序
        isfirst = true,
        scrWidth = document.body.clientWidth,
        scrHeight = document.body.clientHeight;

    var _displaycols = [];
    var tab_filters = {};//页签过滤条件集合
    var qfdatas;

    $(function(){
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        common.initDatatable();
        qfdatas = queryform.cfg.data;
        tabChange(_lefttab);
        isfirst = false;
    })

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
        params.beanid = "pmkpi.perfprotrace.thirdaudit.ProTraceThirdAuditBOTX";
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
        }
    });

    Ext.lt.pmkpi.audit = function(obj) {
        cmp.wfAudit(obj);
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
        params.type = "third";
        params.datas = datas;
        params.tablecode = _tablecode;
        params.workflow = _workflow;
        params.auditdata = Ext.lt.pmkpi.auditdata;
        params.mainguid = datas[0].guid;
        params.bustype = _lefttabtype;
        params.procode = datas[0].pro_code;
        params.busguid = _leftmenuid + "_" + datas[0].wfstatus;
        common.doAction(obj,params);
    }

    //审核
    cmp.audit = function (obj){
        var data = datatable.getSelected();
        if(data.length != 1){
            Ext.lt.ui.alert( "请选择一条数据进行审核！",function(){
            });
            return;
        }
        var url = "/pmkpi/protrace/thirdaudit/opinion.page";
        var params = {};
        params.guid = data[0].guid;
        params.proguid = data[0].proguid;
        params.agency = data[0].agencyguid;
        params.workflow = data[0].wfid;
        params.wfstatus = data[0].wfstatus;
        params.bustype = _lefttabtype;
        params.taskguid = data[0].taskguid;
        params.pagetype = _lefttabtype;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth, scrHeight,"绩效审核");
    }

    //送审情况
    cmp.queryaudit = function (){
        common.auditquery(datatable);
    }

    /**
     * 审核信息
     */
    cmp.auditinfo = function(){
        var data = datatable.getSelected();
        if(data.length != 1){
            Ext.lt.ui.alert( "请选择一条数据进行查看！",function(){
            });
            return;
        }
        var params = {};
        params.workflow = _workflow;
        params.wfstatus = data[0].wfstatus;
        var nodemap = Ext.lt.RCP.asyncall(service , "queryAuditType", [_workflow, data[0].wfstatus]);
        params.nodeguid = nodemap.nodeguid;
        params.audittype = nodemap.audittype;
        if (!nodemap.audittype || nodemap.audittype == "" || nodemap.audittype == "null") {
            Ext.lt.ui.alert( "请对流程审核节点进行配置！",function(){
            });
            return;
        }
        params.agency = data[0].agencyguid;
        params.guid = data[0].guid;
        url = "/pmkpi/audit/index/" + nodemap.audittype + ".page";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth, scrHeight,"审核信息");
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

    Ext.lt.message.hook("perfcommon", "auditquery",function(){
        Ext.lt.pmkpi.query();
        try {
            Ext.lt.ui.closeModalWindow();
        } catch (e) {
            try {
                Ext.lt.ui.modalWindow.close();
            }catch(e){

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
     * 问题整改
     */
    cmp.rectify = function(){
        var params = {};
        params.pagename = '监控整改';
        params.type = 'TRACE';
        if (_lefttabtype == "protrace") { //项目支出
            params.workflow = 'BD057E3C39B96759E053B11FA8C06040';
            params.bustype = '1';
            params.tablecode = "V_PERF_PROJECT_INFO";
        } else if ( _lefttabtype == "depttrace") { //部门整体
            params.workflow = 'BD53404301784449E053B11FA8C0DF9A';
            params.bustype = '3';
            params.tablecode = "V_PERF_T_DEPTPERFDECLARE";
        }
        common.rectify(datatable, params)
    }

    /**
     * 成果上传
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
        params.proguid = data[0].proguid;
        params.agency = data[0].agencyguid;
        params.workflow = data[0].wfid;
        params.wfstatus = data[0].wfstatus;
        params.bustype = _lefttabtype;
        params.taskguid = data[0].taskguid;
        params.pagetype = _lefttabtype;
        params.procode = data[0].pro_code;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth, scrHeight,"成果上传");
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
        params.workflow = _workflow;
        params.proguid = data[0].proguid;
        params.procode = data[0].pro_code;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth, scrHeight,"绩效监控申报-"+_lefttreename);
    }

    Ext.lt.message.hook("datatable", "drawed",function(obj){
        var uiconfig = obj.uiconfig;
        //表配置
        _tablecode = uiconfig.tablecode;
        _defquery = uiconfig.defquery;
    });

    cmp.getResult = function (obj) {
        var datas = datatable.getSelected();
        if(datas.length <= 0){
            Ext.lt.ui.alert("请选中至少一条数据进行获取数据！",function(){});
            return;
        }
        Ext.lt.ui.confirm('是否获取已选中项目数据？', {icon: "warn"}, function (is) {
            if (is) {
                Ext.lt.ui.loadingShow();
                var params = {};
                params.datas = datas;
                params.evalType = "01";
                Ext.lt.RCP.call(service, "getResult", params, function (rs) {
                    Ext.lt.ui.loadingClose();
                    if (rs && rs.success) {
                        Ext.lt.ui.alert('获取数据完成！', function () {
                            cmp.query();
                        });
                    }else{
                        Ext.lt.ui.loadingClose();
                        Ext.lt.ui.alert(rs.error,function(){});
                    }
                }, function(rs) {
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert("获取数据失败:" + rs,function(){
                    });
                });
            }
        })
    }

    return cmp;
}