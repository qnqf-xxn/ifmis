if (!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if (!Ext.lt.pmkpi.perfdataset)
    Ext.lt.pmkpi.perfdataset = {};

Ext.lt.pmkpi.perfdataset = function (config, service) {
    var cmp = {};
    var serviceid = service,
        _tablecode,//表名
        _leftcode = config.leftcode,
        _delcols,
        _updatecols,
        _leftcodevalue,
        _editkey,//编辑区key
        _defyear = config.defyear,
        _defprovince = config.defprovince,
        _defquery,
        scrWidth = document.body.clientWidth,
        scrHeight = document.body.clientHeight;

    $(function () {
        var page = {};
        page.columns = "*";
        try{
            datatable.setPage(page);
        }catch (e) {
            console.log("---异常：" + e)
        }
        datatable.redraw();
        cmp.query();
    })

    /**
     * 列配置
     */
    Ext.lt.message.hook("busdatatable", "drawed", function (obj) {
        var uiconfig = obj.config.data[0];
        var config = obj.config;
        _delcols = config.delcols;
        _updatecols = config.updatecols;
        _editkey = config.editkey;
        //表配置
        _tablecode = uiconfig.tablecode;
        _defquery = uiconfig.defquery;
    });

    Ext.lt.message.hook("queryform", "doquery", function (obj) {
        cmp.query();
    });

    /**
     * 保存
     */
    cmp.save = function () {
        if (!datatable.checkAll()) return;
        var params = {};
        params.tablecode = _tablecode;
        params.province = _defprovince;
        params.year = _defyear;
        params.datas = datatable.getRecordSet().toArray();
        params.deldatas = datatable.getRemoveData();
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid, "save", params, function (rs) {
            if (rs && rs.success) {
                Ext.lt.ui.alert('保存成功！', function () {
                    cmp.query();
                    Ext.lt.ui.loadingClose();
                });
            }
        }, function () {
            Ext.lt.ui.alert('保存失败！', function () {
                Ext.lt.ui.loadingClose();
            });
        });
    }
    //多主键保存方法
    cmp.savemajorkey = function () {
        if (!datatable.checkAll()) return;
        var params = {};
        params.tablecode = _tablecode;
        params.year = _defyear;
        params.province = _defprovince;
        if (_leftcode != null) {
            params[_leftcode] = _leftcodevalue;
        }
        params.delcols = _delcols;
        params.updatecols = _updatecols;
        params.datas = datatable.getRecordSet().toArray();
        params.deldatas = datatable.getRemoveData();
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid, "savemajorkey", params, function (rs) {
            if (rs && rs.success) {
                Ext.lt.ui.alert('保存成功！', function () {
                    cmp.query();
                    Ext.lt.ui.loadingClose();
                });
            } else {
                if("PERF_GOAL_DATA" == _tablecode && "主键冲突" == rs.msg){//如果是绩效目标默认数据配置，触发特殊提示
                    Ext.lt.ui.alert('保存失败！支出项目类别不可重复', function () {
                        Ext.lt.ui.loadingClose();
                    });
                }else{
                    Ext.lt.ui.alert('保存失败！' + rs.msg, function () {
                        Ext.lt.ui.loadingClose();
                    });
                }
            }
        }, function () {
            Ext.lt.ui.alert('保存失败！', function () {
                Ext.lt.ui.loadingClose();
            });
        });
    }

    Ext.lt.pmkpi.query = function (){
        cmp.query();
    };

    /**
     * 查询
     */
    cmp.query = function () {
        Ext.lt.ui.loadingShow();
        var params = {};
        params.tablecode = _tablecode;
        params.year = _defyear;
        params.province = _defprovince;
        //根据用户选择的code为条件重新查询
        if (_leftcode != null) {
            if (_defquery == null) {
                params.tablesql = " " + _leftcode + "= '" + _leftcodevalue + "'";
            } else {
                params.tablesql = _defquery + " and " + _leftcode + "= " + _leftcodevalue;
            }
        }
        params.querySql = queryform.getQuerySQL();
        params.beanid = "pmkpi.setting.dataset.PerfDataSetBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params, function () {
            Ext.lt.ui.loadingClose();
        });
    }

    /**
     * 表格添加行
     */
    Ext.lt.message.hook("addRow", "uidatatable", function (editdatatable) {
        var newguid = Ext.lt.RCP.asyncall(serviceid, "getCreateguid", null);
        var newdata = {};
        newdata.guid = newguid;
        newdata.rowtype = "add";
        newdata.province = _defprovince;
        newdata.year = _defyear;
        datatable.getRecordSet().addData(newdata, 100);
    });

    /**
     * 表格删除行
     */
    Ext.lt.message.hook("delRow", "uidatatable", function (editdatatable) {
        var selDatas = datatable.getSelected();
        if (selDatas.size() <= 0) {
            Ext.lt.ui.alert('请选择要删除的数据！', function () {
            });
            return;
        }
        Ext.lt.ui.confirm('是否删除已选择的数据!', null, function (is) {
            if (is) {
                datatable.removeData(selDatas);
            }
        });
    });
    /**
     * 左侧树点击
     */
    Ext.lt.message.hook("left", "click", function (obj) {
        var treeNode = obj.node.data;
        if (treeNode) {
            _leftcodevalue = treeNode.code;
            Ext.lt.pmkpi.isleaf = treeNode.isleaf;
        } else {
            _leftcodevalue = "treeroot";
            Ext.lt.pmkpi.isleaf = '0';
        }
        cmp.query();
    });

    /**
     * 初始化数据
     * @param params
     */
    cmp.initleftset = function () {
        var params = {};
        params.tablecode = _tablecode;
        params.tablesql = _defquery;
        params.leftcoe = _leftcode;
        params.leftcodevalue = _leftcodevalue;
        params.msg = "初始化";
        Ext.lt.RCP.call(serviceid, "initleftset", params, function (rs) {
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert(params.msg + '成功！', function () {
                cmp.query();
            });
        }, function () {
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert(params.msg + '失败！', function () {
            });
        });
    }
    /**
     * 初始化数据
     * @param params
     */
    cmp.initset = function () {
        var params = {};
        params.tablecode = _tablecode;
        params.tablesql = _defquery;
        params.msg = "初始化";
        Ext.lt.RCP.call(serviceid, "initset", params, function (rs) {
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert(params.msg + '成功！', function () {
                cmp.query();
            });
        }, function () {
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert(params.msg + '失败！', function () {
            });
        });
    }

    /**
     * 修改
     */
    cmp.mod = function (){
        var data = datatable.getSelected();
        if(!data || data.length != 1){
            Ext.lt.ui.alert("请选择要修改的数据！",function(){});
            return;
        }
        var params = {};
        var guid = data[0].guid;
        params.guid = guid;
        params.tablecode = _tablecode;
        var url = _editkey + ".page";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,scrWidth*0.8,scrHeight*0.8,"修改");
    }
    return cmp;
}