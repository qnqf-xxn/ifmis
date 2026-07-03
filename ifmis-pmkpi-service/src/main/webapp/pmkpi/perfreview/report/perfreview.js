if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.perfreview){
    Ext.lt.pmkpi.perfreview = {};
}

Ext.lt.pmkpi.perfreview.reportservice = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var serviceid = service;
    var cmp = {};
    var _menuid = config.menuid,//菜单id
        _busguid = config.busguid,//审核定义guid
        _workflow,
        _datasource,//数据源集合
        _proworkflow = config.proworkflow,//项目工作流guid
        _deptworkflow = config.deptworkflow,//部门工作流guid
        _zyzfproworkflow = config.zyzfproworkflow,//转移支付项目工作流guid
        _depthidemenuid = config.depthidemenuid,//项目的隐藏菜单
        _programhidemenuid = config.programhidemenuid,//部门的隐藏菜单
        _prolev = config.prolev,//项目级次
        _deptqfdatas = config.deptqfdatas,//部门查询区数据
        _proqfdatas = config.proqfdatas,//项目查询区数据
        _defquery,//列表查询条件
        _tabfilter,//页签查询条件
        _tabcode,//页签编码
        _saveAgency,//左侧树选择单位
        _isQuery = Ext.lt.getparam("isquery")==1,
        _uikey,//跳转url
        _tablecode,
        _lefttabtype = config.lefttabtype,//左侧页签类型
        _lefttreename,//左侧评价对象树名称 默认项目支出
        scrWidth = document.body.clientWidth,
        scrHeight = document.body.clientHeight;
    if (_lefttabtype == "zyzfprogram"){//如果是转移支付项目支出则设置左侧树默认
        _lefttabtype = "zyzfprogram";//左侧页签类型(转移支付)
        _lefttreename = "转移项目支出";//左侧评价对象树名称(转移支付)
    } else {
        _lefttabtype = "program";//左侧页签类型(转移支付)
        _lefttreename = "项目支出";//左侧评价对象树名称(转移支付)
    }
    var _displaycols = [];
    var btnhid;

    var isfirst = true;
    /**
     * 左侧页签切换触发函数.
     */
    tabChange = function (obj) {
        _saveAgency = "treeroot";
        Ext.lt.pmkpi.isleaf = '0';
        _lefttabtype = obj["code"];
        var data;
        var key;
        if (_lefttabtype == "program") {
            _lefttreename = "项目支出";
            _workflow = _proworkflow;
            _menuid = _programhidemenuid;
            data = _proqfdatas;
            key = "/pmkpi/review/report/program";
            common.changTooltoolbuttontStatus(0, btnhid);
        }else if(_lefttabtype == "dept"){
            _lefttreename = "部门整体";
            _workflow = _deptworkflow;
            _menuid = _depthidemenuid;
            data = _deptqfdatas
            key = "/pmkpi/review/report/dept";
            common.changTooltoolbuttontStatus(0, "修改项目," + btnhid);
        }else if (_lefttabtype == "zyzfprogram") {
            _lefttreename = "转移项目支出";
            _workflow = _zyzfproworkflow;
            _menuid = _programhidemenuid;
            data = _proqfdatas;
            key = "/pmkpi/review/report/program";
            common.changTooltoolbuttontStatus(0, btnhid);
        }
        var params = {};
        params.tablecode = _tablecode;
        common.setworkflow(_workflow);
        queryfrom(data,key);
        cmp.setTableColum();
        var treedatas = Ext.lt.pmkpi.querytree();
        Ext.lt.pmkpi.query();
        obj.datas = treedatas;
        return obj;
    }

    Ext.lt.pmkpi.querytree = function (){
        var params = {};
        params.menuid = _menuid;
        params.tablecode = _tablecode;
        params.lefttabtype = _lefttabtype;
        var datalist = Ext.lt.RCP.asyncall(serviceid , "getTreeData", params);
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

    $(function (){
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        if(_isQuery) {
            var cfg = tabpage.cfg.data;
            for(var i = 0;i<cfg.length;i++){
                if(cfg[i].code == "alldeals"){
                    tabpage.doActiveTab(i);
                    break;
                }
            }
            _proworkflow=null;
            _deptworkflow =null;
            _zyzfproworkflow = null;
            _workflow = null;
            $("#tabpage")[0].style.display="none";
        }
        common.initDatatable();
        isfirst = false;
        var params = {};
        params.ordernum = 0;
        params.code = _lefttabtype;
        params.name = _lefttreename;
        tabChange(params);
    })

    /**
     * 查询
     */
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
        params.tabfilter = _tabfilter;
        params.workflow = _workflow;
        params.lefttabtype = _lefttabtype;
        common.setColDatasource(_datasource, datatable);
        params.beanid = "pmkpi.perfreview.PerfReviewBOTX";
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
        }else {
            _saveAgency = "treeroot";
            Ext.lt.pmkpi.isleaf = '0';
        }
        Ext.lt.pmkpi.query();
    });

    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        var talbeconfig = eval('(' + uiconfig.config + ')');
        if (talbeconfig) {
            _defquery = talbeconfig[_lefttabtype];
        }
        var config = obj.table.config;
        _tablecode = uiconfig.tablecode;
        _uikey = config.uikey;
    });

    var colsStatus = {};
    /**
     * 动态配置表格的列.
     *
     * @param data --
     */
    cmp.setTableColum = function(){
        var cols = datatable.getCols(); //获取列表所有列
        cols.push.apply(cols, _displaycols);
        _displaycols = [];
        for (var i = 0, len = cols.length; i < len; i++) {
            var col = cols[i];
            if (col.colcode == "freviewname" || col.colcode == "shjl") {
                colsStatus[col.colcode] = col.display;
            }
            var config = eval(col.config);
            if (config && !$.isEmptyObject(config) && col.alias != "序号") {
                if (config.lefttabtype && config.lefttabtype.indexOf(_lefttabtype) != -1) {
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

    //页签方法
    cmp.clickTabpage = function(obj){
        btnhid = obj.hidebtns;
        var tabcode = obj.code;
        if (tabcode == "program" || tabcode == "dept" || tabcode == "zyzfprogram") {
            return;
        }
        if (_lefttabtype == "dept") {
            common.changTooltoolbuttontStatus(0,obj.hidebtns+",修改项目");
        } else {
            common.changTooltoolbuttontStatus(0,obj.hidebtns);
        }
        _tabfilter = obj.filter;
        _tabcode = obj.code;
        if (!isfirst) {
            Ext.lt.pmkpi.query();
        }
    }

    cmp.create = function(){
        // var data = datatable.getSelected();
        // if(!data || data.length != 1){
        //     Ext.lt.ui.alert("请选中一条数据！！",function(){});
        //     return;
        // }
        // var params = {};
        // params.saveAgency = data[0].agencyguid;
        // params.mainguid = data[0].proguid;
        // params.workflow = _workflow;
        // params.datas = data;
        // var url = "/pmkpi/assessment/evaluate/audit.page";
        // url = Ext.lt.pmkpi.genPageUrl(url, params);
        // Ext.lt.ui.openModalWindow(url,1000,800,"事前绩效评估审核");
        var data = datatable.getSelected();
        if(!data || data.length != 1){
            Ext.lt.ui.alert("请选中一条数据！！",function(){});
            return;
        }
        var params = {};
        params.saveAgency = data[0].agencyguid;
        params.mainguid = data[0].proguid;
        params.pro_code = data[0].pro_code;
        params.workflow = _workflow;
        params.bustype = _lefttabtype;
        params.datas = data;
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(serviceid , "savereviewdatas", params);
        Ext.lt.ui.loadingClose();
        if(rs && rs.success){
            Ext.lt.ui.alert(rs.returnval, function(){
            });
        }
        return rs;
    }

    /**
     * 评审
     */
    cmp.assess = function(){
        var data = datatable.getSelected();
        if(!data || data.length != 1){
            Ext.lt.ui.alert("请选中一条数据进行评审！",function(){});
            return;
        }
        var params = {};
        params.saveAgency = data[0].agencyguid;
        params.mainguid = data[0].guid;
        params.proguid = data[0].proguid;
        params.procode = data[0].pro_code;
        params.querycode = "true";
        params.pagetype = "review";
        params.workflow = _workflow;
        params.viewtype = "add";
        params.reviewnum = data[0].reviewnum;
        params.bustype = data[0].type;
        var url = "";
        if (_lefttabtype == "program" || _lefttabtype == "zyzfprogram") { //项目支出
            url = "/pmkpi/review/report/proedit.page";
        } else if ( _lefttabtype == "dept") { //部门整体
            params.showtab = "3";
            url = "/pmkpi/review/report/deptedit.page";
        } else if ("policytrace" == _lefttreeid) { //重大政策
            return;
        }
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"绩效目标评审-"+_lefttreename);
    }


    /**
     * 查看
     */
    cmp.assessinfo = function(){
        var data = datatable.getSelected();
        if(!data || data.length != 1){
            Ext.lt.ui.alert("请选中一条数据进行查看！",function(){});
            return;
        }
        var params = {};
        params.saveAgency = data[0].agencyguid;
        params.mainguid = data[0].guid;
        params.proguid = data[0].proguid;
        params.procode = data[0].pro_code;
        params.querycode = "true";
        params.pagetype = "review";
        params.workflow = _workflow;
        params.viewtype = "query";
        params.reviewnum = data[0].reviewnum;
        params.bustype = data[0].type;
        params.isquery = _isQuery;
        var url = "";
        if (_lefttabtype == "program" || _lefttabtype == "zyzfprogram") { //项目支出
            url = "/pmkpi/review/report/proedit.page";
        } else if ( _lefttabtype == "dept") { //部门整体
            params.showtab = "3";
            url = "/pmkpi/review/report/deptedit.page";
        } else if ("policytrace" == _lefttreeid) { //重大政策
            return;
        }
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"绩效目标评审-"+_lefttreename);
    }

    //送审情况
    cmp.showwfinfo = function (){
        common.auditquery(datatable);
    }
    /**
     * 委托专家
     */
    cmp.entrustexpert = function(){
        var data = datatable.getSelected();
        if(!data || data.length != 1){
            Ext.lt.ui.alert("请选中一条数据进行委托专家！",function(){});
            return;
        }
        var params = {};
        var url = "/pmkpi/review/entrust/expert.page";
        params.guid = data[0].guid;
        params.proguid = data[0].proguid;
        params.workflow = _workflow;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,scrWidth*0.9,scrHeight*0.9,"委托专家");
    }

    /**
     * 确认评审
     */
    cmp.confirm = function(obj){
        var btnname = obj.name;
        var datas = datatable.getSelected();
        if(datas.length == 0){
            Ext.lt.ui.alert("请选中数据进行确认评审！",function(){});
            return;
        }
        for (var i=0; i<datas.length; i++){
            var data = datas[i];
            if (colsStatus.freviewname) {
                if (!data["freviewname"] || data["freviewname"] == null || data["freviewname"] == ""){
                    Ext.lt.ui.alert('请填写评审意见！',function(){
                    });
                    return;
                }
            }
            if (colsStatus.shjl) {
                if (!data["shjl"] || data["shjl"] == null || data["shjl"] == ""){
                    Ext.lt.ui.alert('请填写评审意见！',function(){
                    });
                    return;
                }
            }
        }
        Ext.lt.ui.confirm("是否" + btnname + "？",{icon: "warn"},function(is) {
            if (is) {
                var params = {};
                params.datas = datas;
                params.workflow = _workflow;
                params.busguid = _menuid +"_"+ datas[0].wfstatus;
                Ext.lt.ui.loadingShow();
                var rs = Ext.lt.RCP.asyncall(serviceid , "confirm", params);
                Ext.lt.ui.loadingClose();
                if(rs && rs.success){
                    Ext.lt.ui.alert('确认评审成功！',function(){
                        Ext.lt.pmkpi.query();
                    });
                } else if (rs && rs.success == false) {
                    common.openlistdiv(rs);
                } else if (rs && rs.msg) {
                    Ext.lt.ui.alert(rs.msg,function(){});
                }
            }
        })
    }

    /**
     * 取消确认评审
     */
    cmp.unconfirm = function(obj){
        var btncode = obj.code;
        var btnname = obj.name;
        var data = datatable.getSelected();
        if(data.length == 0){
            Ext.lt.ui.alert("请选中数据进行" + btnname + "！",function(){});
            return;
        }
        Ext.lt.ui.confirm("是否" + btnname + "？",{icon: "warn"},function(is){
            if(is){
                var params = {};
                params.datas = data;
                params.workflow = _workflow;
                params.btncode = btncode;
                Ext.lt.ui.loadingShow();
                var rs = Ext.lt.RCP.asyncall(serviceid , "unconfirm", params);
                Ext.lt.ui.loadingClose();
                if(rs && rs.success){
                    Ext.lt.ui.alert(btnname + '成功！',function(){
                        Ext.lt.pmkpi.query();
                    });
                } else if (rs && rs.msg) {
                    Ext.lt.ui.alert(rs.msg,function(){});
                }
            }
        })
    }

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        Ext.lt.pmkpi.query();
    });

    //导入
    cmp["import"] = function(obj){
        Ext.lt.ui.confirm('已评审过的意见会被覆盖，是否确认导入？',{icon: "warn"},function(is){
            if(is){
                var config = eval('(' + obj.config + ')');
                var params = {};
                params.beanid = "pmkpi.perfreview.PerfReviewBOTX";
                params.impexpcode = _lefttabtype;//导出编码
                params.expfilename = config.expfilename + ".xls";//导出模板文件名称
                impexp.imp(params, function (){
                    window.parent.Ext.lt.outfile.window.close();
                    parent.Ext.lt.pmkpi.query();
                });
            }
        })
    }

    /**
     * 批量抓取未提交到绩效的数据
     */
    cmp.batchadd = function (obj){
        var params = {};
        var url = "/pmkpi/review/report/batchadd.page";
        params.workflow = _workflow;
        params.bustype = _lefttabtype;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth * 0.7, scrHeight * 0.7, obj.name + "-" + _lefttreename);
    }

    cmp.modProgram = function (){
        var data = datatable.getSelected();
        if(!data || data.length != 1){
            Ext.lt.ui.alert("请选中一条数据进行修改！",function(){});
            return;
        }
        var params = {};
        params.pro_code = data[0].pro_code;
        params.submenu = config.menuid;
        common.modproinfo(datatable, params);
    }

    Ext.lt.message.hook("toolbutton","beforecreatbtn",function(obj){
        if(_isQuery&&obj.data.buttons.length>0&&obj.key=="/pmkpi/review/report/list") {
            var btns= [];
            for(var i=0;i<obj.data.buttons.length;i++){
                if(obj.data.buttons[i].code == "assess"){
                    obj.data.buttons[i].code = "assessinfo";
                    obj.data.buttons[i].oriaction = "pmkpireviewreport.assessinfo";
                    obj.data.buttons[i].name = "查看详情";
                    obj.data.buttons[i].title = "查看详情";
                    btns.push(obj.data.buttons[i]);
                }
                if(obj.data.buttons[i].code == "showwfinfo"||obj.data.buttons[i].code =="export"){
                    btns.push(obj.data.buttons[i]);
                }
            }
            obj.data.buttons = btns;
        }
    })

    return cmp;
}



