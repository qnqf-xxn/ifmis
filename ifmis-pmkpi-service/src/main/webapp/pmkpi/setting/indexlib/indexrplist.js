if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.indexlist)
    Ext.lt.pmkpi.indexlist = {};

var zcolumns = {};
Ext.lt.pmkpi.indexlist = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var _treeid,
        _lefttreename,//左侧评价对象树名称 默认项目支出
        _lefthidebtn,//左侧树隐藏按钮
        _tabhidtbtn,//右侧页签隐藏按钮
        _leftmenuid,//隐藏菜单
        _lefttab = config.lefttab,//左侧树第一个页签
        _lefttabtype = _lefttab.code,//左侧树页签类型
        _levelno = 1,
        _indextype = config["pagetype"],
        _isupagency = config.isupagency,
        _isleaf,
        _treeNode,
        _tabfilter, //页签标签
        _tabcode, ////页签编码
        _scrWidth =document.body.clientWidth,
        _scrHeight =document.body.clientHeight,
        _queryfilter,
        _workflow,
        _proelement,
        _treename;//左侧树菜单名称
    var isGx = config["isGx"];
    var isHubei = config["isHubei"];

    var cmp = {};

    var isFirst = true;

    /**
     * 加载完成后执行.
     */
    $(function () {
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        common.initDatatable();
        _lefttab = lefttree.getActiveTabCfg();
        common.pendingtasktab();
        tabChange(_lefttab);
        isFirst = false;
    })

    Ext.lt.message.hook("left", "click",function(obj){
        var treeNode = obj.node.data;
        if (treeNode){
            _treeid = treeNode.guid;
            _isleaf = treeNode.isleaf;
            _levelno = treeNode.levelno;
            _treename = treeNode.name;
            _treeNode = treeNode;
            _proelement = treeNode.proelement;
        } else {
            _treeid = "treeroot";
            _isleaf = 0;
            _levelno=0;
        }
        cmp.query();
    });
    Ext.lt.message.hook("queryform", "doquery",function(obj){
        if (obj.queryform){
            //params.queryConfig = obj.queryform.getQueryParam();
            _queryfilter = obj.queryform.getQuerySQL();
        }
        cmp.query(_queryfilter);
    });
    /**
     * 查询
     */
    Ext.lt.pmkpi.query = function(){
        cmp.query();
    }
    Ext.lt.message.hook("datatable", 'drawed',function(obj){
        var uiconfig = obj.uiconfig;
        zcolumns = uiconfig.columns;
        $.each(zcolumns, function(i, item){
            if(item && item["isvisiable"] == 0){
                delete zcolumns[i];
            }
        });
    });
    /**
     * 查询
     * @filter --条件
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
        params.tabfilter = _tabfilter; //页签过滤条件
        params.workflow = _workflow; //工作流
        params.levelno = _levelno;
        if (filter) {
            params.querySql = filter; //工作流
        }
        try{
            if (!queryform)params.queryConfig = queryform.getQueryParam();
            params.querySql = queryform.getQuerySQL();
        }catch (e) {}
        Ext.lt.ui.loadingShow();
        params.beanid = "pmkpi.setting.indexlib.report.IndexRpBOTx";
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
     * 新增
     */
    cmp.add = function () {
        //不是提级用户，且是单位，非末级节点不可新增
        if ((!_treeid || 1!= _isleaf) && _lefttabtype!="INDEXCOMFUNC_ZJ" && _lefttabtype!="INDEXCOMFUNC_HuBei" && ("1" != _isupagency && "PMKPIAGENCYALLPAY" == _lefttabtype)) {
            Ext.lt.ui.alert("请选择左侧末级结点进行新增！",function(){});
            return;
        }
        if (_lefttabtype =="INDEXCOMFUNC_JiangXi" && _levelno < 5) {
            Ext.lt.ui.alert("请选择左侧末级结点进行新增！",function(){});
            return;
        }
        if(!_treeid && (_lefttabtype =="INDEXCOMFUNC_ZJ" || _lefttabtype =="INDEXCOMFUNC_HuBei")){ //湖北与浙江展示项目，可以选择一级项目
            Ext.lt.ui.alert("请选择左侧结点进行新增！",function(){});
            return;
        }
        if((_treeid && _lefttabtype =="INDEXCOMFUNC_ZJ" && _levelno <1) ||_treeid=="treeroot"){
            Ext.lt.ui.alert("请选择左侧下级结点进行新增！",function(){});
            return;
        }
        if((_treeid && _lefttabtype =="INDEXCOMFUNC_HuBei" && _levelno <3) || _treeid=="treeroot"){
            Ext.lt.ui.alert("请选择左侧下级结点进行新增！",function(){});
            return;
        }
        var url = "/pmkpi/indexlib/edit.page"; //个性
        if (_indextype=="finance" && _lefttabtype=="IDEXCOMCLS") {//共性指标
            url = "/pmkpi/indexlib/commedit.page";
        }
        var params = {};
        params.treeid = _treeid;
        params.treename = _treename;
        params.superid = _treeNode["superguid"];
        params.indextype = _indextype;
        params.tabtype = _lefttabtype;
        params.pagetype = "add";
        params.workflow = _workflow; //工作流
        params.agency = _treeNode["agencyguid"];
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, _scrWidth, _scrHeight,"新增指标");
    }

    /**
     * 选择调整
    */
    cmp.check = function(){
        var params = {};
        var treename ="";
        params.workflow = _workflow;
        params.treeid = _treeid;
        params.indextype = _indextype;
        params.tabtype = _lefttabtype;
        params.leftmenuid = _leftmenuid;
        var url = "";
        if ("INDEXCOMFUNC_SX" == _lefttabtype || "INDEXCOMFUNC_JiangXi" == _lefttabtype || "INDEXCOMFUNC_HuBei" == _lefttabtype || "INDEXCOMFUNC" == _lefttabtype || "INDEXCOMFUNC_ZJ" == _lefttabtype) { //项目支出
            treename = "项目支出";
            url = "/pmkpi/indexlib/procheck.page";
        } else if ("dept" == _indextype || "PMKPIDEPT" == _lefttabtype || "PMKPIAGENCYALLPAY" == _lefttabtype) { //部门整体
            treename = "部门整体";
            url = "/pmkpi/indexlib/deptcheck.page";
        }
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, _scrWidth * 0.9, _scrHeight * 0.9, "选择指标-" + treename);
    }

    /**
     * 修改
     */
    cmp.mod = function () {
        var selectDatas = datatable.getSelected();
        if (!selectDatas || selectDatas.length != 1) {
            Ext.lt.ui.alert("请选择一条指标进行修改！",function(){});
            return;
        }
        if (selectDatas[0].adjuststatus == "3"){ //数据状态 3:删除   1:新增   2:修改
            Ext.lt.ui.alert("删除状态的数据不能修改！",function(){});
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
        params.workflow = _workflow; //工作流
        params.guid = selectDatas[0]["guid"];
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, _scrWidth, _scrHeight,"修改指标");
    }

    /**
     * 删除
     */
    cmp.del = function () {
        var datas = datatable.getSelected();
        if (!datas || datas.size() <= 0) {
            Ext.lt.ui.alert('请选择要删除的数据！',function(){
            });
            return;
        }
        var params = {};
        params.selDatas = datas;
        Ext.lt.ui.confirm('是否删除已选择数据？',null,function(is){
            if(is){
                Ext.lt.ui.loadingShow();
                Ext.lt.RCP.call(service , "del", params, function(rs){
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert('删除成功！',function(){
                        cmp.query();
                    });
                },function(){
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert('删除失败！',function(){
                    });
                });
            }
        })
    }

    /**
     * 删除项目(如有下级也一起删除)
     */
    cmp.delpro = function () {
        if(_proelement){
            if((_proelement == "01" && _levelno == "1") || (_proelement == "02" && (_levelno == "1" || _levelno == "2"))){//选择左侧树分类
                Ext.lt.ui.alert('请选择一级或二级项目！',function(){
                });
                return;
            }
        }else{
            if(!_treeid || _treeid == "treeroot"){
                Ext.lt.ui.alert('请选择左侧树！',function(){
                });
                return;
            }else{
                var params = {};
                params.treeid = _treeid;
                Ext.lt.ui.confirm('所选项目以及项目指标一同删除（如有下级也一同删除），请确认？',null,function(is){
                    if(is){
                        Ext.lt.ui.loadingShow();
                        Ext.lt.RCP.call(service , "delpro", params, function(rs){
                            Ext.lt.ui.loadingClose();
                            Ext.lt.ui.alert('删除成功！',function(){
                                cmp.query();
                                _lefttab = lefttree.getActiveTabCfg();
                                tabChange(_lefttab);
                            });
                        },function(){
                            Ext.lt.ui.loadingClose();
                            Ext.lt.ui.alert('删除失败！',function(){
                            });
                        });
                    }
                })
            }
        }

    }

    /**
     * 调整指标申请
     */
    cmp.modWf = function (obj) {
        var datas = datatable.getSelected();
        if (datas.length <= 0) {
            Ext.lt.ui.alert("请选择要" + obj["name"] + "的数据！",function(){});
            return;
        }
        var params = {};
        params.datas = datas;
        params.workflow = _workflow;
        params.workflowtype = "2"; //申请状态：1-新增申请；2-调整申请；3-删除申请；
        cmp.doAction(obj, params);
    }

    /**
     * 删除指标申请
     */
    cmp.delWf = function (obj) {
        var datas = datatable.getSelected();
        if (datas.length <= 0) {
            Ext.lt.ui.alert("请选择要" + obj["name"] + "的数据！",function(){});
            return;
        }
        var params = {};
        params.datas = datas;
        params.workflow = _workflow;
        params.workflowtype = "3"; //申请状态：1-新增申请；2-调整申请；3-删除申请；
        cmp.doAction(obj, params);
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
            if(item){
                if (obj["code"] == 'INDEXCOMFUNC' || obj["code"] == 'INDEXCOMFUNC_JiangXi'|| obj["code"] == 'INDEXCOMFUNC_ZJ' || obj["code"] == 'INDEXCOMFUNC_HuBei'
                    ||obj["code"] == 'PMKPIDEPT' || obj["code"] == 'INDEXTRANPAY' || obj["code"] == 'PMKPIAGENCYALLPAY'){
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

                if (obj["code"] == 'INDEXTRANPAY'){
                    if ((item["config"]["lefttype"] == _lefttabtype && item["config"]["iscommon"] == 0) || item["config"]["iscommon"] == 1){
                        item.display = false;
                        item.isvisiable = 0;
                    } else {
                        item.display = true;
                        item.isvisiable = 1;
                    }
                }
                columns.push(item);
            }
        });
        Ext.lt.cache.removeData("dtcolumn_" + datatable.id);
        datatable.setCols(columns);
        datatable.setDatas([]);
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
        cmp.doAction(obj, params);
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

    //导入
    cmp["import"] = function(obj){
        // 暂时写死导入模板的code
        if(isGx != null && "1" == isGx && obj.code != "commonimport"){
            var impparams = {};
            var checkflg = Ext.lt.RCP.asyncall(service , "checkImpkey", impparams);
            if (!checkflg) {
                Ext.lt.ui.alert("指标导入基础配置错误，请联系管理员!", function () {
                });
                return;
            }
        }
        var importcode = "";
        var vchtypeid = "";
        if (obj.code == "commonimport") { //共性指标导入
            importcode = "120011001";
            vchtypeid = "C0EC31E80959F7D9E053B11FA8C07BC8";
        } else if (obj.code == "uncommonimport") { //个性指标导入
            importcode = "120011002";
            vchtypeid = "C0EC31E80963F7D9E053B11FA8C07BC8";
        } else if (obj.code == "programimport" && isHubei != "1") { //部门指标-项目支出
            importcode = "120011003";
            vchtypeid = "C42CC9125A06AD57E053B11FA8C0BE78";
        } else if (obj.code == "deptimport") { //部门指标-部门整体
            importcode = "120011005";
            vchtypeid = "072BCB4EC3985E83E0630A64A8C0F723";
        } else if (obj.code == "tranpayimport") { //转移支付指标
            importcode = "120011004";
            vchtypeid = "ED154520471A0B42E0533315A8C0D3C2";
        }else if (obj.code =="programimport" && isHubei != null && "1" == isHubei){  //部门指标-项目支出 湖北导入模板
            importcode = "120011006";
            vchtypeid = "07D10FA570AF712DE0630A64A8C0264D";
        }
        var tokenid = Ext.lt.getparam("tokenid");
        // 调用导入接口，需要参数有tokenid,模板编码，单据id，args组合传给后台的参数
        var params = {};
        params.vchtypeid = vchtypeid;
        params.tabtype = _lefttabtype;
        params.indextype = _indextype;
        params.pagetype = "add";
        params.workflow = _workflow;
        params.menuid = _leftmenuid;
        window.importparam = params;
        // parent.document.getElementById("importdata");
        // $(window.frames[0].document).contents().find("#importdata").hide();
        Ext.lt.importdata.imports(tokenid,importcode,vchtypeid,Object.toJSON(params),function(){
            window.parent.Ext.lt.outfile.window.close();
            parent.Ext.lt.pmkpi.impsucess();
        });
    }

    Ext.lt.pmkpi.impsucess = function (){
        Ext.lt.ui.alert("导入成功！",function(){
            //湖北模式，左侧树展示项目，导入项目指标时判断项目是否存在，不存在项目也保存到码表中
            if(isHubei != null && "1" == isHubei){
                //导入成功时刷新左侧树、刷新列表
                _lefttab = lefttree.getActiveTabCfg();
                tabChange(_lefttab);
            }else {
                Ext.lt.pmkpi.query();
            }
        });
    }

    return cmp;
}