if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.deptevaluation){
    Ext.lt.pmkpi.deptevaluation = {};
}
if(!Ext.lt.pmkpi.deptevaluation){
    Ext.lt.pmkpi.deptevaluation = {};
}

Ext.lt.pmkpi.deptevaluation.resultservice = function(config, service){
    var cmp = {};
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var _menuid = config.menuid,//菜单id
        _leftmenuid,//隐藏菜单
        _lefttab = config.lefttab,//左侧树第一个页签
        _lefttabtype = _lefttab.code,//左侧树页签类型
        _lefttreename,//左侧评价对象树名称
        _lefthidebtn,//左侧树隐藏按钮
        _tabhidtbtn,//右侧页签隐藏按钮
        _finhide = config.finhide,//隐藏菜单后缀
        _categorydata = config.categorydata,//绩效类别数据
        _workflow,//工作流guid
        _tabcode,//页签code
        _tabfilter,//页签过滤条件
        _defquery,
        _prolev = config.prolev,//项目级次
        _displaycols = [],
        _saveAgency,//左侧树选择单位
        _lefttreename = "项目支出",//左侧评价对象树名称 默认项目支出
        _lefttabtype = "program",//左侧树页签guid 默认项目支出
        _bustype,
        scrWidth = document.body.clientWidth,
        scrHeight = document.body.clientHeight;
    var isfirst=true;
    var _isNINGXIA = config.isNINGXIA;
    /**
     * 左侧页签切换触发函数.
     */
    tabChange = function (obj) {
        _saveAgency = "treeroot";
        Ext.lt.pmkpi.isleaf = '0';
        _workflow = obj.leftwfid;
        _leftmenuid = obj.leftmenuid;
        _lefthidebtn = obj.hidebtns;
        _lefttabtype = obj["code"];
        _lefttreename = obj["name"];
        _bustype = _lefttabtype;
        common.changTooltoolbuttontStatus(0,  _lefthidebtn + "," + _tabhidtbtn);
        cmp.setTableColum();
        common.setworkflow(_workflow);
        common.setTabNum(obj);
        var treedatas =Ext.lt.pmkpi.querytree();
        Ext.lt.pmkpi.query();
        obj.datas = treedatas;
        return obj;
    }

    Ext.lt.pmkpi.querytree = function (){
        var params = {};
        params.menuid = _menuid;
        params.lefttabtype = _lefttabtype;
        params.leftmenuid = _leftmenuid;
        params.finhide = _finhide;
        params.bustype = _bustype;
        var datalist = Ext.lt.RCP.asyncall(service , "getTreeData", params);
        lefttree.setRecordset(datalist, 0);
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

    Ext.lt.pmkpi.query = function(){
        if(!_saveAgency){
            _saveAgency = "treeroot";
            Ext.lt.pmkpi.isleaf = 0;
        }
        Ext.lt.ui.loadingShow();
        var params = {};
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.menuid = _menuid;
        params.prolev = _prolev;
        params.saveAgency = _saveAgency;
        params.isleaf = Ext.lt.pmkpi.isleaf+"";
        params.workflow = _workflow;
        params.lefttabtype = _lefttabtype;
        params.tabfilter = _tabfilter;
        params.finhide = _finhide;
        params.leftmenuid = _leftmenuid;
        params.tabcode = _tabcode;
        params.tablesql = _defquery;
        params.beanid = "pmkpi.evaluation.dept.DeptResultBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params,function(){
            Ext.lt.ui.loadingClose();
        });
    }

    Ext.lt.message.hook("datatable", "drawed",function(obj){
        var uiconfig = obj.uiconfig;
        _defquery = uiconfig.defquery;
    });

    /**
     * 左侧树点击
     */
    Ext.lt.message.hook("left", "click",function(obj){
        var treeNode = obj.node.data;
        if(treeNode){ //不选择预算单位按类型查询
            _saveAgency = treeNode.guid;
            Ext.lt.pmkpi.isleaf = treeNode.isleaf;
        } else {
            _saveAgency = "treeroot";
            Ext.lt.pmkpi.isleaf = '0';
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
        datatable.setSelfdefconfig({config: "{}"});
        datatable.redraw(); //从新绘制表格
    }

    //送审情况
    cmp.queryaudit = function (){
        common.auditquery(datatable);
    }

    //页签方法
    cmp.clickTabpage = function(obj){
        _tabhidtbtn = obj.hidebtns;
        common.changTooltoolbuttontStatus(0,_lefthidebtn + "," + _tabhidtbtn);
        _tabfilter = obj.filter;
        _tabcode = obj.code;
        if (!isfirst) { //首次不走查询
            Ext.lt.pmkpi.query();
        }
    }

    /**
     *工作流.
     */
    cmp.wfAudit = function (obj){
        var datas = datatable.getSelected();
        var actionname = obj.name;
        var actioncode = obj.code;
        if (actionname == "审核") {
            if (datas.length != 1) {
                Ext.lt.ui.alert("请选择一条数据进行" + actionname + "！",function(){});
                return;
            }
            var params = {};
            params.mainguid = datas[0].guid;
            params.saveAgency = datas[0].agencyguid;
            params.projguid = datas[0].proguid;
            // params.viewtype = "query";
            params.workflow = _workflow;
            params.prolev = _prolev;
            params.bustype = _lefttabtype;
            params.audittype = "result";
            params.actioncode = actioncode;
            var url = "/pmkpi/evaluation/dept/auditedit.page";
            url = Ext.lt.pmkpi.genPageUrl(url, params);
            Ext.lt.ui.openModalWindow(url,scrWidth*0.7,scrHeight*0.7,"部门评价结果审核-"+_lefttreename);
        } else {
            if (datas.length <= 0) {
                Ext.lt.ui.alert("请选择数据进行" + actionname + "！",function(){});
                return;
            }
            if (!common.checkwfstatus(datas)) return false;//先校验审核状态是否一致
            var params = {};
            params.datas = datas;
            params.busguid = _lefttabtype + _finhide + "_" + datas[0]["wfstatus"];
            // 校验页签参数
            params.checktable = "v_perf_t_deptevaluation";
            if("program" == _lefttabtype){
                if (_isNINGXIA){
                    params.checkkey = "/pmkpi/evaluation/dept/result/editnx";
                } else {
                    params.checkkey = "/pmkpi/evaluation/dept/result/edit";
                }
            } else {
                params.checkkey = "/pmkpi/evaluation/dept/result/deptedit";
            }
            if ((obj.code == "audit" || obj.code == "sendaudit") && !common.checkTabPageData(params)) return false;//先校验
            common.doAction(obj, params);
        }

    }



    /**
     * 上传成果
     */
    cmp.resultupload = function(obj){
        var params = {};
        var data = datatable.getSelected();
        if(!data || data.length != 1){
            Ext.lt.ui.alert("请选择一条数据进行" + obj.name + "！",function(){});
            return;
        }
        if (obj.code == "queryresult") {
            params.viewtype = "query";
        }
        params.mainguid = data[0].guid;
        params.proguid = data[0].proguid;
        params.workflow = _workflow;
        params.bustype = _lefttabtype;
        params.saveAgency = data[0].agencyguid;
        var url = "";
        if (_lefttabtype && "program" == _lefttabtype) { //项目支出
            if (_isNINGXIA){
                url = "/pmkpi/evaluation/dept/result/editnx.page";
            } else {
                url = "/pmkpi/evaluation/dept/result/edit.page";
            }
        } else if (_lefttabtype && "dept" == _lefttabtype) { //部门整体
            url = "/pmkpi/evaluation/dept/result/deptedit.page";
        }


        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth, scrHeight, "上传结果-" + _lefttreename);
    }

    /**
     * 查看明细
     */
    cmp.detailed = function (){
        var params = {};
        var data = datatable.getSelected();
        if(!data || data.length <= 0){
            Ext.lt.ui.alert("请选择要查看的数据！",function(){});
            return;
        }
        params.submenu = _menuid;
        params.pro_code = data[0].code;
        common.proinfoview(datatable,params);
    }

    Ext.lt.message.hook("perfcommon", "auditquery",function(){
        Ext.lt.pmkpi.query();
    });

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        Ext.lt.pmkpi.query();
    });


    //审核
    cmp.evalaudit = function (obj) {
        var data = datatable.getSelected();
        if (data.length != 1) {
            Ext.lt.ui.alert("请选择一条数据进行审核！", function () {
            });
            return;
        }
        var url = "/pmkpi/audit/view.page";
        var params = {};
        params.mainguid = data[0].guid;
        params.proguid = data[0].proguid;
        params.guid = data[0].guid;
        params.projguid = data[0].projguid;
        params.procode = data[0].pro_code;
        params.agency = data[0].agencyguid;
        params.saveAgency = data[0].agencyguid;
        params.workflow = data[0].wfid;
        params.wfstatus = data[0].wfstatus;
        params.bustype = _lefttabtype;
        if (_lefttabtype && "program" == _lefttabtype) { //项目支出
            if (_isNINGXIA){
                params.uikey = "/pmkpi/evaluation/dept/result/editnx";
            } else {
                params.uikey = "/pmkpi/evaluation/dept/result/edit";
            }
        } else if (_lefttabtype && "dept" == _lefttabtype) { //部门整体
            params.uikey = "/pmkpi/evaluation/dept/result/deptedit";
        }
        params.wfstatus = data[0].wfstatus;
        params.pagetype = "audit";
        //params.querycode = "true";
        var nodemap = Ext.lt.RCP.asyncall(service, "queryPrevAuditType", [data[0].wfid, data[0].wfstatus]);
        params.nodeguid = nodemap.nodeguid;
        params.audittype = nodemap.audittype;
        if (!nodemap.audittype || nodemap.audittype == "" || nodemap.audittype == "null") {
            Ext.lt.ui.alert("请对流程审核节点进行配置！", function () {
            });
            return;
        }
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth, scrHeight, "绩效审核");
    }

    /**
     * 批量导出所有附件
     */
    cmp.allFileExp = function(obj) {
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
            if(_lefttabtype && _lefttabtype == "program"){
                params.code = data[i].pro_code;//项目编码
            }else {
                params.code = data[i].code;//部门编码
            }
            params.agency = data[i].agencyguid;//单位
            list.push(params);
        }
        var params = {};
        params.bustype =  _lefttabtype + "deptevaluationfile" ; // 文件表类型
        params.fileexptype = "deptevaluation"; //附件导出类型: 部门评价
        params.list = list;
        params.tokenid = Ext.lt.token.getTokenid();
        params.zipname = buttonconfig.zipname;
        var ins = Ext.lt.RCP.down("pmkpi.perfcommon.fileexp.FileExpService",'indexFileExp',params,'downframe');
    }


    return cmp;
}