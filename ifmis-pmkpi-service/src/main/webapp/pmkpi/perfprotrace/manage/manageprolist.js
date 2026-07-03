if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.perfprotrace){
	Ext.lt.pmkpi.perfprotrace = {};
}
if(!Ext.lt.pmkpi.perfprotrace.manageservice){
	Ext.lt.pmkpi.perfprotrace.manageservice = {};
}

Ext.lt.pmkpi.perfprotrace.manageservice = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
     var cmp = {};
     var _menuid = config.menuid,//菜单id
         _pagetype = config.pagetype,//菜单类型，部门、财政
         _taskguid = config.taskguid,//任务guid
         _tablecode,//列表查询表
         _prolev = config.prolev,//项目级次
         _tasktype = config.tasktype,//任务类型，项目/部门/政策
         _taskstage = config.taskstage,//任务阶段
         _tasksname = config.tasksname,//任务名称
         _tasksenddate = config.tasksenddate,//任务结束时间
         _isSx = config.isSx,//是否山西模式
         _isdismodel = config.isdismodel,
         _defquery,//列表查询条件
         _tabfilter,//页签查询条件
         _tabcode,//页签编码
         _wheresql, //配置查询条件
         _deltables,
         _delcols,
         _saveAgency,//左侧树选择单位
         _queryConfig, //查询区配置
         _querySql, //查询区条件
         scrWidth = document.body.clientWidth,
         scrHeight = document.body.clientHeight;

     var isfirst = true;
    var _displaycols = [];

     //查询
     cmp.query = function (){
         Ext.lt.pmkpi.query();
     }

     Ext.lt.pmkpi.query = function(){
         Ext.lt.ui.loadingShow();
         if (!_saveAgency) {
             _saveAgency = "treeroot";
             Ext.lt.pmkpi.isleaf = 0;
         }
         var params = {};
         params.queryConfig = _queryConfig;
         params.querySql = _querySql;
         params.tablecode = _tablecode;
         params.tablesql = _defquery ;
         params.menuid = _menuid;
         params.tabcode = _tabcode;
         params.pagetype = _pagetype;
         params.taskguid = _taskguid;
         params.prolev = _prolev;
         params.tasktype = _tasktype;
         params.wheresql = _wheresql;
         params.saveAgency = _saveAgency;
         params.taskstage = _taskstage;
         params.isleaf = Ext.lt.pmkpi.isleaf + "";
         params.beanid = "pmkpi.perfprotrace.manage.ProTraceManageBOTX";
         Ext.lt.bus.exportBeanid = params.beanid;
         datatable.queryData(params,function(){
             Ext.lt.ui.loadingClose();
         });
     }

     Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
         var uiconfig = obj.table.uiconfig;
         _defquery = uiconfig.defquery;
         _tablecode = uiconfig.tablecode;
         var config = obj.table.config;
         _deltables = config.deltables;
         _delcols = config.delcols;
     });

     /**
      * 复制任务
      */
     cmp.copytask = function (){
         var params = {};
         params.pagetype = _pagetype;
         params.taskguid = _taskguid;
         params.tabcode = _tabcode;
         params.prolev = _prolev;
         params.tasktype = _tasktype;
         params.tablecode = _tablecode;
         params.taskstage = _taskstage;
         params.tasksname = _tasksname;
         params.tasksenddate = _tasksenddate;
         var url = "/pmkpi/program/tracemanage/taskcopy.page";
         url = Ext.lt.pmkpi.genPageUrl(url, params);
         Ext.lt.ui.openModalWindow(url,scrWidth-600,scrHeight-260,"复制任务");
     }

     /**
     * 纳入任务
     */
     cmp.addtask = function (btnobj){
         var btnconfig;
         var btntype;
         if (btnobj.config) {
             btnconfig = eval('(' + btnobj.config + ')');
             btntype = btnconfig.btntype;
         }
         var btnname = "纳入";
         if (btntype == "province") {
             btnname = "标记";
         }
         var datas = datatable.getSelected();
         if(!datas.length || datas.length <= 0 ){
             Ext.lt.ui.alert("请选择要" + btnname + "的项目！",function(){});
             return;
         }
         var params = {};
         params.taskguid = _taskguid;
         params.datas = datas;
         if (btntype == "province") {
             if (_isdismodel) {
                 var data = Ext.lt.RCP.asyncall(service, "getProDatas", params);
                 if (data.length > 0) {
                     Ext.lt.ui.alert("选择数据中存在已标记过的项目，请检查！",function(){});
                     return;
                 }
             } else {
                 for(var i=0; i<datas.length; i++){
                     if (datas[i].provincetask == '1') {
                         Ext.lt.ui.alert("选择数据中存在已标记过的项目，请检查！",function(){});
                         return;
                     }
                 }
             }
         }
         Ext.lt.ui.confirm('是否' + btnname + '项目？',{icon: "warn"},function(is){
             if(is){
                 Ext.lt.ui.loadingShow();
                 //标记重点
                 if (btntype == "province") {
                     params.pagetype = btntype;
                 } else {
                     params.pagetype = _pagetype;
                 }
                 params.tabcode = _tabcode;
                 params.tasktype = _tasktype;
                 params.taskstage = _taskstage;
                 params.tasksname = _tasksname;
                 params.tasksenddate = _tasksenddate;
                 Ext.lt.RCP.call(service , "save", params, function(rs){
                     if (rs && rs.flg == "1") {
                         Ext.lt.ui.alert(btnname + '成功！',function(){
                             Ext.lt.pmkpi.query();
                             if (_tasktype == "protrace") {
                                 Ext.lt.pmkpi.querytree();
                             }
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
     * 取消任务
     */
     cmp.deltask = function (btnobj){
         var btnconfig;
         var btntype;
         if (btnobj.config) {
             btnconfig = eval('(' + btnobj.config + ')');
             btntype = btnconfig.btntype;
         }
         var btnname = "取消纳入";
         if (btntype == "province") {
             btnname = "取消标记";
         }
         var datas = datatable.getSelected();
         if(!datas.length || datas.length <= 0 ){
             Ext.lt.ui.alert("请选择要" + btnname + "的项目！",function(){});
             return;
         }
         if (btntype == "province") {
             for(var i=0; i<datas.length; i++){
                 if (datas[i].provincetask == '2') {
                     Ext.lt.ui.alert("选择数据中存在非重点项目，请检查！",function(){});
                     return;
                 }
             }
         }
         var params = {};
         params.selDatas = datas;
         // var rs = Ext.lt.RCP.asyncall(service , "checkdeltask", [params]);
         // if (!rs || rs <= 0) {
         //     Ext.lt.ui.alert('选中项目存在已审核数据，不能取消！',function(){
         //     });
         //     return;
         // }
         var message = "是否" + btnname + "？";
         if (_isSx != "1"){  //山西模式不走此判断
             var pro_name="";
             for (var i=0; i<datas.length; i++) {
                 var data = datas[i];
                 var wfstatus = data.wfstatus;  //流程状态
                 if (wfstatus != null){
                     pro_name += data.name+"、";    //项目名称
                 }
             }
             if (pro_name != null && pro_name != ""){
                 pro_name = pro_name.substring(0,pro_name.length-1);
                 message = pro_name+" 已填报，\r\n是否确认" + btnname + "？";
             }
         }
         Ext.lt.ui.confirm(message, {icon: "warn"}, function(is){
             if(is){
                 Ext.lt.ui.loadingShow();
                 var params = {};
                 if (btntype == "province") {
                     params.pagetype = btntype;
                 } else {
                     params.pagetype = _pagetype;
                 }
                 params.datas = datas;
                 params.taskguid = _taskguid;
                 params.tabcode = _tabcode;
                 params.tasktype = _tasktype;
                 params.delcols = _delcols;
                 params.deltables = _deltables;
                 params.btntype = btntype;
                 Ext.lt.RCP.call(service , "del", params, function(rs){
                     if (rs && rs.flg == "1") {
                         Ext.lt.ui.alert(btnname + '成功！',function(){
                             Ext.lt.pmkpi.query();
                             if (_tasktype == "protrace") {
                                 Ext.lt.pmkpi.querytree();
                             }
                         });
                         Ext.lt.ui.loadingClose();
                     }
                 },function(rt){
                     Ext.lt.ui.loadingClose();
                     Ext.lt.ui.alert('取消失败：' + rt,function(){
                     });
                 });
             }
         })
     }

    /**
     * 页签
     */
    cmp.clickTabpage = function (obj){
        changToolbuttonStatus(toolbutton, parseInt(obj.ordernum), obj.hidebtns);
        _tabfilter = obj.filter;
        if (!isfirst) {
            if(_tabcode != obj.code){
                _tabcode = obj.code;
                _saveAgency = "";
                queryfrom();
                if (_tasktype == "protrace") {
                    Ext.lt.pmkpi.querytree();
                }
            }
            cmp.setTableColum();
            Ext.lt.pmkpi.query();
        } else {
            _tabcode = obj.code;
            if (_tasktype == "protrace") {
                Ext.lt.pmkpi.querytree();
            }
        }

    }

    Ext.lt.pmkpi.querytree = function () {
        var params = {};
        params.menuid = _menuid;
        params.taskstage = _taskstage;
        params.tabcode = _tabcode;
        params.tabfilter = _defquery;
        params.taskguid = _taskguid;
        params.pagetype = _pagetype;
        var datalist = Ext.lt.RCP.asyncall(service, "getTreeData", params);
        lefttree.setRecordset(datalist, 0);
    }

    function queryfrom() {
        queryform.setSelfElements([]);
        if (queryform.getCol("bgtamt")) {
            if (_tabcode == "waitaudit") {
                queryform.getCol("bgtamt")._cfg.isvisiable = 1;
            } else if (_tabcode == "alreadyaudit"){
                queryform.getCol("bgtamt")._cfg.isvisiable = 0;
            }
        }
        _querySql = "";
        queryform.reset();
    }

    /**
     * 左侧树点击
     */
    Ext.lt.message.hook("left", "click",function(obj){
        var treeNode = obj.node.data;
        if(treeNode){
            _saveAgency = treeNode.guid;
            Ext.lt.pmkpi.isleaf = treeNode.isleaf;
        } else {
            _saveAgency = "treeroot";
            Ext.lt.pmkpi.isleaf = 0;
        }
        cmp.query();
    });

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        _queryConfig = queryform.getQueryParam();
        if(_queryConfig[0].ALL_COLUMNS) {
            _querySql = "";
        } else {
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
            // }else if (company == "3") { //单位：亿元
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
            //     if (bgtamt != null && _tabcode == "waitaudit") {
            //         wheresql += "(bgtamt " + oper_bgtamt + bgtamt + ") and ";
            //     }
            //     wheresql = wheresql.substring(0, wheresql.length - 4);
            //     _querySql = wheresql;
            // }
        }
        Ext.lt.pmkpi.query();
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
            if (config && !$.isEmptyObject(config) && col.alias != "序号") {
                if (config.lefttabtype == _tabcode) {
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
        datatable.redraw();
    }

    $(function (){
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        common.initDatatable();
        if (isfirst) {
            isfirst = false;
        }
        cmp.setTableColum();
        Ext.lt.pmkpi.query();
    })

     return cmp;
}