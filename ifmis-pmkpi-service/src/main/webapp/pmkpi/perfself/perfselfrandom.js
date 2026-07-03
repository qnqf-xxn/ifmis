if (!Ext.lt.pmkpi) {
    Ext.lt.pmkpi = {};
}
if (!Ext.lt.pmkpi.perfself) {
    Ext.lt.pmkpi.perfself = {};
}

var _selectedtree = null;
Ext.lt.pmkpi.perfself.perfselfrandomservice = function (config, service) {
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var _menuid = config.menuid,
        _agency,
        _tablecode,
        _defquery,
        _queryConfig, //查询区配置
        _querySql, //查询区条件
        scrWidth = document.body.clientWidth,
        scrHeight = document.body.clientHeight;
    var _sys_random = config.sys_random;

    $(function () {
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        common.initDatatable();
        cmp.query();
        var tabpageDiv = document.getElementById('datatable');
        var newDiv = document.createElement('div');
        newDiv.textContent = "按照每个部门自评项目总数的"+_sys_random+"%比例进行抽查";
        newDiv.style.color ='red';
        newDiv.style.padding = '5px';
        newDiv.style.margin = '5px';
        newDiv.style.fontSize = '18px';
        newDiv.style.fontWeight = 'bold';
        tabpageDiv.insertAdjacentElement('afterbegin', newDiv);
    })

    //查询
    cmp.query = function (obj) {
        Ext.lt.pmkpi.query();
    }

    Ext.lt.pmkpi.query = function () {
        //获取选中的左侧树code
        if (!_agency) {
            _agency = "treeroot";
            Ext.lt.pmkpi.isleaf = 0;
        }
        Ext.lt.ui.loadingShow();
        var params = {};
        params.saveAgency = _agency;
        params.isleaf = Ext.lt.pmkpi.isleaf + "";
        params.menuId = _menuid;
        params.queryConfig = _queryConfig;
        params.querySql = _querySql;
        params.tablecode = _tablecode;
        params.defquery = _defquery;
        params.beanid = "pmkpi.perfSelf.PerfSelfRandomBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params, function () {
            Ext.lt.ui.loadingClose();
            setTimeout(function(){
                datatable.resetSum();
            },300);
        });
    }

    cmp.random = function () {
        var params = {};
        var datas = datatable.getSelected();
        if (!datas || datas.size() <= 0) {
            Ext.lt.ui.alert('请选择数据！', function () {
            });
            return;
        }
        var isflag= false;
        var issue= false;
        var dept_name1 = "";
        var dept_name2 = "";
        var message = "是否确认抽取项目？";
        for (var i=0; i<datas.length; i++) {
            if (datas[i].is_sue == "1"){ // 已下发不能随机抽取
                issue = true;
                dept_name1 += datas[i].dept_name+"、";
            }
            if (datas[i].self_count3 != null && datas[i].self_count3 != ""){
                isflag = true;
                dept_name2 += datas[i].dept_name+"、";
            }
        }
        if (issue){
            dept_name1 = dept_name1.substring(0,dept_name1.length-1);
            Ext.lt.ui.alert(dept_name1 +'部门已下发，不能随机抽取！', function () {
            });
            return;
        }
        if (isflag){
            dept_name2 = dept_name2.substring(0,dept_name2.length-1);
            message = dept_name2+" 部门已抽取，是否清空重新抽取？";
        }
        Ext.lt.ui.confirm(message, null, function (is) {
            if (is) {
                params.datas = datas;
                params.tablecode = _tablecode;
                Ext.lt.ui.loadingShow();
                Ext.lt.RCP.call(serviceid, "selfRandom", params, function (rs) {
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert('抽取完成！', function () {
                        Ext.lt.pmkpi.query();
                    });
                }, function () {
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert('抽取失败！', function () {
                    });
                });
            }
        })
    }

    cmp.personrandom = function () {
        var params = {};
        var datas = datatable.getSelected();
        if(datas.length != 1){
            Ext.lt.ui.alert("请选择一条需要调整的数据！",function(){});
            return;
        }
        if(datas[0].is_sue == "1"){
            Ext.lt.ui.alert("该数据已下发无法调整抽评项目！",function(){});
            return;
        }
        params.datas = datas;
        params.dept_code = datas[0].dept_code;
        params.tablecode = _tablecode;
        params.menuId = _menuid;
        var url = "/pmkpi/perfself/random/procheck.page";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth - 200, scrHeight - 50, "人工选择/调整");
    }

    cmp.issue = function () {
        var params = {};
        var datas = datatable.getSelected();
        if (!datas || datas.size() <= 0) {
            Ext.lt.ui.alert('请选择需要下发的数据！', function () {
            });
            return;
        }
        var isflag= false;
        var issue= false;
        var dept_name1 = "";
        var dept_name2 = "";
        for (var i=0; i<datas.length; i++) {
            if (datas[i].is_sue == "1"){ // 已下发不能再次下发
                issue = true;
                dept_name1 += datas[i].dept_name+"、";
            }
            if (datas[i].self_count2 > datas[i].self_count3){ // 应抽取大于已抽取
                isflag = true;
                dept_name2 += datas[i].dept_name+"、";
            }
        }
        if (issue){
            dept_name1 = dept_name1.substring(0,dept_name1.length-1);
            Ext.lt.ui.alert(dept_name1 +'部门已下发，不能重复下发！', function () {
            });
            return;
        }
        if (isflag){
            dept_name2 = dept_name2.substring(0,dept_name2.length-1);
            Ext.lt.ui.alert(dept_name2 +'部门未达到抽取比例，请调整后再下发！', function () {
            });
            return;
        }
        Ext.lt.ui.confirm("是否确认下发项目？", null, function (is) {
            if (is) {
                params.datas = datas;
                params.tablecode = _tablecode;
                Ext.lt.ui.loadingShow();
                Ext.lt.RCP.call(serviceid, "selfsue", params, function (rs) {
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert('下发完成！', function () {
                        Ext.lt.pmkpi.query();
                    });
                }, function () {
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert('下发失败！', function () {
                    });
                });
            }
        })
    }

    cmp.issueoff = function () {
        var params = {};
        var datas = datatable.getSelected();
        if (!datas || datas.size() <= 0) {
            Ext.lt.ui.alert('请选择需要取消下发的数据！', function () {
            });
            return;
        }
        var issue= false;
        var dept_name1 = "";
        for (var i=0; i<datas.length; i++) {
            if (datas[i].is_sue == "2"){ // 未下发不能取消下发
                issue = true;
                dept_name1 += datas[i].dept_name+"、";
            }
        }
        if (issue){
            dept_name1 = dept_name1.substring(0,dept_name1.length-1);
            Ext.lt.ui.alert(dept_name1 +'部门未下发，不能取消下发！', function () {
            });
            return;
        }
        Ext.lt.ui.confirm("是否确认取消下发项目？", null, function (is) {
            if (is) {
                params.datas = datas;
                params.tablecode = _tablecode;
                Ext.lt.ui.loadingShow();
                Ext.lt.RCP.call(serviceid, "selfsueoff", params, function (rs) {
                    if (rs && rs.success == true) {
                        Ext.lt.ui.loadingClose();
                        Ext.lt.ui.alert('取消下发完成！', function () {
                            Ext.lt.pmkpi.query();
                        });
                    } else {
                        Ext.lt.ui.loadingClose();
                        Ext.lt.ui.alert(rs.error, function () {
                            Ext.lt.pmkpi.query();
                        });
                    }
                }, function () {
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert('取消下发失败！', function () {
                    });
                });
            }
        })
    }

    cmp.viewpro = function () {
        var params = {};
        var datas = datatable.getSelected();
        if(datas.length != 1){
            Ext.lt.ui.alert("请选择一条数据！",function(){});
            return;
        }
        params.datas = datas;
        params.dept_code = datas[0].dept_code;
        params.tablecode = _tablecode;
        params.menuId = _menuid;
        params.viewtype = "query";
        var url = "/pmkpi/perfself/random/procheck.page";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth - 200, scrHeight - 50, "查看-人工选择/调整");
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
        cmp.query();
    });

    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        //表配置
        _tablecode = uiconfig.tablecode;
        _defquery = uiconfig.defquery;
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



    return cmp;
}
