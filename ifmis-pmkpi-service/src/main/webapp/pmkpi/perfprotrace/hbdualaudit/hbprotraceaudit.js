if (!Ext.lt.pmkpi) {
    Ext.lt.pmkpi = {};
}
if (!Ext.lt.pmkpi.perfprogram) {
    Ext.lt.pmkpi.perfprogram = {};
}

Ext.lt.pmkpi.perfprogram.protraceaudit = function (config, service) {
    var deptcmp = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};

    var _menuid = config.menuid,//菜单id
        _proworkflow = config.proworkflow,//项目工作流guid
        _deptworkflow = config.deptworkflow,//部门工作流guid
        _audittrace = config.audittrace,
        _tablecode,
        _datasource,//数据源集合
        _workflow,//工作流guid
        _prolev = config.prolev,//项目级次
        _deptcoldatas = config.deptcoldatas,//部门列数据
        _depttabledata = config.depttabledata,//部门表数据
        _deptqfdatas = config.deptqfdatas,//部门查询区数据
        _proqfdatas = config.proqfdatas,//项目查询区数据
        _procoldatas = config.procoldatas,//项目列数据
        _protabledata = config.protabledata,//项目表数据
        _lefttreename = "项目支出",//左侧评价对象树名称 默认项目支出
        _lefttabtype = "protrace",//左侧树页签guid 默认项目支出
        _bustype,
        _defquery,//列表查询条件
        _tabfilter,//页签查询条件
        _tabcode,//页签编码
        _saveAgency,//左侧树选择单位
        _orderby,//排序
        isfirst = true,
        _tempatecode = config.tempatecode,//导出报告模板code
        scrWidth = document.body.clientWidth,
        scrHeight = document.body.clientHeight;

    Ext.lt.pmkpi.query = function () {
        if (!_saveAgency) {
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
        params.isleaf = Ext.lt.pmkpi.isleaf + "";
        params.tabfilter = _tabfilter;
        params.workflow = _workflow;
        params.tasktype = _lefttabtype;
        deptcmp.setColDatasource(_datasource, datatable);
        params.beanid = "pmkpi.perfprotrace.audit.ProTraceHbDualAuditBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params, function () {
            Ext.lt.ui.loadingClose();
        });
    }

    /**
     * 左侧树点击
     */
    Ext.lt.message.hook("left", "click", function (obj) {
        var treeNode = obj.node.data;
        if (treeNode) {
            _saveAgency = treeNode.guid;
            Ext.lt.pmkpi.isleaf = treeNode.isleaf;
        } else {
            _saveAgency = "treeroot";
            Ext.lt.pmkpi.isleaf = '0';
        }
        Ext.lt.pmkpi.query();
    });

    Ext.lt.message.hook("datatable", "beforesetcols", function (obj) {
        var uiconfig = obj.table.uiconfig;
        var config = obj.table.config;
        _tablecode = uiconfig.tablecode;
        _defquery = uiconfig.defquery;
        _orderby = uiconfig.orderby;
        var cols = obj.cols;
        if (!Ext.lt.isArray(cols))
            cols = [cols];
        for (var i = 0; i < cols.length; i++) {
            var col = cols[i];
            if (col["colcode"] == "pro_name") {
                col.fn = function (l, c, data, col) {
                    return "<a herf='#' style='color:#468ac9'>" + data.name + "</a>";
                }
                col.onclick = function (td, el, l, c, d) {
                    var params = {};
                    var url = "";
                    if (_lefttabtype && "protrace" == _lefttabtype) { //项目支出
                        if (d.provincetask == "1") {
                            url = "/pmkpi/program/trace/report/edit.page";
                        } else {
                            url = "/pmkpi/program/trace/report/ordinaryedit.page";
                        }
                    } else if (_lefttabtype && "depttrace" == _lefttabtype) { //部门整体
                        url = "/pmkpi/trace/report/deptedit.page";
                    } else if (_lefttabtype && "policytrace" == _lefttabtype) { //重大政策
                    }
                    params.saveAgency = d.agencyguid;
                    params.taskguid = d.taskguid;//监控任务guid
                    params.prolev = _prolev;
                    params.bustype = _lefttabtype;
                    params.mainguid = d.guid;
                    params.agency = d.agencyguid;
                    params.viewtype = "query";
                    params.workflow = _workflow;
                    params.projguid = d.proguid;
                    url = Ext.lt.pmkpi.genPageUrl(url, params);
                    Ext.lt.ui.openModalWindow(url, scrWidth, scrHeight, "绩效监控信息-" + _lefttreename);
                };
            }
            if (col["colcode"] == "warndays") {
                col.cseditfn = function(i,j,rs, style){ //列的单元格样式.
                    style = 'style="text-align:center;"';
                    return style;
                }
                col.fn = function (l, c, data, col) {
                    if (data.warn == "red") {
                        return "<a style='color:#FF0000'>" + data.warndays + "</a>";
                    } else if (data.warn == "000") {
                        return "<a style='color:#FF0000'>已超时</a>";
                    } else if (data.warndays) {
                        return "<a>" + data.warndays + "</a>";
                    }
                }
            }

            if (col["colcode"] == "bgtwarn") { //目标值构建符号和单位
                col.cseditfn = function (i, j, rs, style) { //列的单元格样式.
                    style = 'style="text-align:center;"';
                    return style;
                }
                col.fn = function (l, c, data, val) {
                    var warn = !data.bgtwarn ? "" : data.bgtwarn;
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

            if (col["colcode"] == "goalwarn") { //目标值构建符号和单位
                col.cseditfn = function (i, j, rs, style) { //列的单元格样式.
                    style = 'style="text-align:center;"';
                    return style;
                }
                col.fn = function (l, c, data, val) {
                    var warn = !data.goalwarn ? "" : data.goalwarn;
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

    Ext.lt.pmkpi.audit = function (obj) {
        cmp.wfAudit(obj);
    }

    //送审/审核
    cmp.wfAudit = function (obj) {
        var actionname = obj.name;
        var datas = datatable.getSelected();
        if (datas.length <= 0) {
            Ext.lt.ui.alert("请选择要" + actionname + "的数据！", function () {
            });
            return;
        }
        if (!deptcmp.checkwfstatus(datas)) return false;//先校验审核状态是否一致
        var params = {};
        params.datas = datas;
        params.tablecode = _tablecode;
        params.workflow = _workflow;
        params.auditdata = Ext.lt.pmkpi.auditdata;
        params.mainguid = datas[0].guid;
        params.busguid = _lefttabtype + _audittrace + "_" + datas[0].wfstatus;
        deptcmp.doAction(obj, params);
    }

    //审核
    cmp.audit = function (obj) {
        var data = datatable.getSelected();
        if (data.length != 1) {
            Ext.lt.ui.alert("请选择一条数据进行审核！", function () {
            });
            return;
        }
        var url = "/pmkpi/audit/view.page";
        var params = {};
        params.guid = data[0].guid;
        params.projguid = data[0].proguid;
        params.agency = data[0].agencyguid;
        params.workflow = data[0].wfid;
        params.wfstatus = data[0].wfstatus;
        params.bustype = _lefttabtype;
        params.taskguid = data[0].taskguid;
        params.pagetype = _lefttabtype;
        var _uikey = "";
        if (_lefttabtype && "protrace" == _lefttabtype) { //项目支出
            if (data[0].provincetask == "1") {
                _uikey = "/pmkpi/program/trace/report/edit";
            } else {
                _uikey = "/pmkpi/program/trace/report/ordinaryedit";
            }
        } else if (_lefttabtype && "depttrace" == _lefttabtype) { //部门整体
            _uikey = "/pmkpi/trace/report/deptedit";
        } else if (_lefttabtype && "policytrace" == _lefttabtype) { //重大政策
        }
        params.uikey = _uikey;
        var nodemap = Ext.lt.RCP.asyncall(service, "queryPrevAuditType", [data[0].wfid, data[0].wfstatus]);
        params.nodeguid = nodemap.nodeguid;
        params.audittype = nodemap.audittype;
        if (!nodemap.audittype || nodemap.audittype == "" || nodemap.audittype == "null") {
            Ext.lt.ui.alert("请对流程审核节点进行配置！", function () {
            });
            return;
        }
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth, scrHeight, "绩效审核");
    }

    //送审情况
    cmp.queryaudit = function () {
        deptcmp.auditquery(datatable);
    }

    /**
     * 审核信息
     */
    cmp.auditinfo = function () {
        var data = datatable.getSelected();
        if (data.length != 1) {
            Ext.lt.ui.alert("请选择一条数据进行查看！", function () {
            });
            return;
        }
        var params = {};
        params.workflow = _workflow;
        params.wfstatus = data[0].wfstatus;
        var nodemap = Ext.lt.RCP.asyncall(service, "queryAuditType", [_workflow, data[0].wfstatus]);
        params.nodeguid = nodemap.nodeguid;
        params.audittype = nodemap.audittype;
        if (!nodemap.audittype || nodemap.audittype == "" || nodemap.audittype == "null") {
            Ext.lt.ui.alert("请对流程审核节点进行配置！", function () {
            });
            return;
        }
        params.agency = data[0].agencyguid;
        params.guid = data[0].guid;
        url = "/pmkpi/audit/index/" + nodemap.audittype + ".page";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth, scrHeight, "审核信息");
    }

    //页签方法
    cmp.clickTabpage = function (obj) {
        deptcmp.changTooltoolbuttontStatus(0, obj.hidebtns);// 隐藏按钮，推荐使用此方法
        _tabfilter = obj.filter;
        _tabcode = obj.code;
        if (!isfirst) {
            Ext.lt.pmkpi.query();
        }
    }

    Ext.lt.message.hook("perfcommon", "auditquery", function () {
        Ext.lt.pmkpi.query();
        try {
            Ext.lt.ui.closeModalWindow();
        } catch (e) {
            Ext.lt.ui.modalWindow.close();
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
        var data;
        var key;
        var cols;
        if (_lefttabtype == "protrace") {
            _defquery = _protabledata.defquery;
            _tablecode = _protabledata.tablecode;
            cols = _procoldatas;
            data = _proqfdatas;
            _bustype = '1';
            key = '/pmkpi/program/trace/report';
            _workflow = _proworkflow;
        } else if (_lefttabtype == "depttrace") {
            _defquery = _depttabledata.defquery;
            _tablecode = _depttabledata.tablecode;
            key = '/pmkpi/trace/report/dept';
            _bustype = '2';
            cols = _deptcoldatas;
            data = _deptqfdatas;
            _workflow = _deptworkflow;
            // deptcmp.changTooltoolbuttontStatus(0, "发起监控整改");
            // deptcmp.changTooltoolbuttontStatus(0, "发起目标调整");
        }
        var params = {};
        params.tablecode = _tablecode;
        params.cols = cols;
        try {
            _datasource = Ext.lt.RCP.asyncall(service, "getDataSource", params);
            deptcmp.setColMapper(cols);
        } catch (e) {
        }
        cmp.setTableColum(cols);
        deptcmp.setworkflow(_workflow);
        queryfrom(data, key);
        Ext.lt.pmkpi.querytree();
        Ext.lt.pmkpi.query();
    }

    Ext.lt.pmkpi.querytree = function () {
        var params = {};
        params.menuid = _menuid;
        params.tablecode = _tablecode;
        params.tasktype = _lefttabtype;
        var datalist = Ext.lt.RCP.asyncall(service, "getTreeData", params);
        lefttree.setRecordset(datalist, 0);
    }

    function queryfrom(data, key) {
        var configqueryform = {
            id: "queryform",
            fastquery: true,
            datatable: 'datatable',
            drawmode: 'div',
            key: key,
            label: "快速查询",
            labelwidth: "120",
            appid: "pmkpi",
            config: null,
            serverid: key,
            amtmaxlength: 18,
            columnsize: 5,
            data: data
        }
        queryform = new Ext.lt.bus.ui.querypanel(configqueryform);
        queryform.draw($(".busquerypanel_outline")[0]);
    }

    $(function () {
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        deptcmp.initDatatable();
        isfirst = false;
        var params = {};
        params.ordernum = 0;
        params.code = _lefttabtype;
        params.name = _lefttreename;
        tabChange(params);
    })

    /**
     * 动态配置表格的列.
     *
     * @param data --
     */
    cmp.setTableColum = function (cols) {
        var c = [];
        var tmainCol = datatable.getCols();
        c.push(tmainCol[0]);
        c.push(tmainCol[1]);
        for (var i = 0; i < cols.length; i++) {
            c.push(cols[i]);
        }
        datatable.setCols(c);
        var h = $("#queryform .busquerypanel").height();
        var buttonH = $('.busnomalbtn_outline').height();
        var tableh = scrHeight - h - buttonH - 20;
        datatable.resize(scrWidth, tableh);
        datatable.headsort(false);
        datatable.setAllowcustom(false);
        datatable.setAllowClock(false);
        var page = {};//datatable.getPage();
        page.columns = "*";
        datatable.setPage(page);
        datatable.setSelfdefconfig({config: "{}"});
        datatable.redraw();
        Ext.lt.message.send("datatable", 'beforesetcols', {
            table: datatable,
            cols: cols
        });
    }

    Ext.lt.message.hook("queryform", "doquery", function (obj) {
        Ext.lt.pmkpi.query();
    });

    cmp.expdoc = function (obj) {
        obj.config = "{tempatecode:'" + _tempatecode + "'}";
        Ext.lt.pmkpi.expdoc(obj, datatable);
    }

    /**
     * 问题整改
     */
    cmp.rectify = function () {
        var params = {};
        params.pagename = '监控整改';
        params.type = 'TRACE';
        if (_lefttabtype == "protrace") { //项目支出
            params.workflow = 'BD057E3C39B96759E053B11FA8C06040';
            params.bustype = '1';
            params.tablecode = "V_PERF_PROJECT_INFO";
        } else if (_lefttabtype == "depttrace") { //部门整体
            params.workflow = 'BD53404301784449E053B11FA8C0DF9A';
            params.bustype = '3';
            params.tablecode = "V_PERF_T_DEPTPERFDECLARE";
        }
        deptcmp.rectify(datatable, params)
    }

    //修改
    cmp.addOredit = function () {
        var data = datatable.getSelected();
        if (!data || data.length != 1) {
            Ext.lt.ui.alert("请选中一条数据进行修改！", function () {
            });
            return;
        }
        var tasktype = data[0].tasktype;//任务类型 项目/部门
        var params = {};
        params.saveAgency = data[0].agencyguid;
        params.mainguid = data[0].guid;
        params.projguid = data[0].proguid;
        params.taskguid = data[0].taskguid;//监控任务guid
        params.workflow = _workflow;
        params.prolev = _prolev;
        params.bustype = _lefttabtype;
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
        Ext.lt.ui.openModalWindow(url, scrWidth, scrHeight, "绩效监控审核-" + _lefttreename);
    }

    //导出
    cmp.export = function () {
        if (datatable.getRecordset().size() != 0) {
            var data = datatable.getSelected();
            var cfg = {};
            if (_lefttabtype == "protrace") {
                cfg.key = '/pmkpi/adjust/report/program';
            } else if (_lefttabtype == "depttrace") {
                cfg.key = '/pmkpi/adjust/report/dept';
            }
            cfg.bustable = datatable;
            if (data.size() == 0) {
                alert("请选择数据进行导出！");
                return;
                // if (Ext.lt.ui.confirm("是否导出当前全部数据？")) {
                //     cfg.hassql = 1;
                //     cfg.beanid = "pmkpi.perfprotrace.audit.ProTraceAuditBOTX";
                //     if (typeof (queryform) != 'undefined') {
                //         cfg.isHaveQueryForm = true;//是否有查询区
                //         cfg.queryConfig = queryform.getQueryParam();//查询区条件
                //     }
                //     cfg.isHaveTabPage = true;
                //     cfg.filter = " 1=1 ";
                //     cfg.downtype = 'xls';
                //     dataexport.excelexport(cfg);
                // } else {
                //     return;
                // }
            } else {
                cfg.downtype = 'xls';//下载  类型
                dataexport.excelexport(cfg);
            }
        } else {
            Ext.lt.ui.alert("页面无数据！", {timeout: 1}, function () {
            });
            return;
        }
    }

    //发起目标调整
    cmp.adjustTarget = function () {
        var data = datatable.getSelected();
        if (!data || data.length == 0) {
            Ext.lt.ui.alert("请选中一条数据进行目标调整！", function () {
            });
            return;
        }
        var params = {};
        params.data = data;
        var nodemap = Ext.lt.RCP.asyncall(service, "adjustTarget", params);
        alert(nodemap.message);
    }

    //发起监控整改
    cmp.monRect = function () {
        var data = datatable.getSelected();
        if (!data || data.length == 0) {
            Ext.lt.ui.alert("请选中一条数据进行监控整改！", function () {
            });
            return;
        }
        var params = {};
        params.data = data;
        params.rectifyWfid = "BD057E3C39B96759E053B11FA8C06040"; //   PERF_T_RECTIFY   表流程id
        params.bustype = _bustype;
        var nodemap = Ext.lt.RCP.asyncall(service, "monRect", params);
        alert(nodemap.message);
    }

    return cmp;
}