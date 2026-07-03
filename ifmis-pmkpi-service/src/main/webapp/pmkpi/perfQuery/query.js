if (!Ext.lt.pmkpi) {
    Ext.lt.pmkpi = {};
}

if (!Ext.lt.pmkpi.perfQuery) {
    Ext.lt.pmkpi.perfQuery = {};
}

Ext.lt.pmkpi.perfQuery.index = function (config, service) {
    var deptcmp = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};

    var _menuid = config.menuid,//菜单id
        _tablecode,
        _datasource,//数据源集合
        _workflow,//工作流guid
        _prolev = config.prolev,//项目级次
        _projectcoldatas = config.projectcoldatas,//二级项目查询区数据
        _projecttabledata = config.projecttabledata,//二级项目列数据
        _projectqfdatas = config.projectqfdatas,//二级项目表数据
        _deptcoldatas = config.deptcoldatas,//部门整体查询区数据
        _depttabledata = config.depttabledata,//部门整体列数据
        _deptqfdatas = config.deptqfdatas,//部门整体表数据
        _transpaycoldatas = config.transpaycoldatas,//转移支付查询区数据
        _transpaytabledata = config.transpaytabledata,//转移支付列数据
        _transpayqfdatas = config.transpayqfdatas,//转移支付表数据
        _firstprocoldatas = config.firstprocoldatas,//一级项目查询区数据
        _firstprotabledata = config.firstprotabledata,//一级项目列数据
        _firstproqfdatas = config.firstproqfdatas,//一级项目表数据
        _lefttreename = "二级项目",//左侧评价对象树名称 默认项目
        _lefttabtype = "project",//左侧树页签guid 默认项目
        _leftmenuid,
        _defquery,//列表查询条件
        _tabfilter,//页签查询条件
        _tabcode,//页签编码
        _saveAgency,//左侧树选择单
        _uikey,
        scrWidth = document.body.clientWidth,
        scrHeight = document.body.clientHeight;
    var isfirst = true;
    var serviceid = service;

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
        params.tabcode = _tabcode;
        params.menuid = _leftmenuid;
        params.prolev = _prolev;
        params.agency = _saveAgency;
        params.isleaf = Ext.lt.pmkpi.isleaf + "";
        params.tabfilter = _tabfilter;
        params.workflow = _workflow;
        params.protype = _lefttabtype;
        params.pagetype = "report";
        if (_lefttabtype == "project" || "transpay" == _lefttabtype || _lefttabtype == "firstpro") {
            params.beanid = "pmkpi.perfprogram.TlpProgramQueryBOTX";
            params.type = "2";
        } else if (_lefttabtype == "dept") {
            params.beanid = "pmkpi.deptperformance.DeptPerformanceQueryBOTX";
        }
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params, function () {
            Ext.lt.ui.loadingClose();
        });
        deptcmp.setColDatasource(_datasource, datatable);
    }

    //送审情况
    cmp.queryaudit = function () {
        deptcmp.auditquery(datatable);
    }

    /**
     * 左侧页签切换触发函数.
     */
    tabChange = function (obj) {
        _saveAgency = "treeroot";
        Ext.lt.pmkpi.isleaf = '0';
        _lefttabtype = obj["code"];
        _lefttreename = obj["name"];
        _leftmenuid = _lefttabtype + "performance_targethide";
        var data;
        var key;
        var cols;
        if (_lefttabtype == "project") { // 二级项目
            _defquery = _projecttabledata.defquery;
            _tablecode = _projecttabledata.tablecode;
            //cmp.setTableColum(_projectcoldatas);
            data = _projectqfdatas;
            cols = _projectcoldatas;
            _prolev = '2';
            key = '/pmkpi/program/query/list';
            _uikey = '/pmkpi/program/report/edit';
        } else if (_lefttabtype == "dept") { // 部门整体
            _defquery = _depttabledata.defquery;
            _tablecode = _depttabledata.tablecode;
            cmp.setTableColum(_deptcoldatas);
            data = _deptqfdatas;
            cols = _deptcoldatas;
            _prolev = null;
            key = '/pmkpi/deptperformance/query/index';
            _uikey = '/pmkpi/deptperformance/report/edit';
        } else if (_lefttabtype == "firstpro") { // 一级项目
            _defquery = _firstprotabledata.defquery;
            _tablecode = _firstprotabledata.tablecode;
            //cmp.setTableColum(_firstprocoldatas);
            data = _firstproqfdatas;
            cols = _firstprocoldatas;
            _prolev = '1';
            key = '/pmkpi/firstprogram/query/list';
            _uikey = '/pmkpi/program/report/edit';
        } else if (_lefttabtype == "transpay") { // 转移支付
            _defquery = _transpaytabledata.defquery;
            _tablecode = _transpaytabledata.tablecode;
            //cmp.setTableColum(_transpaycoldatas);
            data = _transpayqfdatas;
            cols = _transpaycoldatas;
            _prolev = null;
            key = '/pmkpi/transpay/query/list';
            _uikey = '/pmkpi/program/report/edit';
        }
        var params = {};
        params.tablecode = _tablecode;
        var mycols = new Array();
        for (var i = 0; i < cols.length; i++) {
            var selectDatas = cols[i];
            var clstwo  = {};
            clstwo.columncode = selectDatas.colcode;
            clstwo.guid = selectDatas.guid;
            clstwo.type = selectDatas.type;
            mycols[i] = clstwo;
        }
        params.cols = mycols;
        try {
            _datasource = Ext.lt.RCP.asyncall(service, "getDataSource", params);
            deptcmp.setColMapper(cols);
        } catch (e) {
        }
        //cmp.setTableColum(cols);
        queryfrom(data, key);
        var datalist = Ext.lt.pmkpi.querytree();
        Ext.lt.pmkpi.query();
        obj.datas = datalist
        return obj;
    }

    Ext.lt.pmkpi.querytree = function () {
        var params = {};
        params.menuid = _menuid;
        params.tablecode = _tablecode;
        params.protype = _lefttabtype;
        Ext.lt.ui.loadingShow();
        var datalist = Ext.lt.RCP.asyncall(service, "getTreeData", params);
        lefttree.setRecordset(datalist, 0);
        Ext.lt.ui.loadingClose();
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

    //导出
    cmp.export = function () {
        if (datatable.getRecordset().size() != 0) {
            var data = datatable.getSelected();
            var cfg = {};
            if (_lefttabtype == "project") {
                cfg.key = '/pmkpi/program/query/list';
            } else if (_lefttabtype == "dept") {
                cfg.key = '/pmkpi/deptperformance/query/index';
            }
            cfg.bustable = datatable;
            if (data.size() == 0) {
                alert("请选择数据！");
                return;
                // if (Ext.lt.ui.confirm("是否导出当前全部数据？")) {
                //     cfg.hassql = 1;
                //     cfg.beanid = "pmkpi.perfQuery.PerfQueryBOTX";
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
        // _tablecode = uiconfig.tablecode;
        // _tablecode = _depttabledata.tablecode;
        _defquery = uiconfig.defquery;
        _orderby = uiconfig.orderby;
        _pagetype = config.pagetype;
        // _uikey = config.uikey;
        var cols = obj.cols;
        if (!Ext.lt.isArray(cols))
            cols = [cols];
        for (var i = 0; i < cols.length; i++) {
            var col = cols[i];
            if (_lefttabtype == "project" || "transpay" == _lefttabtype || _lefttabtype == "firstpro") {
                if (col["colcode"] == "pro_name") {
                    col.fn = function (l, c, data, col) {
                        return "<a herf='#' style='color:#468ac9'>" + data.pro_name + "</a>";
                    }
                    col.onclick = function (td, el, l, c, d) {
                        var url = _uikey + ".page";
                        var params = {};
                        params.pagetype = "editreport";
                        params.mainguid = d.guid;
                        params.agency = d.agencyguid;
                        params.pro_code = d.pro_code;
                        params.viewtype = "query";
                        params.workflow = _workflow;
                        url = Ext.lt.pmkpi.genPageUrl(url, params);
                        Ext.lt.ui.openModalWindow(url, scrWidth, scrHeight, "项目绩效目标查看");
                    };
                }
            } else if (_lefttabtype == "dept") {
                if (col["colcode"] == "name") {
                    col.fn = function (l, c, data, col) {
                        return "<a herf='#' style='color:#468ac9'>" + data.name + "</a>";
                    }
                    col.onclick = function (td, el, l, c, d) {
                        var url = _uikey + ".page";
                        var params = {};
                        params.pagetype = "editreport";
                        params.mainguid = d.guid;
                        params.agency = d.agencyguid;
                        params.viewtype = "query";
                        params.workflow = _workflow;
                        url = Ext.lt.pmkpi.genPageUrl(url, params);
                        Ext.lt.ui.openModalWindow(url, scrWidth, scrHeight, "部门整体绩效目标查看");
                    };
                }
            }
        }
    });

    Ext.lt.message.hook("queryform", "doquery", function (obj) {
        Ext.lt.pmkpi.query();
    });

    Ext.lt.message.hook("perfcommon", "auditquery", function () {
        Ext.lt.pmkpi.query();
        try {
            Ext.lt.ui.closeModalWindow();
        } catch (e) {
            Ext.lt.ui.modalWindow.close();
        }
    });

    //查看项目明细
    cmp["showProjView"] = function () {
        var data = datatable.getSelected();
        if (data.size() == 1) {
            var params = {};
            params.submenu = _menuid;
            params.pro_code = data[0].pro_code;
            deptcmp.proinfoview(datatable, params);
        } else if (data.size() > 1) {
            Ext.lt.ui.alert('每次只能查看一条数据！', function () {
            });
        } else {
            Ext.lt.ui.alert('请选择要查看的数据！', function () {
            });
        }
    }

    return cmp;
}