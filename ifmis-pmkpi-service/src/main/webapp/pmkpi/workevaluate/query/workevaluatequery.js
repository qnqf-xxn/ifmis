if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.workevaluate){
    Ext.lt.pmkpi.workevaluate = {};
}
Ext.lt.pmkpi.workevaluate.query = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var _menuid = config.menuid,//菜单id
        _tablecode,
        _lefttreename,//左侧评价对象树名称 默认项目支出
        _leftmenuid,//隐藏菜单
        _lefttab = config.lefttab,//左侧树第一个页签
        _lefttabtype = _lefttab.code,//左侧树页签类型
        _provincescoretype = config.provincescoretype,
        _deptscoretype = config.deptscoretype,
        _saveAgency,//左侧树选择单位
        scrWidth = document.body.clientWidth,
        scrHeight = document.body.clientHeight;
    var _displaycols = [];//页签切换隐藏列

    Ext.lt.pmkpi.query = function(){
        if(!_saveAgency){
            _saveAgency = "treeroot";
            Ext.lt.pmkpi.isleaf = 0;
        }
        var params = {};
        params.querySql = queryform.getQuerySQL();
        params.tablecode = _tablecode;
        params.menuid = _menuid;
        params.saveAgency = _saveAgency;
        params.isleaf = Ext.lt.pmkpi.isleaf+"";
        params.bustype = _lefttabtype;
        if (_lefttabtype == "subprovince") {
            params.scoretype = _provincescoretype;
        } else {
            params.scoretype = _deptscoretype;
        }
        params.leftmenuid =_leftmenuid;
        params.beanid = "pmkpi.workevaluate.query.WorkEvaluateQueryBOTX";
        Ext.lt.ui.loadingShow();
        // datatable.queryData(params,function(){
        //     Ext.lt.ui.loadingClose();
        // });
        Ext.lt.RCP.call(service, "getDatas", params, function(data) {
            datatable.setDatas(data);
            Ext.lt.ui.loadingClose();
        })
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
            Ext.lt.pmkpi.isleaf = '0';
        }
        Ext.lt.pmkpi.query();
    });

    /**
     * 填报/修改. 查看明细
     */
    cmp.querydetailed = function (obj){
        var btnconfig = eval('(' + obj.config + ')');
        var params = {};
        params.viewtype = "query";
        var data = datatable.getSelected();
        if(!data || data.length != 1){
            Ext.lt.ui.alert("请选中一条数据进行查看！", function(){});
            return;
        }
        params.saveAgency = data[0].agencyguid;
        params.mainguid = data[0].guid;
        params.subprovince = data[0].subprovince;
        params.taskguid = data[0].taskguid;//任务guid
        params.tasktype = data[0].tasktype;//任务类型
        params.queryProvince=data[0].subprovince;
        params.queryYear=data[0].year;
        if (btnconfig) {
            params.hidetab = btnconfig[data[0].tasktype];
        }
        params.bustype = _lefttabtype;//业务类型
        var url = "";
        if (_lefttabtype && "dept" == _lefttabtype) { //预算部门
            url = "/pmkpi/workevaluate/report/deptedit.page";
        } else if (_lefttabtype && "subprovince" == _lefttabtype) { //下级财政
            params.provincescoretype = _provincescoretype;
            url = "/pmkpi/workevaluate/report/subprovinceedit.page";
        }
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"预算绩效工作管理考核-" + _lefttreename);
    }

    $(function (){
        common.initDatatable();
        tabChange(_lefttab);
    })

    //查看任务
    cmp.queryTask = function(){
        var data = datatable.getSelected();
        if(!data || data.length != 1){
            Ext.lt.ui.alert("请选中一条数据！");
            return
        }
        var params = {};
        params.tasktype = data[0].tasktype;
        params.guid = data[0].guid;
        params.year = data[0].year;
        params.province = data[0].province;
        var taskguid = Ext.lt.RCP.asyncall(service , "getTaskguid", params);
        params.guid = taskguid[0].taskguid;
        params.viewtype = 'query';
        params.tablecode = "PERF_T_WORKEVALUATETASK";
        params.mainguid = taskguid[0].taskguid;
        var url = '/pmkpi/workevaluate/task/edit.page';
        url = Ext.lt.pmkpi.genPageUrl(url,params);
        Ext.lt.ui.openModalWindow(url, scrWidth*0.95, scrHeight*0.95, "绩效管理工作考核任务查看")
    }

    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        //表配置
        _tablecode = uiconfig.tablecode;
    });

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        Ext.lt.pmkpi.query();
    });

    Ext.lt.message.hook("perfcommon", "auditquery",function(){
        Ext.lt.pmkpi.query();
        try {
            Ext.lt.ui.closeModalWindow();
        } catch (e) {
            Ext.lt.ui.modalWindow.close();
        }
    });

    /**
     * 左侧页签切换触发函数.
     */
    tabChange = function (obj) {
        _saveAgency = "treeroot";
        Ext.lt.pmkpi.isleaf = '0';
        _lefttabtype = obj["code"];
        _lefttreename = obj["name"];
        _leftmenuid = obj.leftmenuid;
        cmp.setTableColum();
        common.changTooltoolbuttontStatus(0,  obj.hidebtns);
        var treedatas = Ext.lt.pmkpi.querytree();
        obj.datas = treedatas;
        return obj;
    }

    Ext.lt.pmkpi.querytree = function (){
        var params = {};
        params.menuid = _menuid;
        params.tablecode = _tablecode;
        params.bustype = _lefttabtype;
        params.leftmenuid =_leftmenuid;
        var datalist = Ext.lt.RCP.asyncall(service , "getTreeData", params);
        lefttree.setRecordset(datalist, 0);
        Ext.lt.pmkpi.query();
        return datalist;
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
            if (config && !$.isEmptyObject(config) && col.alias != "序号") {
                if (config.lefttabtype == _lefttabtype) {
                    col.display = true;
                } else {
                    _displaycols.push(col); //隐藏前暂存至sfagency;
                    col.display = false; //display置为false，隐藏
                }
            }
        }
        datatable.setSelfdefconfig({config: "{}"});
        datatable.redraw(); //从新绘制表格
    }

    /**
     * 批量导出附件
     */
    cmp.expfile = function(obj) {
        var buttonconfig = eval('(' + obj.config + ')');
        var data = datatable.getSelected();
        if(data.length < 1){
            Ext.lt.ui.alert( "请选择数据进行附件导出！",function(){
            });
            return;
        }
        var list = [];
        for (var i = 0; i < data.size(); i++) {
            var params = {};
            params.guid = data[i].guid;//数据id
            params.name = data[i].name;//名称
            params.code = data[i].code;//项目编码
            list.push(params);
        }
        var params = {};
        params.bustype = _lefttabtype + "workevalfile" ; // 文件表类型
        params.fileexptype = "workeval";
        params.list = list;
        params.tokenid = Ext.lt.token.getTokenid();
        params.zipname = buttonconfig.zipname;
        Ext.lt.RCP.down("pmkpi.perfcommon.fileexp.FileExpService",'indexFileExp',params,'downframe');
    }

    return cmp;
}