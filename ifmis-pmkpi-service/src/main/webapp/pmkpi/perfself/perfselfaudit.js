if (!Ext.lt.pmkpi) {
    Ext.lt.pmkpi = {};
}
if (!Ext.lt.pmkpi.perfself) {
    Ext.lt.pmkpi.perfself = {};
}

var _selectedtree = null;
Ext.lt.pmkpi.perfself.perfselfauditservice = function (config, service) {
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var _workflow,
        _menuid = config.menuid,
        _lefttreename,//左侧评价对象树名称 默认项目支出
        _lefthidebtn,//左侧树隐藏按钮
        _tabhidtbtn,//右侧页签隐藏按钮
        _lefttab = config.lefttab,//左侧树第一个页签
        _lefttabtype = _lefttab.code,//左侧树页签类型
        _deptqfdatas = config.deptqfdatas,//部门查询区数据
        _proqfdatas = config.proqfdatas,//项目查询区数据
        _leftmenuid,//隐藏菜单
        _agency,
        _tablecode,
        _tabcode,
        _defquery,
        _orderby,
        _uikey,
        _displaycols = [],
        _queryConfig, //查询区配置
        _querySql, //查询区条件
        _isfirst = true, // 是否第一次进页面（控制查询方法）
        scrWidth = document.body.clientWidth,
        scrHeight = document.body.clientHeight;
    var serviceid = service;
    var tab_filters = {};//页签过滤条件集合
    var isfirst=true;//首次进入
    var _isNINGXIA = config.isNINGXIA;

    //查询
    cmp.query = function (obj) {
        query();
    }

    function query() {
        //获取选中的左侧树code
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
        params.queryConfig = _queryConfig;
        params.querySql = _querySql;
        params.tablecode = _tablecode;
        params.tabfilter = tab_filters[_lefttabtype + "_" + _tabcode];
        params.tabcode = _tabcode;
        params.tablesql = _defquery;//查询条件
        params.lefttabtype = _lefttabtype;
        params.leftmenuid =_leftmenuid;
        params.orderby = _orderby;
        params.beanid = "pmkpi.perfSelf.PerfSelfAuditBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params, function () {
            Ext.lt.ui.loadingClose();
            setTimeout(function(){
                datatable.resetSum();
            },300);
        });
    }

    Ext.lt.message.hook("left", "click", function (obj) {
        var treeNode = obj.node.data;
        if (treeNode) {
            _agency = treeNode.guid;
            _name = treeNode.name;
            Ext.lt.pmkpi.isleaf = treeNode.isleaf;
        } else {
            _agency = "treeroot";
            Ext.lt.pmkpi.isleaf = '0';
        }
        cmp.query();
    });

    Ext.lt.message.hook("queryform", "doquery", function (obj) {
        _queryConfig = queryform.getQueryParam();
        _querySql = queryform.getQuerySQL();
        // var wheresql = "";
        // var company = _queryConfig[0].company; //金额单位
        // var oper_pro_total_amt = _queryConfig[0].oper_pro_total_amt; //项目总金额最大值
        // var pro_total_amt = _queryConfig[0].pro_total_amt; //项目总金额最小值
        // var oper_bgtamt = _queryConfig[0].oper_bgtamt;  //当年预算金额查询范围
        // var bgtamt = _queryConfig[0].bgtamt;  //当年预算金额值
        // if (company == "2") { //单位：万元
        //     pro_total_amt = pro_total_amt != null ? (parseFloat(pro_total_amt) * 10000) : null;
        //     bgtamt = bgtamt != null ? (parseFloat(bgtamt) * 10000) : null;
        // } else if (company == "3") { //单位：亿元
        //     pro_total_amt = pro_total_amt != null ? (parseFloat(pro_total_amt) * 100000000) : null;
        //     bgtamt = bgtamt != null ? (parseFloat(bgtamt) * 100000000) : null;
        // }
        // var a = _querySql.indexOf("(COMPANY");
        // var b = _querySql.indexOf("(PRO_TOTAL_AMT");
        // var c = _querySql.indexOf("(BGTAMT");
        // var  index = a;
        // if (a == -1) {
        //     index = b;
        //     if (b == -1) {
        //         index = c;
        //     }
        // }
        // if (index != -1) {
        //     wheresql = _querySql.substring(0, index);
        //     if (pro_total_amt != null) {
        //         wheresql += "(pro_total_amt " + oper_pro_total_amt + pro_total_amt + ") and ";
        //     }
        //     if (bgtamt != null) {
        //         wheresql += "(bgtamt " + oper_bgtamt + bgtamt + ") and ";
        //     }
        //     wheresql = wheresql.substring(0, wheresql.length - 4);
        //     _querySql = wheresql;
        // }
        cmp.query();
    });

    Ext.lt.message.hook("datatable", "drawed",function(obj){
        var uiconfig = obj.uiconfig;
        //表配置
        _tablecode = uiconfig.tablecode;
        _defquery = uiconfig.defquery;
        _orderby = uiconfig.orderby;
    });

    Ext.lt.message.hook("datatable", "beforesetcols", function (obj) {
        var cols = obj.cols;
        if (!Ext.lt.isArray(cols))
            cols = [cols];
        for (var i = 0; i < cols.length; i++) {
            var col = cols[i];
            if (col["colcode"] == "warn") { //目标值构建符号和单位
                col.cseditfn = function (i, j, rs, style) { //列的单元格样式.
                    style = 'style="text-align:center;"';
                    return style;
                }
                col.fn = function (l, c, data, val) {
                    var warn = !data.warn ? "" : data.warn;
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
        var datas = datatable.getSelected();
        if (datas.length <= 0) {
            Ext.lt.ui.alert("请选择要" + obj.name + "的数据！", function () {
            });
            return;
        }
        if (!common.checkwfstatus(datas)) return false;//先校验审核状态是否一致
        var params = {};
        params.datas = datas;
        params.bustype = _lefttabtype;
        params.busguid = _leftmenuid + "_" + datas[0]["wfstatus"];
        common.doAction(obj, params);
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
        params.projguid = data[0].projguid;
        params.proguid = data[0].projguid;
        params.procode = data[0].pro_code;
        params.agency = data[0].agencyguid;
        params.saveAgency = data[0].agencyguid;
        params.workflow = data[0].wfid;
        params.wfstatus = data[0].wfstatus;
        params.bustype = _lefttabtype;
        params.uikey = _uikey;
        params.wfstatus = data[0].wfstatus;
        params.pagetype = "audit";
        params.querycode = "true";
        if (_isNINGXIA) {
            params.projectkind = _lefttabtype;
        } else {
            params.projectkind = data[0].projectkind;
        }
        //审核页面是否显示查看监控历史记录按钮（1 是  2 否）
        if ("parentprogram" == _lefttabtype) {
            params.isshowhistracebtn = "2";
        } else {
            params.isshowhistracebtn = "1";
        }
        var nodemap = Ext.lt.RCP.asyncall(serviceid, "queryPrevAuditType", [data[0].wfid, data[0].wfstatus]);
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

    /**
     * 修改
     */
    cmp.update = function (obj) {
        var data = datatable.getSelected();
        if (data.length != 1) {
            Ext.lt.ui.alert("请选择要修改的数据！", function () {
            });
            return;
        }
        var params = {};
        params.workflow = _workflow;
        var url = _uikey + ".page";
        if (data.length == 1) {
            params.saveAgency = data[0].agencyguid;
            params.mainguid = data[0].guid;
            params.projguid = data[0].projguid;
            params.procode = data[0].pro_code;
            params.bustype = _lefttabtype;
            params.wfstatus = data[0].wfstatus;
            params.querycode = true;  //部门整体目标查询条件
            params.proguid = data[0].projguid;
        }
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth, scrHeight, "自评信息填报-" + _lefttreename);
    }

    //送审情况
    cmp.queryaudit = function () {
        common.auditquery(datatable);
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
        var nodemap = Ext.lt.RCP.asyncall(serviceid, "queryAuditType", [_workflow, data[0].wfstatus]);
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
        _tabhidtbtn = obj.hidebtns;
        var tabconfig = eval('(' + obj.config + ')');
        tab_filters[_lefttabtype + "_" + obj.code] = tabconfig[_lefttabtype + "filter"];
        _tabcode = obj.code;
        if (!_isfirst) {
            common.changTooltoolbuttontStatus(0, _tabhidtbtn + "," + _lefthidebtn);
            Ext.lt.pmkpi.querytree();
        }
    }

    Ext.lt.message.hook("perfcommon", "auditquery", function () {
        cmp.query();
        try {
            Ext.lt.ui.closeModalWindow();
        } catch (e) {
            Ext.lt.ui.modalWindow.close();
        }
    });

    $(function () {
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        common.initDatatable();
        var _lefttab = lefttree.getActiveTabCfg();
        //查询之前处理待送审，还是被退回页签
        common.pendingtasktab();
        tabChange(_lefttab);
        _isfirst = false;
    })
    /**
     * 左侧页签切换触发函数.
     */
    tabChange = function (obj) {
        _agency = "treeroot";
        Ext.lt.pmkpi.isleaf = '0';
        _lefttabtype = obj["code"];
        _lefttreename = obj["name"];
        _workflow = obj.leftwfid;
        _lefthidebtn = obj.hidebtns;
        _leftmenuid = obj.leftmenuid;
        var data;
        var key;
        if (_lefttabtype == "program" || _lefttabtype == "transprogram") {
            data = _proqfdatas;
            key = '/pmkpi/perfself/apply/index';
            _uikey = "/pmkpi/perfself/apply/edit";
        } else if (_lefttabtype == "parentprogram") {
            data = _proqfdatas;
            key = '/pmkpi/perfself/apply/index';
            _uikey = "/pmkpi/selfparent/program/edit";
        } else if (_lefttabtype == "dept") {
            key = '/pmkpi/perfself/apply/dept';
            _uikey = "/pmkpi/perfself/apply/dept/edit";
            data = _deptqfdatas;
        }
        _querySql = "";
        queryfrom(data, key);
        if(_SYSTEMSTYLE_ == "grey"){
            $("#queryform .searchLeft").css("height","50px");
            queryform.retract();
        }
        common.changTooltoolbuttontStatus(0,  _lefthidebtn + "," + _tabhidtbtn);
        cmp.setTableColum();
        common.setworkflow(_workflow);
        common.setTabNum(obj);
        var treelist = Ext.lt.pmkpi.querytree();
        obj.datas = treelist;
        return obj;
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

    Ext.lt.pmkpi.querytree = function () {
        var params = {};
        params.lefttabtype = _lefttabtype;
        params.tablecode = _tablecode;
        params.leftmenuid =_leftmenuid;
        var datalist = Ext.lt.RCP.asyncall(service, "getTreeData", params);
        lefttree.setRecordset(datalist, 0);
        cmp.query();
        return datalist;
    }
    /**
     * 动态配置表格的列.
     *
     * @param data --
     */
    cmp.setTableColum = function () {
        var cols = datatable.getCols(); //获取列表所有列
        cols.push.apply(cols, _displaycols);
        _displaycols = [];
        for (var i = 0, len = cols.length; i < len; i++) {
            var col = cols[i];
            var config = eval(col.config);
            if (config && !$.isEmptyObject(config) && col.alias != "序号") {
                if (config.lefttabtype == _lefttabtype || (config.lefttabtype == "program" && _lefttabtype == "transprogram")) {
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
        datatable.redraw(); //从新绘制表格
    }

    /**
     * 发起整改
     */
    cmp.rectify = function () {
        var data = datatable.getSelected();
        if (!data || data.length != 1) {
            Ext.lt.ui.alert("请选中一条数据发起问题整改！", function () {
            });
            return;
        }
        var params = {};
        if (_lefttabtype == "program" || _lefttabtype == "transprogram" || _lefttabtype == "parentprogram") { //项目支出
            params.workflow = "D7F6D15AB0E07ECFE0533315A8C04610";
            params.bustype = '1';
            params.tablecode = "V_PERF_PROJECT_INFO";
            var url = '/pmkpi/rectification/programAdd.page';
        } else if (_lefttabtype == "dept") { //部门整体
            params.workflow = "D7F6D15AB0E17ECFE0533315A8C04610";
            params.bustype = '3';
            params.tablecode = "V_PERF_T_DEPTPERFDECLARE";
            var url = '/pmkpi/rectification/deptAdd.page';
        }
        var newguid = Ext.lt.RCP.asyncall(serviceid , "getCreateguid", null);
        params.mainguid = newguid;
        params.guid = data[0].guid;
        params.projguid = data[0].projguid;
        params.pro_code = data[0].pro_code;
        params.menuid = _menuid;
        params.lefttabtype = _lefttabtype;
        params.pagename = '绩效自评';
        params.rectifyType = 'TRACE';
        params.lefttabname = _lefttreename;
        params.rectype = "rectifyperfself";   //业务阶段: rectifyperfself:绩效自评  绩效监控 部门评价  财政评价
        //判断数据是否已发起整改
        var is = Ext.lt.RCP.asyncall(serviceid , "getDataByGuid", params);
        if (is){
            Ext.lt.ui.alert("数据已发起整改，不能重复操作！", function () {
            });
            return;
        }
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"整改通知新增 - "+_lefttreename);
        //common.rectify(datatable, params)
    }

    //保存并送审  送审
    Ext.lt.pmkpi.sendandudit = function(obj,datas){
        var actionname = obj.name;
        var actioncode = obj.code;
        var params = {};
        params.actioncode = actioncode;
        params.tablecode = "perf_t_rectify";
        params.datas = datas;
        params.bustype = _lefttabtype;
        params.workflow = datas[0].wfid;
        params.busguid = _menuid + "_" + datas[0].wfstatus;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid, "sendandudit", params, function(rt) {
            if (rt && rt.success == true) {
                Ext.lt.ui.alert(actionname + "成功！", function () {
                    Ext.lt.message.send("perfcommon", "auditquery", {});
                });
            }
        });
        Ext.lt.ui.loadingClose();
        Ext.lt.ui.modalWindow.close(); //关闭当前模态框
    }

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
        var params = {};
        var url = _uikey + ".page";
        params.mainguid = data[0].guid;
        params.saveAgency = data[0].agencyguid;
        params.projguid = data[0].projguid;
        params.procode = data[0].pro_code;
        params.viewtype = "query";
        params.workflow = _workflow;
        params.bustype = _lefttabtype;
        params.tablecode = _tablecode;
        params.wfstatus = data[0].wfstatus;
        params.querycode = true;  //部门整体目标查询条件
        params.proguid = data[0].projguid;
        if (_isNINGXIA) {
            params.projectkind = _lefttabtype;
        } else {
            params.projectkind = data[0].projectkind;
        }
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth, scrHeight, "绩效自评查看-" + _lefttreename);
    }

    /**
     * 查看项目
     */
    cmp.showProjView = function (obj){
        var params = {};
        var datas = datatable.getSelected();
        if (datas.size() != 1) {
            Ext.lt.ui.alert('请选择一条项目数据进行查看！', function () {
            });
            return;
        }
        params.proguid = datas[0].projguid;
        var xmxxEditobject = Ext.lt.RCP.asynserver("pmkpi.doubleprocess.TlpJxAuditService", "getProInfo", params);
        params.submenu = _menuid;
        params.pro_code = datas[0].pro_code;
        var pro_lev;
        if (xmxxEditobject && xmxxEditobject.length > 0) {
            pro_lev = xmxxEditobject[0].pro_lev;
            params.vchtypeid = xmxxEditobject[0].vchtypeid;
            params.projectkind = xmxxEditobject[0].projectkind;
        }
        if(pro_lev == "1"){
            common.queryPromain(datatable,params);
        }else {
            common.proinfoview(datatable,params);
        }
    }

    //导入
    cmp["importopinion"] = function(obj){
        // 暂时写死导入模板的code
        var importcode = "";
        var vchtypeid = "";
        if (_lefttabtype == "program" || _lefttabtype == "transprogram") { //共性指标导入
            importcode = "pmkpi_self_001";
            vchtypeid = "D42BA37664C72A20E0533315A8C085FA";
        } else if (_lefttabtype == "dept") { //个性指标导入
            importcode = "pmkpi_self_002";
            vchtypeid = "D42BA37664CB2A20E0533315A8C085FA";
        }
        var tokenid = Ext.lt.getparam("tokenid");
        // 调用导入接口，需要参数有tokenid,模板编码，单据id，args组合传给后台的参数
        var params = {};
        params.vchtypeid = vchtypeid;
        params.bustype = _lefttabtype;
        window.importparam = params;
        Ext.lt.importdata.imports(tokenid,importcode,vchtypeid,Object.toJSON(params),function(){
            parent.Ext.lt.pmkpi.impalert();
        });
    }

    Ext.lt.pmkpi.impalert = function(){
        Ext.lt.ui.alert("导入成功！",function() {
            window.parent.Ext.lt.outfile.window.close();
        });
    }

    // Ai辅助审核
    cmp.AIaudit = function (btn) {
        btn.lefttabtype = _lefttabtype;
        common.AIaudit(btn);
    }

    /**
     * 查看项目资金来源
     */
    cmp.querySourceFund = function (){
        var cols = [];
        cols.push("agencyguid");
        cols.push("projguid");
        cols.push("pro_code");
        var url = "/pmkpi/program/sourcefund.page";
        common.queryDataList(cols, url);
    }

    return cmp;
}