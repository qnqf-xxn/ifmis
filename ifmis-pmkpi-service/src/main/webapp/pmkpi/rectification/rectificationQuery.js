if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.rectification)
    Ext.lt.pmkpi.rectification = {};

Ext.lt.pmkpi.rectification.query = function(config, service){
    var deptcmp = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var serviceid = service,
        _workflow,//工作流guid
        _leftmenuid,//隐藏菜单
        _menuid = config.menuid,//菜单guid
        _lefttab = config.lefttab,//左侧树第一个页签
        _lefttabtype = _lefttab.code,//左侧树页签类型
        _lefttreename,//左侧评价对象树名称
        _type = config.type,//1.RANDOMCOMMENT(抽评),2.FINEVALUATION(财政重点评价)
        _deptqfdatas = config.deptqfdatas,//部门查询区数据
        _proqfdatas = config.proqfdatas,//项目查询区数据
        _hidebth,
        _lefthidebtn,
        _bustype,
        _saveAgency,//左侧树选择单位
        _tablecode,//表名
        _displaycols = [],
        _tabfilter,//页签过滤条件
        _tabcode,//页签编码
        _defquery,//表配置过滤条件
        _orderby,//表排序sql
        _deltables,//删除主单时关联的子表名称集合
        _delcols,//删除主单时子表关联的字段编码集合，不传默认为mainguid
        _isNINGXIA = config.isNINGXIA,
        scrWidth =document.body.clientWidth,//页面宽度
        scrHeight =document.body.clientHeight;//页面高度
    var isfirst = true;

    //查询
    cmp.query = function (obj){
        Ext.lt.pmkpi.query();
    }
    /**
     * 左侧页签切换触发函数.
     */
    tabChange = function (obj) {
        _saveAgency = "treeroot";
        Ext.lt.pmkpi.isleaf = '0';
        _workflow = obj.leftwfid;
        _lefttabtype = obj["code"];
        _lefttreename = obj["name"];
        _leftmenuid = obj.leftmenuid;
        _lefthidebtn = obj.hidebtns;
        var data;
        var key;
        if (_lefttabtype == "program"){
            _bustype = "1";
            data = _proqfdatas;
            key = "/pmkpi/rectification/index";
        } else if (_lefttabtype == "dept") {
            _bustype = "3";
            data = _deptqfdatas;
            key = "/pmkpi/rectification/index/dept";
        }
        queryfrom(data, key);
        deptcmp.changTooltoolbuttontStatus(0,_hidebth + "," + _lefthidebtn);
        cmp.setTableColum();
        deptcmp.setworkflow(_workflow);
        var treedatas = Ext.lt.pmkpi.querytree();
        obj.datas = treedatas;
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

    //查询左侧树数据
    Ext.lt.pmkpi.querytree = function (){
        var params = {};
        params.menuid = _menuid;
        params.lefttabtype = _lefttabtype;
        params.bustype = _bustype;
        params.leftmenuid = _leftmenuid;
        var datalist = Ext.lt.RCP.asyncall(service , "getLeftTreeData", params);
        lefttree.setRecordset(datalist, 0);
        cmp.query();
        return datalist;
    }

    //左侧树点击节点
    Ext.lt.message.hook("left","click",function(datas){
        var treeNode = datas.node.data;
        if(treeNode){
            _saveAgency = treeNode.guid;
            Ext.lt.pmkpi.isleaf = treeNode.isleaf;
        } else {
            _saveAgency = "treeroot";
            Ext.lt.pmkpi.isleaf = '0';
        }
        cmp.query();
    });

    $(function (){
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        deptcmp.initDatatable();
        if (isfirst) {
            isfirst = false;
        }
        tabChange(_lefttab);
    })

    //查询
    Ext.lt.pmkpi.query = function(){
        if(!_saveAgency){
            _saveAgency = "treeroot";
            Ext.lt.pmkpi.isleaf = 0;
        }
        Ext.lt.ui.loadingShow();
        var params = {};
        params.saveAgency = _saveAgency;
        params.isleaf = Ext.lt.pmkpi.isleaf + "";
        params.menuid = _menuid;
        params.workflow = _workflow;
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.tablecode = _tablecode;
        params.tabfilter = _tabfilter;
        params.tablesql = _defquery;
        params.orderby = _orderby;
        params.tabcode = _tabcode;
        params.lefttabtype = _lefttabtype;
        params.leftmenuid = _leftmenuid;
        params.bustype = _bustype;
        params.type = _type;
        params.beanid = "pmkpi.rectification.RectificationQueryBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params,function(){
            Ext.lt.ui.loadingClose();
        });
    }

    /**
     * 查看项目明细
     */
    cmp.detailed = function(){
        var data = datatable.getSelected();
        var params = {};
        if(data.size()==1){
            if (_lefttabtype && "program" == _lefttabtype) { //项目支出
                var url = '/pmkpi/rectification/program/edit.page';
                params.tablecode = "V_PERF_PROJECT_INFO";
                //判断是否是财政评价新增项目 只有项目支出能新增
                if(!data || data[0].isadd == 1 ){
                    params.isfinadd = data[0].isadd;
                    var editformurl;
                    if ("rectifydepteval" == data[0].rectype) {
                        editformurl = '/pmkpi/evaluation/dept/infoedit.page?viewtype=query';
                    } else {
                        if (_isNINGXIA) {
                            editformurl = '/pmkpi/evaluation/finconfirm/infoedit.page?viewtype=query';
                        } else {
                            editformurl = '/pmkpi/evaluation/financial/confirm/editor.page?viewtype=query';
                        }
                    }
                    params[data[0].rectype] = editformurl;
                }
            } else if(_lefttabtype && "dept" == _lefttabtype) { //项目支出
               var url = '/pmkpi/rectification/dept/edit.page';
            }
            params.projguid = data[0].proguid;
            params.pro_code = data[0].pro_code;  //项目编码
            params.mainguid = data[0].guid;
            params.guid = data[0].guid;
            params.saveAgency = data[0].agencyguid;
            params.rectifyType = data[0].type;
            params.rectype = data[0].rectype;
            params.workflow = data[0].wfid;
            params.bustype = _bustype;
            params.pagetype = "editreport";
            params.viewtype = "query";
            params.leftmenuid = _leftmenuid;
            params.lefttabtype = _lefttabtype;
            params.lefttreename = _lefttreename;
            params.rectifyType = _type;
            params.menuid = _menuid;
            url = Ext.lt.pmkpi.genPageUrl(url, params);
            Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"整改通知详情 - "+_lefttreename);
        } else if(data.size() > 1) {
            Ext.lt.ui.alert('每次只能查看一条数据！',function(){});
        } else {
            Ext.lt.ui.alert('请选择要查看的数据！',function(){});
        }
    }

    /**
     * 查看项目
     */
    cmp.showProjView = function (obj){
        var data = datatable.getSelected();
        if(!data || data.length != 1){
            Ext.lt.ui.alert("请选中一条数据进行查看！",function(){});
            return;
        }
        if(data[0].isadd == 1 ){
            Ext.lt.ui.alert('财政评价新增的项目不存在项目库中，不能查看项目！！！',function(){});
        }else {
            var params = {};
            params.submenu = _menuid;
            params.pro_code = data[0].pro_code;
            deptcmp.proinfoview(datatable, params);
        }
    }

    /**
     * 查看项目明细
     */
    cmp.proDetail = function() {
        var data = datatable.getSelected();
        if (!data || data.length != 1) {
            Ext.lt.ui.alert("请选中一条数据进行查看！", function () { });
            return;
        }
        var rectype = data[0].rectype; // 整改类型
        var guid = data[0].guid; // 整改主键
        var proParam = {};
        proParam.rectype = rectype;
        proParam.guid = guid;
        var proData = Ext.lt.RCP.asyncall(serviceid, "getProDetail", proParam);

        var params = {};
        var _uikey;
        var provincetask = proData[0].provincetask; //1：重点监控  2：一般监控
        var tasktype = proData[0].tasktype; //任务类型 项目/部门/政策
        params.projguid = proData[0].proguid;
        params.procode = proData[0].pro_code;
        params.bustype = _lefttabtype;
        if("rectifyperfself" == rectype){ //绩效自评
            params.projguid = proData[0].projguid;
            if (_lefttabtype && _lefttabtype == "program") {
                _uikey = "/pmkpi/perfself/apply/edit";
            }else if (_lefttabtype && _lefttabtype == "dept") {
                _uikey = "/pmkpi/perfself/apply/dept/edit";
            }
        }else if("rectifydepteval" == rectype){ //部门评价
            if (_lefttabtype && _lefttabtype == "program") {
                _uikey = "/pmkpi/evaluation/deptreport/proedit";
            }else if (_lefttabtype && _lefttabtype == "dept") {
                _uikey = "/pmkpi/evaluation/deptreport/deptedit";
            }
        }else if("rectifyfinancialeval" == rectype){  //财政评价
            params.projcode = proData[0].pro_code;
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
        params.mainguid = proData[0].guid;
        params.agency = proData[0].agencyguid;
        params.taskguid = proData[0].taskguid;//监控任务guid
        params.saveAgency = proData[0].agencyguid;
        params.viewtype = "query";
        params.workflow = proData[0].workflow;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth, scrHeight, "项目明细查看");
    }

    Ext.lt.message.hook("datatable", 'beforesetcols',function(obj){
        var uiconfig = obj.table.uiconfig;
        var config = obj.table.config;
        _tablecode = uiconfig.tablecode;
        _defquery = uiconfig.defquery;
        _orderby = uiconfig.orderby;
        _deltables = config.deltables;//删除主单时关联的子表名称集合
        _delcols = config.delcols;//删除主单时子表关联的字段编码集合，不传默认为mainguid
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
            if (_lefttabtype == "program") {
                if (config && config.isdept == 1) {
                    _displaycols.push(col); //隐藏前暂存至sfagency;
                    col.display = false; //display置为false，隐藏
                } else {
                    col.display = true;
                }
            } else if (_lefttabtype == "dept") {
                if (config && config.ispro == 1) {
                    _displaycols.push(col); //隐藏前暂存至sfagency;
                    col.display = false; //display置为false，隐藏
                } else {
                    col.display = true;
                }
            }
        }
        var page = {};
        page.columns = "*";
        datatable.setPage(page);
        datatable.setSelfdefconfig({config: "{}"});
        datatable.redraw(); //从新绘制表格
    }

    //审核情况
    cmp.showwflogs = function (){
        deptcmp.auditquery(datatable);
    }

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        cmp.query();
    });
    return cmp;
}

