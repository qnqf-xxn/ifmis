if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.rectification)
    Ext.lt.pmkpi.rectification = {};
if(!Ext.lt.pmkpi.rectification.deptIndex)
    Ext.lt.pmkpi.rectification.deptIndex = {};

Ext.lt.pmkpi.rectification.deptIndex = function(config, service){
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
        _treeid,
        _treename,
        _leftwfid,
        _superguid,
        _lefthidebtn,
        _bustype,
        _wfid = [],
        _displaycols = [],
        _saveAgency,//左侧树选择单位
        _tablecode,//表名
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
        _leftwfid = obj.leftwfid;
        _leftwfid = _leftwfid.substring(1, _leftwfid.length - 1);  //去掉字符串首尾的大括号{}
        _wfid = _leftwfid.split(",");  //分割成数组
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
        params.leftmenuid = _leftmenuid;
        params.bustype = _bustype;
        var datalist = Ext.lt.RCP.asyncall(service , "getLeftTreeData", params);
        lefttree.setRecordset(datalist, 0);
        cmp.query();
        return datalist;
    }

    $(function (){
        tabChange(_lefttab);
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        common.initDatatable();
        isfirst = false;
    })

    //左侧树点击节点
    Ext.lt.message.hook("left","click",function(obj){
        var treeNode = obj.node.data;
        if(treeNode){
            Ext.lt.pmkpi.isleaf = treeNode.isleaf;
            _treeid = treeNode.guid;
            _treename = treeNode.name;
            _saveAgency = treeNode.guid;
            _superguid = treeNode.superguid;
        } else {
            _treeid = "treeroot";
            Ext.lt.pmkpi.isleaf = 0;
            _saveAgency = "treeroot";
        }
        cmp.setTableColum();
        cmp.query();
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
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.menuid = _menuid;
        params.lefttabtype =_lefttabtype;
        params.leftmenuid = _leftmenuid;
        params.tablecode = _tablecode;
        params.tabcode = _tabcode;
        params.bustype = _bustype;
        params.type = _type;
        params.treeid = _treeid;
        params.taskguid = _treeid;
        params.treename = _treename;
        params.superguid = _superguid;
        params.tabfilter = _tabfilter;
        params.tablesql = _defquery;
        params.orderby = _orderby;
        params.saveAgency = _saveAgency;
        params.beanid = "pmkpi.rectification.dept.RectificationDeptBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params,function(){
            Ext.lt.ui.loadingClose();
        });
    }

    //下达
    cmp.send = function (obj){
        var datas = datatable.getSelected();
        if (datas.length <= 0) {
            Ext.lt.ui.alert("请选择要" + obj.name + "的数据！",function(){});
            return;
        }
        var params = {};
        params.datas = datas;
        params.tablecode = _tablecode;
        params.guid = datas[0].guid;
        params.workflow = datas[0].wfid;
        params.pro_code = datas[0].pro_code;
        Ext.lt.ui.loadingShow();
        Ext.lt.ui.confirm('是否确定“' + obj.name + '”已选择的数据？',null,function(is){
            if(is){
                Ext.lt.RCP.call(serviceid, "send", params, function(rt) {
                    if(rt.error){
                        Ext.lt.ui.alert(rt.error);
                        Ext.lt.ui.loadingClose();
                        // Ext.lt.ui.closeModalWindow();// 关闭
                    } else{
                        Ext.lt.ui.loadingClose();
                        Ext.lt.ui.alert((obj.name +"成功！"),{}, function(ret) {
                            // Ext.lt.ui.closeModalWindow();// 关闭
                        });
                    }
                    cmp.query();
                });
            }
        });
        Ext.lt.ui.loadingClose();
    }

    //取消下达
    cmp.cancelsend = function (obj){
        var datas = datatable.getSelected();
        if (datas.length <= 0) {
            Ext.lt.ui.alert("请选择要" + obj.name + "的数据！",function(){});
            return;
        }
        var params = {};
        params.datas = datas;
        params.tablecode = _tablecode;
        params.guid = datas[0].guid;
        params.workflow = datas[0].wfid;
        params.pro_code = datas[0].pro_code;
        Ext.lt.ui.loadingShow();
        Ext.lt.ui.confirm('是否确定“' + obj.name + '”已选择的数据？',null,function(is){
            if(is){
                Ext.lt.RCP.call(serviceid, "cancleSend", params, function(rt) {
                    if(rt.error){
                        Ext.lt.ui.alert(rt.error);
                        Ext.lt.ui.loadingClose();
                        // Ext.lt.ui.closeModalWindow();// 关闭
                    } else{
                        Ext.lt.ui.loadingClose();
                        Ext.lt.ui.alert((obj.name +"成功！"),{}, function(ret) {
                            // Ext.lt.ui.closeModalWindow();// 关闭
                        });
                    }
                    cmp.query();
                });
            }
        });
        Ext.lt.ui.loadingClose();
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

    /**
     * 查看项目明细
     */
    cmp.detailed = function(){
        var data = datatable.getSelected();
        var params = {};
        if (data.size() == 1) {
            if (_lefttabtype && "program" == _lefttabtype) { //项目支出
                var url = '/pmkpi/rectification/program/add.page';
                //判断是否是财政评价新增项目 只有项目支出能新增
                if (!data || data[0].isadd == 1 ) {
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
            } else if (_lefttabtype && "dept" == _lefttabtype) { //部门整体
                var url = '/pmkpi/rectification/dept/add.page';
            }
            params.projguid = data[0].proguid;
            params.pro_code = data[0].pro_code;  //项目编码
            params.mainguid = data[0].guid;
            params.guid = data[0].guid;
            params.saveAgency = data[0].agencyguid;
            params.rectifyType = data[0].type;
            params.rectype = data[0].rectype;
            params.bustype = _bustype;
            params.pagetype = "editreport";
            params.viewtype = "query";
            params.workflow = data[0].wfid;
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
        if(!data || data[0].isadd == 1 ){
            Ext.lt.ui.alert('财政评价新增项目不能查看项目！',function(){});
        }else {
            var params = {};
            params.submenu = _menuid;
            params.pro_code = data[0].pro_code;
            common.proinfoview(datatable, params);
        }
    }

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
            if (_treeid == "rectifyperfself" || _treeid == "rectifydepteval" || _treeid == "rectifyfinancialeval") {
                if (config && config.isjk == 1) {
                    _displaycols.push(col); //隐藏前暂存至sfagency;
                    col.display = false; //display置为false，隐藏
                } else {
                    col.display = true;
                }
            }else{
                col.display = true;
            }
        }
        var page = {};
        page.columns = "*";
        datatable.setPage(page);
        datatable.redraw(); //从新绘制表格
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
    Ext.lt.message.hook("queryform", "doquery",function(obj){
        cmp.query();
    });
    return cmp;
}