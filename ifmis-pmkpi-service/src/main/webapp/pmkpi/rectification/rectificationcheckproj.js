if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.rectification)
    Ext.lt.pmkpi.rectification = {};
if(!Ext.lt.pmkpi.rectification.checkproj)
    Ext.lt.pmkpi.rectification.checkproj = {};

Ext.lt.pmkpi.rectification.checkproj = function(config, service){
    var commoncmp = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var serviceid = config.serverid,
        _bustype = config.bustype,
        _type = config.type,//1.RANDOMCOMMENT(抽评),2.FINEVALUATION(财政重点评价)
        _menuid = config.menuid,
        _workflow = config.workflow,
        _leftmenuid = config.leftmenuid,//隐藏菜单
        _querydatas = config.querydatas,//查询区数据
        _lefttreename = config.lefttreename,
        _selfquerydata = config.selfquerydata,//自评查询区数据
        _deptquerydatas = config.deptquerydatas,//部门查询区数据
        _tableSql,//表过滤条件
        _lefttabtype = "program",
        _treeid = "rectifytrace",
        _lefttype = _type,//通过这个变量记录_type值，点击抽评的时候，将_type的值改为抽评的标识，选择其他节点的时候再改回去
        _treename = "",
        _superguid ="00",
        _isleaf,
        _displaycols = [],
        _tablecode,
        _isNINGXIA = config.isNINGXIA,
        scrWidth =document.body.clientWidth,//页面宽度
        scrHeight =document.body.clientHeight;//页面高度

    var isfirst = false;

    //初始化
    $(function () {
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        commoncmp.initDatatable();
        //默认选中树的监控整改节点然后查询
        lefttree.cfg.trees[0].qtree.selectedNode("rectifytrace");
        _workflow = lefttree.cfg.rectifytrace;  //绩效监控发起整改的流程id
        // cmp.query();
    });

    Ext.lt.pmkpi.query = function () {
        cmp.query();
    }

    //查询
    cmp.query = function(){
        var params = {};
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.defquery = _tableSql;
        params.superguid = _superguid;
        params.bustype = _bustype;
        params.menuid = _menuid;
        params.treeid = _treeid;
        params.taskguid = _treeid;
        params.treename = _treename;
        params.type = _type;
        params.isleaf = _isleaf + "";
        params.tablecode = _tablecode;
        params.leftmenuid = _leftmenuid;
        if (_bustype == "3"){
            _lefttabtype = "dept";
        }
        params.lefttabtype = _lefttabtype;
        Ext.lt.ui.loadingShow();
        params.beanid = "pmkpi.rectification.checkpro.RectificationCheckProjBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params,function(){
            Ext.lt.ui.loadingClose();
        });
    }

    //财政重点评价(选择项目-确定)
    cmp.finadd = function(){
        var size = datatable.getRecordSet().size();
        if(size>0){
            var selecteds = datatable.getSelected().size();
            if (selecteds <= 0) {
                Ext.lt.ui.alert('请选择要项目数据！',function(){});
                return;
            }
            if (selecteds!=1) {
                Ext.lt.ui.alert("只能选择一条项目数据！",function(){});
                return;
            }
            var data = datatable.getSelected();
            Ext.lt.ui.loadingClose();
            parent.Ext.lt.ui.closeModalWindow();// 关闭
            window.parent.cmp.add(data);
        }
    }


    //(选择项目-确定)直接新增至列表
    cmp.add = function(obj){
        var btnconfig = eval('(' + obj.config + ')');
        var checkbox = btnconfig.checkbox;
        var selecteds = datatable.getSelected().size();
        var data = datatable.getSelected();
        if (_type == "RANDOMCOMMENT") { //抽评
            if (selecteds!=1) {
                alert("请选择一条项目数据！");
                return;
            }
            var params = {};
            params.projguid=data[0].guid;
            params.pro_code=data[0].pro_code;  //项目编码
            params.bustype=_bustype;
            params.type=_type;
            params.workflow=_workflow;
            Ext.lt.ui.loadingShow();
            Ext.lt.RCP.call(serviceid , "save", params, function(rs){
                if (rs.error) {
                    Ext.lt.ui.alert(rs.error);
                    Ext.lt.ui.loadingClose();
                    parent.Ext.lt.ui.closeModalWindow();// 关闭
                    window.parent.cmp.query();// 刷新
                } else {
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert(("保存成功！"),{}, function(ret) {
                        parent.Ext.lt.ui.closeModalWindow();// 关闭
                        parent.cmp.query();// 刷新
                    });
                }
            });
        } else {
            if (checkbox == true) {  //批量
                if (selecteds == 0) {
                    alert("请至少选择一条项目数据！");
                    return;
                }
                cmp.addBatch(data,_treeid,_superguid,_workflow);
            } else { //单个
                if (selecteds != 1) {
                    alert("请选择一条项目数据！");
                    return;
                }
                data[0].workflow = _workflow;
                cmp.addSingle(data,_treeid,_superguid);
            }
        }
    }

    //单个新增
    cmp.addSingle = function(data,lefttreeid,superguid){
        var params = {};
        var url;
        var editformurl;
        if (_lefttabtype && "program" == _lefttabtype) { //项目支出
            url = '/pmkpi/rectification/program/add.page';
            //判断是否是财政评价新增项目  只有项目支出能新增项目
            if (data[0].isadd == '1') {
                params.isfinadd = data[0].isadd;
                if ("rectifydepteval" == _treeid) {
                    editformurl = '/pmkpi/evaluation/dept/infoedit.page?viewtype=query';
                } else {
                    if (_isNINGXIA) {
                        editformurl = '/pmkpi/evaluation/finconfirm/infoedit.page?viewtype=query';
                    } else {
                        editformurl = '/pmkpi/evaluation/financial/confirm/editor.page?viewtype=query';
                    }
                }
                params[_treeid] = editformurl;
            }
        } else if (_lefttabtype && "dept" == _lefttabtype) { //部门整体
            url = '/pmkpi/rectification/dept/add.page';
        }
        var newguid = Ext.lt.RCP.asyncall(serviceid , "getCreateguid", null);
        params.mainguid = newguid;
        params.projguid = data[0].proguid;
        if(lefttreeid == "rectifyperfself"){
            params.projguid = data[0].projguid;
        }
        params.pro_code = data[0].pro_code;
        params.guid = data[0].guid;
        params.workflow = data[0].workflow;  //工作流
        params.treeid = lefttreeid;
        params.superguid = superguid;
        params.bustype = _bustype;
        params.lefttabtype = _lefttabtype;
        params.leftmenuid = _leftmenuid;
        params.rectifyType = _type;
        params.lefttreename = _lefttreename;
        params.menuid = _menuid;
        params.rectype = superguid == "00" ? _treeid : superguid;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"整改通知新增 - "+_lefttreename);
    }

    //批量新增
    cmp.addBatch = function(data,lefttreeid, superguid, workflow){
        var params = {};
        var url = '/pmkpi/rectification/addBatch.page';
        var newguid = Ext.lt.RCP.asyncall(serviceid , "getCreateguid", null);
        params.mainguid = newguid;
        params.workflow = workflow;  //工作流
        params.treeid = lefttreeid;
        params.superguid = superguid;
        params.bustype = _bustype;
        params.lefttabtype = _lefttabtype;
        params.leftmenuid = _leftmenuid;
        params.rectifyType = _type;
        params.lefttreename = _lefttreename;
        params.menuid = _menuid;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth, scrHeight, "整改通知新增 - " + _lefttreename);
    }

    Ext.lt.message.hook("left", "click",function(obj){
        var treeNode = obj.node.data;
        if(treeNode){
            _isleaf = treeNode.isleaf;
            _treeid = treeNode.guid;
            _treename = treeNode.name;
            _superguid = treeNode.superguid;
            if("rectifyrandomcomment"==treeNode.guid){  //抽评
                _type = 'RANDOMCOMMENT';
            }else{
                _type = _lefttype;
            }
        } else {
            _treeid = "treeroot";
            _isleaf = 0;
        }
        //不同类型的项目走不同的流程
        if("rectifyperfself" == _treeid){
            _workflow = lefttree.cfg.rectifyperfself;  //绩效自评发起整改的流程id
        }else if("rectifydepteval" == _treeid){
            _workflow = lefttree.cfg.rectifydepteval;  //部门评价发起整改的流程id
        }else if("rectifyfinancialeval" == _treeid){
            _workflow = lefttree.cfg.rectifyfinancialeval;  //财政评价发起整改的流程id
        }else{
            _workflow = lefttree.cfg.rectifytrace;  //绩效监控发起整改的流程id
        }

        //动态展示查询区字段
        var data;
        var key;
        if(_bustype == "1"){
            if (_treeid == "rectifyperfself"){
                data = _selfquerydata;
                key = '/pmkpi/rectification/check/selfproj';
            }else {
                data = _querydatas;
                key ="/pmkpi/rectification/check/proj";
            }
        }else{
            data = _deptquerydatas;
            key ="/pmkpi/rectification/check/deptproj";
        }
        queryfrom(data,key);//重画查询区
        $('.tbfastquery').css({'position':'relative','margin-right':'-20px','margin-top':'-15px'});
        cmp.setTableColum();
        if (isfirst) {
            cmp.query();
        }
        isfirst = true;
    });


    function queryfrom(data, key) {
        var  tables = $("#tablediv");
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
        var targetElement = $(".seachbox")[0] || $(".busquerypanel_outline")[0];
        queryform.draw(targetElement);
    }

    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        _tablecode = uiconfig.tablecode;
        _tableSql = uiconfig.defquery;
        var cols = uiconfig.columns;
        for (var i = 0, len = cols.length; i < len; i++) {
            var col = cols[i];
            var config = eval(col.config);
            if (config && config.iszp == 1) {
                _displaycols.push(col); //隐藏前暂存至sfagency;
                col.display = false; //display置为false，隐藏
            }
        }
    });

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
            var config = eval(col.config);
            if ( _treeid == "rectifydepteval" || _treeid == "rectifyfinancialeval") {
                if (config && (config.isjk == 1 || config.iszp == 1)) {
                    _displaycols.push(col); //隐藏前暂存至sfagency;
                    col.display = false; //display置为false，隐藏
                } else {
                    col.display = true;
                }
            } else if (_treeid == "rectifytrace" || _superguid == "rectifytrace") {
                if (config && config.iszp == 1) {
                    _displaycols.push(col); //隐藏前暂存至sfagency;
                    col.display = false; //display置为false，隐藏
                } else {
                    col.display = true;
                }
            } else if (_treeid == "rectifyperfself") {
                if (config && config.isjk == 1) {
                    _displaycols.push(col); //隐藏前暂存至sfagency;
                    col.display = false; //display置为false，隐藏
                } else {
                    col.display = true;
                }
            } else {
                col.display = true;
            }
        }
        var page = {};
        page.columns = "*";
        datatable.setPage(page);
        datatable.setSelfdefconfig({config: "{}"});
        datatable.redraw(); //从新绘制表格
    }

    /**
     * 查看明细
     */
    cmp.detailed = function() {
        var data = datatable.getSelected();
        var _uikey;
        var provincetask = data[0].provincetask; //1：重点监控  2：一般监控
        var tasktype = data[0].tasktype; //任务类型 项目/部门/政策
        var params = {};
        params.projguid = data[0].proguid;
        params.procode = data[0].pro_code;
        params.bustype = _lefttabtype;
        if (!data || data.length != 1) {
            Ext.lt.ui.alert("请选中一条数据进行查看！", function () {
            });
            return;
        }
        if("rectifyperfself" == _treeid){ //绩效自评
            params.projguid = data[0].projguid;
            if (_lefttabtype && _lefttabtype == "program") {
                _uikey = "/pmkpi/perfself/apply/edit";
            }else if (_lefttabtype && _lefttabtype == "dept") {
                _uikey = "/pmkpi/perfself/apply/dept/edit";
            }
        }else if("rectifydepteval" == _treeid){ //部门评价
            if (_lefttabtype && _lefttabtype == "program") {
                _uikey = "/pmkpi/evaluation/deptreport/proedit";
            }else if (_lefttabtype && _lefttabtype == "dept") {
                _uikey = "/pmkpi/evaluation/deptreport/deptedit";
            }
        }else if("rectifyfinancialeval" == _treeid){  //财政评价
            params.projcode = data[0].pro_code;
            if (_lefttabtype && _lefttabtype == "program") {
                _uikey = "/pmkpi/evaluation/finconfirm/proedit";
            }else if (_lefttabtype && _lefttabtype == "dept") {
                _uikey = "/pmkpi/evaluation/finconfirm/deptedit";
            }
        }else{  //绩效监控
            params.bustype = tasktype;
            if (tasktype && "protrace" == tasktype) { //项目支出
                if (provincetask && provincetask == "1") {
                    _uikey = "/pmkpi/program/trace/report/edit";
                } else {
                    _uikey = "/pmkpi/program/trace/report/ordinaryedit";
                }
            } else if (tasktype && "depttrace" == tasktype) { //部门整体
                _uikey = "/pmkpi/trace/report/deptedit";
            } else if (tasktype && "policytrace" == tasktype) { //重大政策
            }
        }
        var url = _uikey + ".page";
        params.mainguid = data[0].guid;
        params.agency = data[0].agencyguid;
        params.taskguid = data[0].taskguid;//监控任务guid
        params.saveAgency = data[0].agencyguid;
        params.viewtype = "query";
        params.workflow = _workflow;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth, scrHeight, "项目明细查看");
    }

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        cmp.query();
    });

    cmp.close = function () {
        Ext.lt.ui.closeModalWindow();// 关闭
    }

    Ext.lt.message.hook("window", "minwindow", function (obj) {
        cmp.query();
    });

    return cmp;
}
