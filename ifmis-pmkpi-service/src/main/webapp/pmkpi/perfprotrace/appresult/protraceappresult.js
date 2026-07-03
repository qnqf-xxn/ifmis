if (!Ext.lt.pmkpi) {
    Ext.lt.pmkpi = {};
}
if (!Ext.lt.pmkpi.perfprogram) {
    Ext.lt.pmkpi.perfprogram = {};
}
Ext.lt.pmkpi.perfprogram.protraceappresult = function (config, service) {
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
        scrWidth = document.body.clientWidth,
        scrHeight = document.body.clientHeight;
    var _displaycols = [];
    var qfdatas;

    Ext.lt.pmkpi.query = function () {
        if (!_saveAgency) {
            _saveAgency = "treeroot";
            Ext.lt.pmkpi.isleaf = 0;
        }
        Ext.lt.ui.loadingShow();
        var params = {};
        params.queryConfig = queryform.getQueryParam();
        var querySql = queryform.getQuerySQL();
        //特殊处理
        if (querySql.include("WFSTATUS= '999'")) {
            querySql = querySql.replace("WFSTATUS= '999'", "WFSTATUS is null")
        }
        params.querySql = querySql;
        params.tablecode = _tablecode;
        params.tablesql = _defquery;
        params.menuid = _menuid;
        params.tabcode = _tabcode;
        params.prolev = _prolev;
        params.saveAgency = _saveAgency;
        params.isleaf = Ext.lt.pmkpi.isleaf + "";
        params.tabfilter = _tabfilter;
        params.tasktype = _lefttabtype;
        params.leftmenuid = _leftmenuid;
        params.deptwfststus = _deptwfststus;
        params.jxwfststus = _jxwfststus;
        params.beanid = "pmkpi.perfprotrace.appresult.ProTraceAppResultBOTX";
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
            if (col["colcode"] == "wfstatus" || col["colcode"] == "finintorgguid" || col["colcode"] == "taskstage"
                || col["colcode"] == "depttask" || col["colcode"] == "provincetask") {
                col.fn = function (l, c, data, col) {
                    var index = col.indexOf("-");
                    var colData = col.substring(index + 1);
                    return colData;
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
        common.changTooltoolbuttontStatus(0, _lefthidebtn);
        cmp.setTableColum();
        queryfrom(data, key);
        var treedatas = Ext.lt.pmkpi.querytree();
        Ext.lt.pmkpi.query();
        obj.datas = treedatas;
        return obj;
    }

    Ext.lt.pmkpi.querytree = function () {
        var params = {};
        params.menuid = _menuid;
        params.tablecode = _tablecode;
        params.tasktype = _lefttabtype;
        params.leftmenuid = _leftmenuid;
        var datalist = Ext.lt.RCP.asyncall(service, "getTreeData", params);
        lefttree.setRecordset(datalist, 0);
        return datalist;
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
        common.initDatatable();
        qfdatas = queryform.cfg.data;
        tabChange(_lefttab);
    })

    /**
     * 动态配置表格的列.
     *
     * @param data --
     */
    cmp.setTableColum = function (cols) {
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

    Ext.lt.message.hook("queryform", "doquery", function (obj) {
        Ext.lt.pmkpi.query();
    });

    Ext.lt.message.hook("datatable", "beforesetcols", function (obj) {
        var uiconfig = obj.table.uiconfig;
        //表配置
        _tablecode = uiconfig.tablecode;
        _defquery = uiconfig.defquery;
    });

    /**
     * 查看明细
     */
    cmp.detailed = function () {
        var data = datatable.getSelected();
        if (!data || data.length != 1) {
            Ext.lt.ui.alert("请选中一条数据进行查看！", function () {
            });
            return;
        }
        var tasktype = data[0].tasktype;//任务类型 项目/部门/政策
        var provincetask = data[0].provincetask;
        var url = "";
        if (_lefttabtype && "protrace" == _lefttabtype) { //项目支出
            if (provincetask && provincetask == "1") {
                url = "/pmkpi/program/trace/report/edit.page";
            } else {
                url = "/pmkpi/program/trace/report/ordinaryedit.page";
            }
        } else if (_lefttabtype && "depttrace" == _lefttabtype) { //部门整体
            url = "/pmkpi/trace/report/deptedit.page";
        } else if (_lefttabtype && "policytrace" == _lefttabtype) { //重大政策
        }
        var params = {};
        params.saveAgency = data[0].agencyguid;
        params.taskguid = data[0].taskguid;//监控任务guid
        params.prolev = _prolev;
        params.bustype = _lefttabtype;
        params.mainguid = data[0].guid;
        params.agency = data[0].agencyguid;
        params.viewtype = "query";
        params.proguid = data[0].proguid;
        params.projguid = data[0].proguid;
        params.procode = data[0].pro_code;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth, scrHeight, "绩效监控申报-" + _lefttreename);
    }

    /**
     * 查看项目明细
     */
    cmp.showProjView = function (obj) {
        var params = {};
        var data = datatable.getSelected();
        params.submenu = _menuid;
        params.pro_code = data[0].pro_code;
        common.proinfoview(datatable, params);
    }

    /**
     * 导入指标
     * @param obj
     */
    cmp.import = function (obj) {
        var importcode = "";
        var vchtypeid = "";
        var tokenid = Ext.lt.getparam("tokenid");
        // 暂时写死导入模板的code
        if (_lefttabtype == "protrace") { //项目支出
            importcode = "pmkpi_protraceappresult";
            vchtypeid = "EED47FE19ABC0202E0533315A8C02FDB";
        } else if (_lefttabtype == "depttrace") { //部门整体
            importcode = "pmkpi_depttraceappresult";
            vchtypeid = "EED47FE19ABB0202E0533315A8C02FDB";
        }
        // 调用导入接口，需要参数有tokenid,模板编码，单据id，args组合传给后台的参数
        var params = {};
        params.vchtypeid = vchtypeid;
        params.pagetype = "add";
        params.bustype = _lefttabtype;
        window.importparam = params;
        Ext.lt.importdata.imports(tokenid, importcode, vchtypeid, Object.toJSON(params), function () {
            window.parent.Ext.lt.outfile.window.close();
            window.parent.Ext.lt.pmkpi.query();
            parent.Ext.lt.pmkpi.impsucess();
        });

    }

    return cmp;
}