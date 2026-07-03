if (!Ext.lt.pmkpi) {
    Ext.lt.pmkpi = {};
}
if (!Ext.lt.pmkpi.perfself) {
    Ext.lt.pmkpi.perfself = {};
}

var _selectedtree = null;
Ext.lt.pmkpi.perfself.selfcomperquery = function (config, service) {
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var
        _menuid = config.menuid,
        _lefttreename,//左侧评价对象树名称 默认项目支出
        _lefthidebtn,//左侧树隐藏按钮
        _lefttab = config.lefttab,//左侧树第一个页签
        _lefttabtype = _lefttab.code,//左侧树页签类型
        _leftmenuid,//隐藏菜单
        _agency,
        _name,
        _queryConfig, //查询区配置
        _querySql, //查询区条件
        scrWidth = document.body.clientWidth,
        scrHeight = document.body.clientHeight;
    var _isNINGXIA = config.isNINGXIA;

    /**
     * 左侧页签切换触发函数.
     */
    tabChange = function (obj) {
        _agency = "treeroot";
        Ext.lt.pmkpi.isleaf = '0';
        _lefttabtype = obj["code"];
        _lefttreename = obj["name"];
        _lefthidebtn = obj.hidebtns;
        _leftmenuid = obj.leftmenuid;
        common.changTooltoolbuttontStatus(0, _lefthidebtn);
        cmp.setTableColum();
        var treelist = Ext.lt.pmkpi.querytree();
        obj.datas = treelist;
        return obj;
    }

    Ext.lt.pmkpi.querytree = function () {
        var params = {};
        params.menuid = _menuid;
        params.lefttabtype = _lefttabtype;
        params.leftmenuid =_leftmenuid;
        var datalist = Ext.lt.RCP.asyncall(service, "getTreeData", params);
        lefttree.setRecordset(datalist, 0);
        cmp.query();
        return datalist;
    }

    //查询
    cmp.query = function (obj) {
        Ext.lt.pmkpi.query();
    }
    $(function () {
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        common.initDatatable();
        tabChange(_lefttab);
    })

    Ext.lt.pmkpi.query = function () {
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
        params.queryConfig = _queryConfig;
        params.querySql = _querySql;
        params.lefttabtype = _lefttabtype;
        params.leftmenuid =_leftmenuid;
        params.beanid = "pmkpi.perfself.comperquery.SelfComperQueryBOTX";
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

    Ext.lt.message.hook("perfcommon", "auditquery", function () {
        cmp.query();
    });

    Ext.lt.message.hook("datatable", "beforesetcols", function (obj) {
        var cols = obj.cols;
        if (!Ext.lt.isArray(cols))
            cols = [cols];
        for (var i = 0; i < cols.length; i++) {
            var col = cols[i];
            var colconfig = eval(col.config);
            if (colconfig && colconfig.isleaf != null) {
                col.fn = function (l, c, data, val) {
                    colconfig = eval(datatable.getCol(c).config);
                    if ((data.isleaf == '0' && !colconfig.isleaf) || (data.isleaf == '1' && colconfig.isleaf)) {
                        return val;
                    } else {
                        return '';
                    }
                }
            }

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

    //送审情况
    cmp.queryaudit = function () {
        common.auditquery(datatable);
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
        var url = "/pmkpi/perfself/apply/edit.page";
        params.mainguid = data[0].guid;
        params.saveAgency = data[0].agencyguid;
        params.projguid = data[0].projguid;
        params.procode = data[0].pro_code;
        params.viewtype = "query";
        params.bustype = _lefttabtype;
        params.wfstatus = data[0].wfstatus;
        params.querycode = true;  //部门整体目标查询条件
        params.proguid = data[0].projguid;
        params.queryYear = data[0].year;
        params.queryProvince = data[0].province;
        if (_isNINGXIA) {
            params.projectkind = _lefttabtype;
        } else {
            params.projectkind = data[0].projectkind;
        }
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth, scrHeight, "绩效自评查看-" + _lefttreename);
    }

    /**
     * 动态配置表格的列.
     *
     * @param data --
     */
    cmp.setTableColum = function () {
        var page = {};
        page.columns = "*";
        datatable.setPage(page);
        datatable.setSelfdefconfig({config: "{}"});
        datatable.redraw(); //从新绘制表格
    }

    return cmp;
}
