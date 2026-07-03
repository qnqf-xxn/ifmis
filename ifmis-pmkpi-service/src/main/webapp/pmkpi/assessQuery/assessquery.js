if (!Ext.lt.pmkpi) {
    Ext.lt.pmkpi = {};
}
if (!Ext.lt.pmkpi.assessQuery) {
    Ext.lt.pmkpi.assessQuery = {};
}
var _pmkpiwf;
var _pmkpidept;
Ext.lt.pmkpi.assessQuery.index = function (config, service) {
    var deptcmp = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var _workflow = config.workflow,
        _menuid = config.menuid,
        _type = config.type,  // 1-事前绩效评估查询；2-项目绩效目标查询
        _prolev = config.prolev,//项目级次
        _datasource,//数据源集合
        _firstprocoldatas = config.firstprocoldatas,//一级项目查询区数据
        _firstprotabledata = config.firstprotabledata,//一级项目列数据
        _firstproqfdatas = config.firstproqfdatas,//一级项目表数据
        _secondprocoldatas = config.secondprocoldatas,//二级项目查询区数据
        _secondprotabledata = config.secondprotabledata,//二级项目列数据
        _secondproqfdatas = config.secondproqfdatas,//二级项目表数据
        _transpaycoldatas = config.transpaycoldatas,//转移支付查询区数据
        _transpaytabledata = config.transpaytabledata,//转移支付列数据
        _transpayqfdatas = config.transpayqfdatas,//转移支付表数据
        _lefttreename = "二级项目",//左侧评价对象树名称 默认项目
        _lefttabtype = "secondpro",//左侧树页签guid 默认项目
        _saveAgency,//左侧树选择单
        _tablecode,
        _tabfilter,
        _tabcode,
        _name,
        scrWidth = document.body.clientWidth,
        scrHeight = document.body.clientHeight;
    var isfirst = true;
    var serviceid = service;
    _pmkpidept = config.pmkpidept;//业务处室
    _pmkpiwf = config.pmkpiwf;//工作流

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
        params.menuid = _menuid;
        params.prolev = _prolev;
        params.agency = _saveAgency;
        params.isleaf = Ext.lt.pmkpi.isleaf + "";
        params.tabfilter = _tabfilter;
        params.workflow = _workflow;
        params.protype = _lefttabtype;
        // params.beanid = "pmkpi.perfQuery.PerfQueryBOTX";
        params.pagetype = "report";
        params.type = _type;
        deptcmp.setColDatasource(_datasource, datatable);
        params.beanid = "pmkpi.assessQuery.AssessQueryBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        if (_lefttabtype == "secondpro" || _lefttabtype == "transpay") { // 二级项目
            params.prolev = "2";
        } else if (_lefttabtype == "firstpro") { // 一级项目
            params.prolev = "1";
        }
        datatable.queryData(params, function () {
            Ext.lt.ui.loadingClose();
        });
    }
    cmp.showProjView = function(){
        var data = datatable.getSelected();
        if(data.size()==1){
            var params = {};
            params.submenu = _menuid;
            params.pro_code = data[0].pro_code;
            params.pro_id = data[0].mainguid;
            deptcmp.proinfoview(datatable,params);
        } else if(data.size() > 1) {
            Ext.lt.ui.alert('每次只能查看一条数据！',function(){});
        } else {
            Ext.lt.ui.alert('请选择要查看的数据！',function(){});
        }
    }

    $(function () {
        deptcmp.changTooltoolbuttontStatus(0, "导出报告"); // 隐藏按钮
        isfirst = false;
        var params = {};
        params.ordernum = 0;
        params.code = _lefttabtype;
        params.name = _lefttreename;
        tabChange(params);
    })
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
        if (_lefttabtype == "secondpro") { // 二级项目
            _defquery = _secondprotabledata.defquery;
            _tablecode = _secondprotabledata.tablecode;
            //cmp.setTableColum(_secondprocoldatas);
            data = _secondproqfdatas;
            cols = _secondprocoldatas;
            key = '/pmkpi/assess/query';
        } else if (_lefttabtype == "firstpro") { // 一级项目
            _defquery = _firstprotabledata.defquery;
            _tablecode = _firstprotabledata.tablecode;
            //cmp.setTableColum(_firstprocoldatas);
            data = _firstproqfdatas;
            cols = _firstprocoldatas;
            key = '/pmkpi/assess/query';
        } else if (_lefttabtype == "transpay") { // 转移支付
            _defquery = _transpaytabledata.defquery;
            _tablecode = _transpaytabledata.tablecode;
            //cmp.setTableColum(_transpaycoldatas);
            data = _transpayqfdatas;
            cols = _transpaycoldatas;
            key = '/pmkpi/assess/query';
        }
        var params = {};
        params.tablecode = _tablecode;
        params.cols = cols;
        try {
            _datasource = Ext.lt.RCP.asyncall(service, "getDataSource", params);
            deptcmp.setColMapper(cols);
        } catch (e) {
        }
        queryfrom(data, key);
        Ext.lt.pmkpi.querytree();
        Ext.lt.pmkpi.query();
    }
    Ext.lt.pmkpi.querytree = function () {
        var params = {};
        params.menuid = _menuid;
        params.tablecode = _tablecode;
        params.protype = _lefttabtype;
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
    // $(function () {
    //     if ("2" == _type) {
    //         deptcmp.changTooltoolbuttontStatus(0, "导出报告");
    //     }
    //     cmp.query();
    // })
    //查询
    // cmp.query = function (obj) {
    //
    //     query();
    // }

    function query() {
        if (!_agency) {
            _agency = "treeroot";
            Ext.lt.pmkpi.isleaf = 0;
        }
        Ext.lt.ui.loadingShow();
        var params = {};
        params.agency = _agency;
        params.isleaf = Ext.lt.pmkpi.isleaf + "";
        params.menuid = _menuid;
        params.workflow = _workflow;
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.tablecode = _tablecode;
        params.pagetype = "report";
        params.tabfilter = _tabfilter;
        params.tabcode = _tabcode;
        params.menuid = _menuid;
        params.beanid = "pmkpi.assessQuery.AssessQueryBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        params.type = _type;
        datatable.queryData(params, function () {
            Ext.lt.ui.loadingClose();
        });
    }

    //送审情况
    cmp.queryaudit = function () {
        deptcmp.auditquery(datatable);
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


    //查看项目明细
    Ext.lt.message.hook("datatable", "beforesetcols", function (obj) {
        var uiconfig = obj.table.uiconfig;
        var config = obj.table.config;
        _tablecode = uiconfig.tablecode;
        _defquery = uiconfig.defquery;
        _orderby = uiconfig.orderby;
        _pagetype = config.pagetype;
        _uikey = config.uikey;
        var cols = obj.cols;
        if (!Ext.lt.isArray(cols))
            cols = [cols];
        for (var i = 0; i < cols.length; i++) {
            var col = cols[i];
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
                    params.viewtype = "query";
                    params.workflow = _workflow;
                    url = Ext.lt.pmkpi.genPageUrl(url, params);
                    Ext.lt.ui.openModalWindow(url, scrWidth, scrHeight, "项目绩效目标查看");
                };
            }
        }
    });

    //导出
    cmp.export = function () {
        if (datatable.getRecordset().size() != 0) {
            var data = datatable.getSelected();
            var cfg = {};
            cfg.key = datatable.key;//datatable的key值
            cfg.bustable = datatable;
            if (data.size() == 0) {
                if (Ext.lt.ui.confirm("是否导出当前全部数据？")) {
                    cfg.hassql = 1;
                    cfg.beanid = config.bobeanid;//业务具体的bo  主要用到 bo中getvodsql()方法
                    if (typeof (queryform) != 'undefined') {
                        cfg.isHaveQueryForm = true;//是否有查询区
                        cfg.queryConfig = queryform.getQueryParam();//查询区条件
                    }
                    cfg.isHaveTabPage = true;
                    cfg.filter = " 1=1 ";
                    cfg.downtype = 'xls';
                    dataexport.excelexport(cfg);
                } else {
                    return;
                }
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

    cmp.expfile = function(obj){
        var datas = datatable.getSelected();
        if (datas.length <= 0 || datas.length > 1) {
            Ext.lt.ui.alert("请选择一条项目！",function(){});
            return;
        }
        var params = {};
        params.proguid = datas[0].pro_id;
        var result = Ext.lt.RCP.asyncall(service , "getFileMag", params);
        if(result.error){
            Ext.lt.ui.alert(result.log);
        } else {
            //设置下载文件的guid
            Ext.lt.pmkpi.download.setFileGuid(result.fileguid);
            //直接下载，以ie对话框方式保存
            Ext.lt.pmkpi.download.download();
        }
    }

    return cmp;
}

function getdataSource() {
    var pmkpidept_source = [];
    for (var i = 0; i < _pmkpidept.length; i++) {
        var temparr = [];
        temparr.push(_pmkpidept[i]["guid"]);
        temparr.push(_pmkpidept[i]["code"]);
        temparr.push(_pmkpidept[i]["name"]);
        pmkpidept_source.push(temparr);
    }
    datatable.addMapperDatas("finintorgguid", pmkpidept_source);
    var pmkpiwf_source = [];
    for (var i = 0; i < _pmkpiwf.length; i++) {
        var temparr = [];
        temparr.push(_pmkpiwf[i]["guid"]);
        temparr.push(_pmkpiwf[i]["code"]);
        temparr.push(_pmkpiwf[i]["name"]);
        pmkpiwf_source.push(temparr);
    }
    datatable.addMapperDatas("wfstatus", pmkpiwf_source);
}