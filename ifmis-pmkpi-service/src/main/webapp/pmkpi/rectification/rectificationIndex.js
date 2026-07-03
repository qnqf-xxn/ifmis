if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.rectification)
    Ext.lt.pmkpi.rectification = {};

Ext.lt.pmkpi.rectification.index = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
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
        scrWidth =document.body.clientWidth * 0.98,//页面宽度
        scrHeight =document.body.clientHeight * 0.98;//页面高度
    var isfirst = true;
    var isquery = false;

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
        common.changTooltoolbuttontStatus(0,_hidebth + "," + _lefthidebtn);
        cmp.setTableColum();
        common.setworkflow(_workflow);
        common.setTabNum(obj);
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
        Ext.lt.pmkpi.query();
        return datalist;
    }

    $(function (){
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        common.initDatatable();
        var _lefttab = lefttree.getActiveTabCfg();
        //查询之前处理待送审，还是被退回页签
        common.pendingtasktab();
        tabChange(_lefttab);
        isfirst = false;
    })

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
        Ext.lt.pmkpi.query();
    });

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
        params.beanid = "pmkpi.rectification.RectificationBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params,function(){
            Ext.lt.ui.loadingClose();
        });
    }
    //修改
    cmp.edit = function(obj){
        var datas = datatable.getSelected();
        if (datas.length <= 0) {
            Ext.lt.ui.alert("请选择要" + obj.name + "的数据！",function(){});
            return;
        }
        if (datas.length > 1) {
            Ext.lt.ui.alert("只能选择一条项目数据！",function(){});
            return;
        }
        var params = {};
        if (_lefttabtype && "program" == _lefttabtype) { //项目支出
            var url = '/pmkpi/rectification/program/add.page';
            //判断是否是财政评价新增项目 只有项目支出能新增
            if(!datas || datas[0].isadd == 1 ){
                params.isfinadd = datas[0].isadd;
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
        } else if (_lefttabtype && "dept" == _lefttabtype) { //部门整体
            var url = '/pmkpi/rectification/dept/add.page';
        }
        params.projguid = datas[0].proguid;
        params.pro_code = datas[0].pro_code;  //项目编码
        params.mainguid = datas[0].guid;
        params.guid = datas[0].proguid;
        params.workflow = datas[0].wfid;
        params.rectype = datas[0].rectype;  //业务阶段  1：绩效监控   2：绩效自评  3：部门评价  4：财政评价
        params.bustype = _bustype;
        params.lefttabtype = _lefttabtype;
        params.rectifyType = _type;
        params.lefttreename = _lefttreename;
        params.menuid = _menuid;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth, scrHeight, "整改通知新增 - " + _lefttreename);
    }


    //删除
    cmp.del = function (){
        var size = datatable.getRecordSet().size();
        if(size>0){
            var selecteds = datatable.getSelected().size();
            if (selecteds <= 0) {
                Ext.lt.ui.alert('请选择要删除的数据！');
                return;
            }
            var data = datatable.getSelected();
            if(data[0].state != "0"){
                Ext.lt.ui.alert('无法删除已下发的数据！');
                return;
            }
            Ext.lt.ui.confirm('是否删除已选择整改信息？',null,function(is){
                if(is){
                    var data = datatable.getSelected();
                    var config = {};
                    config.list = data;
                    config = Ext.lt.RCP.asyncall(serviceid , "delByGuids", config);
                    if(config.error){
                        Ext.lt.ui.alert(config.error);
                    }
                    cmp.query();
                }
            });
        }else{
            Ext.lt.ui.alert('页面无数据！',function(){});
            return ;
        }
    }

    //送审/审核  下发
    cmp.wfAudit = function (obj){
        var datas = datatable.getSelected();
        if (datas.length <= 0) {
            Ext.lt.ui.alert("请选择要" + obj.name + "的数据！",function(){});
            return;
        }
        if (datas.length > 1) {
            var wfid = datas[0].wfid;
            for (var i = 0; i < datas.length; i++) {
                if (wfid != datas[i].wfid){
                    Ext.lt.ui.alert("请选择业务阶段相同的数据一起"+ obj.name +"！",function(){});
                    return;
                }
            }
        }
        if (!common.checkwfstatus(datas)) return false;//先校验审核状态是否一致
        var params = {};
        params.datas = datas;
        params.tablecode = _tablecode;
        params.workflow = datas[0].wfid;
        common.doAction(obj, params);
    }

    //保存并送审  送审
    Ext.lt.pmkpi.sendandudit = function(obj,datas){
        var actionname = obj.name;
        var actioncode = obj.code;
        var params = {};
        params.actioncode = actioncode;
        params.tablecode = _tablecode;
        params.datas = datas;
        params.bustype = _lefttabtype;
        params.workflow = _workflow;
        params.busguid = _menuid + "_" + datas[0].wfstatus;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid, "wfAudit", params, function(rt) {
            if (rt && rt.success == true) {
                Ext.lt.ui.alert(actionname + "成功！", function () {
                    Ext.lt.message.send("perfcommon", "auditquery", {});
                });
            }
        });
        Ext.lt.ui.loadingClose();
        Ext.lt.ui.modalWindow.close(); //关闭当前模态框
    }

    cmp.addproj = function(){
        if (_lefttabtype && "program" == _lefttabtype) { //项目支出
            var url = '/pmkpi/rectification/check/proj.page';
        } else if(_lefttabtype && "dept" == _lefttabtype) { //部门整体
            var url = '/pmkpi/rectification/check/deptproj.page';
        }
        var params = {};
        params.bustype = _bustype;
        params.lefttabtype = _lefttabtype;
        params.leftmenuid = _leftmenuid;
        params.lefttreename = _lefttreename;
        params.viewtype = "add";
        params.type = _type;
        params.menuid = _menuid;
        params.rectype = "1";   //整改类型   1:整改-选项目    2：自评-整改   3：监控 - 整改
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        isquery = true;
        Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"选择项目 - "+_lefttreename);
    }

    /**
     * 查看项目明细
     */
    cmp.detailed = function(){
        var data = datatable.getSelected();
        var params = {};
        if(data.size()==1){
            if (_lefttabtype && "program" == _lefttabtype) { //项目支出
                var url = '/pmkpi/rectification/program/add.page';
                //判断是否是财政评价新增项目
                if (!data || data[0].isadd == 1 ) {
                    params.isfinadd = data[0].isadd;
                    if (!data || data[0].isadd == 1 ) {
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
                }
            } else if(_lefttabtype && "dept" == _lefttabtype) { //项目支出
               var url = '/pmkpi/rectification/dept/add.page';
            }
            params.projguid = data[0].proguid;
            params.pro_code = data[0].pro_code;  //项目编码
            params.mainguid = data[0].guid;
            params.guid = data[0].guid;
            params.saveAgency = data[0].agencyguid;
            params.rectifyType = data[0].type;
            params.rectype = data[0].rectype;
            params.workflow = data[0].wfid;
            params.taskstage = data[0].taskstage;  //监控任务阶段
            params.taskguid = data[0].taskguid;  //监控任务guid
            params.bustype = _bustype;
            params.pagetype = "editreport";
            params.viewtype = "query";
            params.leftmenuid = _leftmenuid;
            params.lefttabtype = _lefttabtype;
            params.lefttreename = _lefttreename;
            params.rectifyType = _type;
            params.menuid = _menuid;
            //params.rectype = "1";   //整改类型   1:整改-选项目    2：自评-整改   3：监控 - 整改
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
            Ext.lt.ui.alert('财政评价新增项目不能查看项目！',function(){});
        }else {
            var params = {};
            params.submenu = _menuid;
            params.pro_code = data[0].pro_code;
            common.proinfoview(datatable,params);
        }
    }

    Ext.lt.message.hook("datatable", 'drawed',function(obj){
        var uiconfig = obj.uiconfig;
        var config = obj.config;
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
    //页签方法
    cmp.clickTabpage = function(obj){
        _hidebth = obj.hidebtns;
        common.changTooltoolbuttontStatus(0,_hidebth + "," + _lefthidebtn);
        _tabfilter = obj.filter;
        _tabcode = obj.code;
        if (!isfirst) {
            cmp.query();
        }
    }

    //审核情况
    cmp.showwflogs = function (){
        common.auditquery(datatable);
    }
    Ext.lt.message.hook("perfcommon", "auditquery",function(){
        cmp.query();
    });

    Ext.lt.message.hook("perfcommon", "tablequery",function(){
        cmp.query();
    });
    Ext.lt.message.hook("queryform", "doquery",function(obj){
        cmp.query();
    });

    Ext.lt.message.hook("window", "minwindow", function (obj) {
        if (isquery) {
            cmp.query();
            isquery = false;
        }
    });

    return cmp;
}
