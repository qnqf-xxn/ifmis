if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.indexaudit)
    Ext.lt.pmkpi.indexaudit = {};

var zcolumns = {};
Ext.lt.pmkpi.indexaudit = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var _treeid,
        _levelno = 1,
        _lefttreename,//左侧评价对象树名称 默认项目支出
        _lefthidebtn,//左侧树隐藏按钮
        _tabhidtbtn,//右侧页签隐藏按钮
        _leftmenuid,//隐藏菜单
        _lefttab = config.lefttab,//左侧树第一个页签
        _lefttabtype = _lefttab.code,//左侧树页签类型
        _indextype = config["pagetype"],
        _isleaf,
        _treeNode,
        _tabfilter, //页签标签
        _tabcode, ////页签编码
        _queryfilter,
        _scrWidth =document.body.clientWidth,
        _scrHeight =document.body.clientHeight,
        _workflow;

    var cmp = {};
    var isFirst = true;

    $(function (){
        common.initDatatable();
        _lefttab = lefttree.getActiveTabCfg();
        common.pendingtasktab();
        tabChange(_lefttab);
        isFirst = false;
    });

    Ext.lt.message.hook("left", "click",function(obj){
        var treeNode = obj.node.data;
        if (treeNode){
            _treeid = treeNode.guid;
            _isleaf = treeNode.isleaf;
            _levelno = treeNode.levelno;
            _treeNode = treeNode;
        } else {
            _treeid = "treeroot";
            _isleaf = 0;
        }
        cmp.query();
    });
    Ext.lt.message.hook("queryform", "doquery",function(obj){
        if (obj.queryform){
            _queryfilter = obj.queryform.getQuerySQL();
        }
        cmp.query(_queryfilter);
    });

    Ext.lt.message.hook("datatable", 'beforesetcols',function(obj){
        var uiconfig = obj.table.uiconfig;
        zcolumns = uiconfig.columns;
        $.each(zcolumns, function(i, item){
            if(item && item["isvisiable"] == 0){
                delete zcolumns[i];
            }
        });
    });

    Ext.lt.message.hook("perfcommon", "auditquery", function () {
        cmp.query();
        try {
            Ext.lt.ui.closeModalWindow();
        } catch (e) {
            Ext.lt.ui.modalWindow.close();
        }
    });

    /**
     * 查询
     */
    Ext.lt.pmkpi.query = function(){
        cmp.query();
    }
    /**
     * 查询
     */
    cmp.query = function(filter){
        if (!_treeid) {
            _treeid = "treeroot";
        }
        var params = {};
        params.treeid = _treeid;
        params.indextype = _indextype;
        params.tabtype = _lefttabtype;
        params.isleaf = _isleaf;
        params.menuid = _leftmenuid; //菜单
        params.tabcode = _tabcode; // 页签编码
        params.levelno = _levelno;
        if (filter) {
            params.querySql = filter; //工作流
        }
        params.tabfilter = _tabfilter; //页签过滤条件
        params.workflow = _workflow; //工作流
        try{
            if (!queryform)params.queryConfig = queryform.getQueryParam();
            params.querySql = queryform.getQuerySQL();
        }catch (e) {}
        Ext.lt.ui.loadingShow();
        params.beanid = "pmkpi.setting.indexlib.audit.IndexAuditBOTx";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params,function(){
            Ext.lt.ui.loadingClose();
        });
    }

    //送审情况
    cmp.showwfinfo = function (){
        common.auditquery(datatable);
    }

    /**
     * 左侧页签切换触发函数.
     */
    tabChange = function (obj) {
        _treeid = "treeroot";
        _isleaf = 0;
        _lefttabtype = obj["code"];
        _lefttreename = obj["name"];
        _lefthidebtn = obj.hidebtns;
        _leftmenuid = obj.leftmenuid;
        _workflow = obj.leftwfid;
        cmp.refdrawtable(obj);
        common.setTabNum(obj);
        common.setworkflow(_workflow);
        common.changTooltoolbuttontStatus(0,  _lefthidebtn + "," + _tabhidtbtn);
        var params = {};
        params.menuid = _leftmenuid;
        params.lefttabtype = _lefttabtype;
        params.leftmenuid = _leftmenuid;
        var datalist = Ext.lt.RCP.asyncall(service , "getTreeData", params);
        lefttree.setRecordset(datalist, 0);
        if (!isFirst) {
            Ext.lt.pmkpi.query();
        }
        obj.datas = datalist
        return obj;
    }

    /**
     * 重新构建表格.
     */
    cmp.refdrawtable = function(obj){
        var oldcols = zcolumns;
        datatable.columns.checkbox.style = "text-align:center";
        var columns = [datatable.columns.seq,datatable.columns.checkbox];
        $.each(oldcols, function(i, item){
            if (item){
                if (obj["code"] == 'INDEXCOMFUNC' || obj["code"] == 'INDEXCOMFUNC_ZJ' || obj["code"] == 'INDEXCOMFUNC_HuBei'
                    || obj["code"] == 'PMKPIDEPT' || "PMKPIAGENCYALLPAY" == obj["code"]){
                    if (!item.config["iscommon"]||item["config"]["iscommon"] == 0){
                        item.display = true;
                        item.isvisiable = 1;
                    } else {
                        item.display = false;
                        item.isvisiable = 0;
                    }
                }
                if (obj["code"] == 'IDEXCOMCLS'){
                    if (!item.config["iscommon"]||item["config"]["iscommon"] == 1){
                        item.display = true;
                        item.isvisiable = 1;
                    } else {
                        item.display = false;
                        item.isvisiable = 0;
                    }
                }
                columns.push(item);
            }
        });
        Ext.lt.cache.removeData("dtcolumn_" + datatable.id);
        datatable.setCols(columns);
        datatable.setSelfdefconfig({config: "{}"});
        datatable.redraw();
    }

    ///////////////////部门端走工作流
    /**
     * 页签跳转.
     */
    cmp.clickTabpage = function (obj) {
        _tabhidtbtn = obj.hidebtns;
        _tabfilter = obj.filter;
        _tabcode = obj.code;
        if (!isFirst) {
            common.changTooltoolbuttontStatus(0, _tabhidtbtn + "," + _lefthidebtn);
            Ext.lt.pmkpi.query();
        }
    }
    /**
     * 流程审核.
     */
    cmp.wfAudit=function(obj){
        var datas = datatable.getSelected();
        if (datas.length <= 0) {
            Ext.lt.ui.alert("请选择要" + obj["name"] + "的数据！",function(){});
            return;
        }
        if (!common.checkwfstatus(datas)) return false;//先校验审核状态是否一致
        var params = {};
        params.datas = datas;
        params.workflow = _workflow;
        var pconfig = JSON.parse(obj.config);
        if (pconfig && pconfig.action  && pconfig.action == "audit"){
            pconfig.remark = true;
        }
        obj.config = JSON.stringify(pconfig);
        common.doAction(obj, params);
    }

    /**
     * 工作流
     * @param obj
     * @param params
     */
    cmp.doAction = function(btnobj, params) {
        var actioncode = btnobj.code;
        var actionname = btnobj.name;
        params.actioncode = actioncode;
        //params.remark = remark;
        params.workflow = _workflow;
        params.menuid = _leftmenuid;
        params.busguid = 'popopopopo123';

        Ext.lt.ui.prompt({labelwidth:80,h:240,w:420,elements:[{"name": "remark", "label": actionname + "意见", "type": "textarea","isrequired":false,"maxlength":255,"labelwidth":70,"columnsize":1,"rowsize":4,"defaultvalue": "同意" + actionname,"tipstext": "请录入..."}]},function(rsp){
            if(rsp){
                if (rsp["remark"] == ""){
                    rsp["remark"] = "同意"+actionname;
                }
                sendWFAction(rsp["remark"]);
            }
        });

        function sendWFAction(remark){
            params.actioncode = actioncode;
            params.remark = remark;
            params.workflow = _workflow;
            params.menuid = _leftmenuid;
            Ext.lt.ui.confirm('是否确定“' + actionname + '”已选择的数据？',null,function(is){
                if(is){
                    Ext.lt.ui.loadingShow();
                    Ext.lt.RCP.call(service, "wfAudit", params, function(rt){
                        if (rt && rt.success == true){
                            Ext.lt.ui.alert( actionname + "成功！",function(){
                                 cmp.query();
                            });
                        }
                        Ext.lt.ui.loadingClose();
                    },function(resp){
                        Ext.lt.ui.loadingClose();
                        var alertmsg = actionname + "失败！\n失败原因：" + resp;
                        Ext.lt.ui.alert(alertmsg,{timeout:5},function(){
                        });
                    });
                }
            });
        }
    }

    /**
     * 查看明细
     */
    cmp.detailed = function () {
        var selectDatas = datatable.getSelected();
        if (!selectDatas || selectDatas.length != 1) {
            Ext.lt.ui.alert("请选择一条指标进行查看明细！",function(){});
            return;
        }
        var url = "/pmkpi/indexlib/edit.page"; //个性
        if (_indextype=="finance" && _lefttabtype=="IDEXCOMCLS") {//共性指标
            url = "/pmkpi/indexlib/commedit.page";
        }
        var params = {};
        params.treeid = _treeid;
        params.indextype = _indextype;
        params.tabtype = _lefttabtype;
        params.pagetype = "mod";
        params.viewtype = "query";
        params.workflow = _workflow; //工作流
        params.guid = selectDatas[0]["guid"];
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, _scrWidth, _scrHeight,"查看指标");
    }

    return cmp;
}