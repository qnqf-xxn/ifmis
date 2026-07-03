if (!Ext.lt.pmkpi) {
    Ext.lt.pmkpi = {};
}
if (!Ext.lt.pmkpi.perfself) {
    Ext.lt.pmkpi.perfself = {};
}

var editwindow = null; //下达的任务接口
var _selectedtree = null;
Ext.lt.pmkpi.perfself.perfselfmanageservice = function (config, service) {
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var _workflow,
        _menuid = config.menuid,
        _lefttreename,//左侧评价对象树名称 默认项目支出
        _lefthidebtn,//左侧树隐藏按钮
        _tabhidtbtn,//右侧页签隐藏按钮
        _lefttab = config.lefttab,//左侧树第一个页签
        _lefttabtype = _lefttab.code,//左侧树页签类型
        _leftmenuid,//隐藏菜单
        _deptqfdatas = config.deptqfdatas,//部门查询区数据
        _proqfdatas = config.proqfdatas,//项目查询区数据
        _tablecode,
        _agency, //节点
        _tablecode,//页签对应的表
        _tabcode,
        _name,
        _deltables,
        _delcols,
        _defquerysql = {},
        _displaycols = [],
        _queryConfig, //查询区配置
        _querySql, //查询区条件
        _isfirst = true, // 是否第一次进页面（控制查询方法）
        _whereSql;

    var tab_filters = {};//页签过滤条件集合

    var serviceid = service;

    Ext.lt.pmkpi.query = function () {
        //获取选中的左侧树code
        if (!_agency) {
            _agency = "treeroot";
            Ext.lt.pmkpi.isleaf = 0;
        }
        Ext.lt.ui.loadingShow();
        var params = {};
        var tabfilter;
        var tablesql;
        params.agency = _agency;
        params.isleaf = Ext.lt.pmkpi.isleaf + "";
        params.workflow = _workflow;
        params.queryConfig = queryform.getQueryParam();
        params.querySql = _querySql;
        params.tablecode = _tablecode; //视图名称
        if (tab_filters[_lefttabtype + "_" + _tabcode]) {
            tabfilter = tab_filters[_lefttabtype + "_" + _tabcode];
        } else {
            tabfilter = tab_filters[(_lefttabtype == "transprogram" || _lefttabtype == "parentprogram" ? "program" : _lefttabtype) + "_" + _tabcode];
        }
        params.tabfilter = tabfilter;
        if (_defquerysql[_lefttabtype]) {
            tablesql = _defquerysql[_lefttabtype];
        } else {
            tablesql = _defquerysql[_lefttabtype == "transprogram" ? "program" : _lefttabtype];
        }
        params.tablesql = tablesql;
        params.tabcode = _tabcode; //页签编码
        params.tabsql = _whereSql;
        params.lefttabtype = _lefttabtype;
        params.leftmenuid =_leftmenuid;
        params.beanid = "pmkpi.perfSelf.PerfSelfTaskManageBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params, function () {
            Ext.lt.ui.loadingClose();
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
        Ext.lt.pmkpi.query();
    });

    Ext.lt.message.hook("perfcommon", "tablequery", function () {
        Ext.lt.pmkpi.query();
    });

    Ext.lt.message.hook("datatable", "beforesetcols", function (obj) {
        var uiconfig = obj.table.uiconfig;
        _defquerysql = eval('(' + uiconfig.config + ')');
        _tablecode = uiconfig.tablecode; //显示的数据
        var config = obj.table.config;
        _deltables = config.deltables;
        _delcols = config.delcols;
    });

    /**
     * 下达
     */
    cmp.add = function (obj) {
        var data = datatable.getSelected();
        if (data.length <= 0) {
            Ext.lt.ui.alert("请选中至少一条数据进行下达！", function () {
            });
            return;
        }
        var params = {};
        params.workflow = _workflow;
        params.tablecode = _tablecode;
        params.bustype = _lefttabtype;
        params.name = data.name;
        editwindow.show();
    }

    /**
     * 下达编辑区提交.
     */
    Ext.lt.message.hook("submit", "sendeditform", function (rs) {
        if (!editform.check()) return false;//先校验
        //判断开始时间与结束时间的前后
        var stime = editform.getCol("evalstart").getvalue();
        var etime = editform.getCol("evalend").getvalue();
        if (parseInt(stime) > parseInt(etime)){
            Ext.lt.ui.alert('开始时间不能大于结束时间！', function () {
                return;
            });
            return;
        }
        var datas = datatable.getSelected();
        var params = {};
        params.datas = datas;
        params.infodata = editform.getEditFormValues();
        params.bustype = _lefttabtype;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid, "saveTask", params, function (rs) {
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('任务下达成功！', function () {
                editwindow.hide();
                Ext.lt.pmkpi.query();

            });
        }, function () {
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('任务下达失败！', function () {
            });
        });
    });

    /**
     * 删除
     */
    cmp.del = function () {
        var params = {};
        var datas = datatable.getSelected();
        if (!datas || datas.size() <= 0) {
            Ext.lt.ui.alert('请选择要删除的数据！', function () {
            });
            return;
        }
        var pro_name="";
        for (var i=0; i<datas.length; i++) {
            var data = datas[i];
            var wfstatus = data.wfstatus;  //流程状态
            if (wfstatus != null){
                pro_name += data.name+"、";    //项目名称
            }
        }
        var message = "是否取消下达已选择数据？";
        if (pro_name != null && pro_name != ""){
            pro_name = pro_name.substring(0,pro_name.length-1);
            message = pro_name+" 已填报，\r\n是否确认取消？";
        }
        Ext.lt.ui.confirm(message, null, function (is) {
            if (is) {
                params.selDatas = datas;
                params.delcols = _delcols;
                params.deltables = _deltables;
                Ext.lt.ui.loadingShow();
                Ext.lt.RCP.call(serviceid, "delTask", params, function (rs) {
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert('取消下达成功！', function () {
                        Ext.lt.pmkpi.query();
                    });
                }, function () {
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert('取消下达失败！', function () {
                    });
                });
            }
        })
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
        if (!common.checkwfstatus(datas)) return false;//先校验审核状态是否一致
        var params = {};
        params.datas = datas;
        params.tablecode = _tablecode;
        params.busguid = _leftmenuid + "_" + datas[0]["wfstatus"];
        common.doAction(obj, params);
    }

    //页签方法
    cmp.clickTabpage = function (obj) {
        _tabhidtbtn = obj.hidebtns;
        var tabconfig = eval('(' + obj.config + ')');
        if (tabconfig && tabconfig[_lefttabtype + "filter"]) {
            tab_filters[_lefttabtype + "_" + obj.code] = tabconfig[_lefttabtype + "filter"];
        } else {
            tab_filters["program_" + obj.code] = obj["filter"];
            tab_filters["dept_" + obj.code] = obj["filter"];
            tab_filters["transprogram_" + obj.code] = obj["filter"];
        }
        if (!_isfirst) {
            common.changTooltoolbuttontStatus(0, _tabhidtbtn + "," + _lefthidebtn);
            if (_tabcode != obj.code) {
                _tabcode = obj.code;
                cmp.setTableColum();
                queryfrom();
                _querySql = "";
                if(_SYSTEMSTYLE_ == "grey"){
                    $("#queryform .searchLeft").css("height","50px");
                    queryform.retract();
                }
            }
            Ext.lt.pmkpi.querytree();
        } else {
            _tabcode = obj.code;
        }
    }

    /**
     * 关闭页面
     */
    cmp.close = function () {
        Ext.lt.ui.closeModalWindow();
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
        if(_tabcode =="waitaudit") {
            params.proguid = datas[0].pro_id;
        }else{
            params.proguid = datas[0].projguid;
        }
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

    /**
     * 下达任务窗口.
     * @constructor
     */
    cmp.SendWindow = function () {
        var buttons = [];
        buttons.push({
            name: 'boardsave',
            title: '下达',
            icon: 'boardsave',
            action: function () {
                Ext.lt.message.send("submit", "sendeditform");
            },
            disabled: false
        });
        buttons.push({
            name: 'del',
            title: '取消',
            icon: 'del',
            action: function () {
                editwindow.hide();
                Ext.lt.ui.loadingClose();
            },
            disabled: false
        });
        editwindow = new Ext.lt.ui.window({
            title: '自评工作布置',
            pop: true,
            mark: true,
            w: 500,
            h: 300,
            fitmode: 'body',
            className: 'windpblue',
            buttons: buttons
        });
        editwindow.style.display = "none";
        editwindow.draw(editform);
    }
    Ext.lt.message.hook("queryform", "doquery", function (obj) {
        _queryConfig = queryform.getQueryParam();
        if(_queryConfig[0].ALL_COLUMNS) {
            _querySql = "";
        } else {
            _querySql = queryform.getQuerySQL();
        }
        Ext.lt.pmkpi.query();
    });

    $(function () {
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        common.initDatatable();
        cmp.SendWindow(); //指标的发送窗口.
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
        _querySql = "";
        queryfrom();
        if(_SYSTEMSTYLE_ == "grey"){
            $("#queryform .searchLeft").css("height","50px");
            queryform.retract();
        }
        common.changTooltoolbuttontStatus(0,  _lefthidebtn + "," + _tabhidtbtn);
        cmp.setTableColum();
        common.setworkflow(_workflow);
        var treelist = Ext.lt.pmkpi.querytree();
        obj.datas = treelist;
        return obj;
    }

    function queryfrom() {
        var key;
        var querydatas;
        if (_lefttabtype == "program" || _lefttabtype == "transprogram" || _lefttabtype == "parentprogram") {
            key = '/pmkpi/perfselftaskmanage/index';
            querydatas = _proqfdatas;
        } else {
            key = '/pmkpi/perfselftaskmanage/dept';
            querydatas = _deptqfdatas;
        }
        for (var i=0; i<querydatas.length; i++) {
            var data = querydatas[i];
            if (_lefttabtype == "program" || _lefttabtype == "transprogram" || _lefttabtype == "parentprogram") {
                if (data.colcode == "NAME" && (_tabcode == "alreadyaudit" ||  _tabcode == "alldeals")) {
                    data.isvisiable = 1;
                } else if (data.colcode == "PRO_NAME" && _tabcode == "waitaudit") {
                    data.isvisiable = 1;
                }
                if (data.colcode == "PRO_NAME" && (_tabcode == "alreadyaudit" ||  _tabcode == "alldeals")) {
                    data.isvisiable = 0;
                } else if (data.colcode == "NAME" && _tabcode == "waitaudit") {
                    data.isvisiable = 0;
                }
            }
            if (_tabcode == "waitaudit") {
                if (data.colcode == "ARRANGERCREATER" || data.colcode == "CREATETIME") {
                    data.isvisiable = 0;
                }
            } else {
                if (data.colcode == "ARRANGERCREATER" || data.colcode == "CREATETIME") {
                    data.isvisiable = 1;
                }
            }
        }
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
            data: querydatas
        }
        queryform = new Ext.lt.bus.ui.querypanel(configqueryform);
        queryform.draw($(".busquerypanel_outline")[0]);
    }

    Ext.lt.pmkpi.querytree = function () {
        var params = {};
        params.menuid = _menuid;
        params.tablecode = _tablecode;
        params.lefttabtype = _lefttabtype;
        params.leftmenuid = _leftmenuid;
        params.tabcode = _tabcode; //页签编码
        params.tablesql = _defquerysql[_lefttabtype == "transprogram" ? "program" : _lefttabtype];
        params.tabsql = tab_filters[_lefttabtype + "_" + _tabcode];
        var datalist = Ext.lt.RCP.asyncall(service, "getTreeData", params);
        lefttree.setRecordset(datalist, 0);
        if (!_isfirst) {
            Ext.lt.pmkpi.query();
        }
        return datalist;
    }

    cmp.provincetask = function (btnobj) {
        var btnname = btnobj.name;
        var btntype = btnobj.code;
        var datas = datatable.getSelected();
        if(!datas.length || datas.length <= 0 ){
            Ext.lt.ui.alert("请选择要" + btnname + "的项目！",function(){});
            return;
        }
        for(var i=0; i<datas.length; i++){
            if (btntype == "province" && datas[i].provincetask == '1') {
                Ext.lt.ui.alert("选择数据中存在已经“" + btnname + "”过的项目，请检查！",function(){});
                return;
            } else if (btntype == "unprovince" && datas[i].provincetask == '2') {
                Ext.lt.ui.alert("选择数据中存在已经“" + btnname + "”过的项目，请检查！",function(){});
                return;
            }
        }
        Ext.lt.ui.confirm('是否' + btnname + '项目？',null,function(is){
            if(is){
                Ext.lt.ui.loadingShow();
                var params = {};
                params.datas = datas;
                params.protype = btntype;
                Ext.lt.RCP.call(service , "provincetask", params, function(rs){
                    if (rs && rs.flg == "1") {
                        Ext.lt.ui.alert(btnname + '成功！',function(){
                            Ext.lt.pmkpi.query();
                        });
                        Ext.lt.ui.loadingClose();
                    }
                },function(rt){
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert(btnname + '失败：' + rt,function(){
                    });
                });
            }
        })
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
                if (config.lefttabtype == _lefttabtype || (config.lefttabtype == "program" && (_lefttabtype == "transprogram" || _lefttabtype == "parentprogram"))) {
                    col.display = true;
                    if (_lefttabtype == "program" || _lefttabtype == "transprogram" || _lefttabtype == "parentprogram") {
                        if (col.colcode == "name" && _tabcode == "waitaudit" || col.colcode == "provincetask") {
                            col.display = false; //display置为false，隐藏
                            _displaycols.push(col); //隐藏前暂存至sfagency;
                        } else if ((col.colcode == "pro_name" || col.colcode == "bgtamt") && (_tabcode == "alreadyaudit" ||  _tabcode == "alldeals")){
                            col.display = false; //display置为false，隐藏
                            _displaycols.push(col); //隐藏前暂存至sfagency;
                        }
                        if (col.colcode == "provincetask" && (_tabcode == "alreadyaudit" ||  _tabcode == "alldeals")){
                            col.display = true;
                        }
                    }
                } else {
                    _displaycols.push(col); //隐藏前暂存至sfagency;
                    col.display = false; //display置为false，隐藏
                }
            }
            if(_tabcode == "waitaudit") {
                if (col.colcode == "arrangercreater" || col.colcode == "createtime") {
                    col.display = false; //display置为false，隐藏
                    _displaycols.push(col); //隐藏前暂存至sfagency;
                }
            } else {
                if (col.colcode == "arrangercreater" || col.colcode == "createtime") {
                    col.display = true; //display置为false，隐藏
                }
            }
        }
        var page = {};
        page.columns = "*";
        datatable.setPage(page);
        datatable.setSelfdefconfig({config: "{}"});
        datatable.redraw(); //从新绘制表格
    }

    return cmp;
}
