if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.deptevaluation){
    Ext.lt.pmkpi.deptevaluation = {};
}

Ext.lt.pmkpi.deptevaluation.report = function(config, service){
    var cmp = {};
    var common = Ext.lt.pmkpi.perfcommon(config, service);

    var _menuid = config.menuid,//菜单id
        _leftmenuid,//隐藏菜单
        _lefttab = config.lefttab,//左侧树第一个页签
        _lefttabtype = _lefttab.code,//左侧树页签类型
        _lefttreename,//左侧评价对象树名称
        _lefthidebtn,//左侧树隐藏按钮
        _tabhidtbtn,//右侧页签隐藏按钮
        _hidename = config.hidename,
        _workflow,//工作流guid
        _prolev = config.prolev,//项目级次
        _displaycols = [],
        _tabcode,//页签编码
        _tabfilter,//页签过滤条件
        _defquery,
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
        _lefttabtype = obj["code"];
        _lefttreename = obj["name"];
        _workflow = obj.leftwfid;
        _leftmenuid = obj.leftmenuid;
        _lefthidebtn = obj.hidebtns;
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
        params.bustype = _bustype;
        params.hidename = _hidename;
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
        params.hidename = _hidename;
        params.leftmenuid = _leftmenuid;
        params.tabcode = _tabcode;
        params.tablesql = _defquery;
        params.beanid = "pmkpi.evaluation.dept.report.DeptReportBOTX";
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
        if (datas.length <= 0) {
            Ext.lt.ui.alert("请选择要" + obj.name + "的数据！",function(){});
            return;
        }
        if (!common.checkwfstatus(datas)) return false;//先校验审核状态是否一致
        var params = {};
        params.datas = datas;
        params.busguid = _lefttabtype + _hidename + "_" + datas[0]["wfstatus"];
        common.doAction(obj, params);
    }


    /**
     * 删除
     */
    cmp.del = function (){
        var data = datatable.getSelected();
        if(!data || data.length <= 0){
            Ext.lt.ui.alert("请选择要删除的数据！",function(){});
            return;
        }
        Ext.lt.ui.confirm('是否删除已选择数据？',null,function(is){
            if(is){
                Ext.lt.ui.loadingShow();
                var params = {};
                params.data = data;
                Ext.lt.RCP.call(service , "del", params, function(rs){
                    Ext.lt.ui.loadingClose();
                    if (rs.flg=="1") {
                        Ext.lt.ui.alert('删除成功！',function(){
                            Ext.lt.pmkpi.querytree();
                            Ext.lt.pmkpi.query();
                        });
                    }
                },function(){
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert('删除失败！',function(){
                    });
                });
            }
        })
    }

    /**
     * 选择项目
     */
    cmp.checkprogram = function(){
        var params = {};
        params.workflow = _workflow;
        params.prolev = _prolev;
        params.saveAgency = _saveAgency;
        params.bustype = _lefttabtype;
        params.leftmenuid = _leftmenuid;
        params.hidename = _hidename;
        var url = "";
        if (_lefttabtype && "program" == _lefttabtype) { //项目支出
            url = "/pmkpi/evaluation/dept/procheck.page";
        } else if (_lefttabtype && "dept" == _lefttabtype) { //部门整体
            url = "/pmkpi/evaluation/dept/deptcheck.page";
        }
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,scrWidth - 200,scrHeight - 200,"选择项目-"+_lefttreename);
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
    //导入
    cmp.importProData = function(obj){
        if (_lefttabtype && "program" == _lefttabtype) {//项目导入
            var tokenid = Ext.lt.getparam("tokenid");
            var configmap = eval('('+obj.config+')')
            var importcode = configmap.importcode;
            var vchtypeid = configmap.vchtypeid;
            var params = {};
            params.vchtypeid = vchtypeid;
            params.tabtype = _lefttabtype;
            params.pagetype = "add";
            params.workflow = _workflow;
            params.isNINGXIA = _isNINGXIA;
            window.importparam = params;
            Ext.lt.importdata.imports(tokenid,importcode,vchtypeid,Object.toJSON(params),function(){
                window.parent.Ext.lt.outfile.window.close();
                parent.Ext.lt.pmkpi.querytree();
                parent.Ext.lt.pmkpi.query();
            });
        }
    }

    /**
     * 宁夏新增
     */
    cmp.add = function (){
        var params = {};
        params.mainguid = getCreateguid(service);
        params.workflow = _workflow;
        params.prolev = _prolev;
        params.bustype = _lefttabtype;
        params.viewtype = "add";
        params.hidetab = ['score','addinfo'];
        params.leftmenuid = _leftmenuid;
        var url = "";
        if (_lefttabtype && "program" == _lefttabtype) { //项目支出
            url = "/pmkpi/evaluation/dept/proedit.page";
        }
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight, "部门评价项目确定-"+_lefttreename);
    }

    /**
     * 修改
     */
    cmp.mod = function () {
        var data = datatable.getSelected();
        if(!data || data.length != 1){
            Ext.lt.ui.alert("请选中一条数据进行调整！",function(){});
            return;
        }
        var guid = data[0].guid;
        var params = {};
        params.saveAgency = data[0].agencyguid;
        params.mainguid = guid;
        params.projguid = data[0].proguid;
        params.workflow = _workflow;
        params.prolev = _prolev;
        params.projcode = data[0].pro_code;
        params.bustype = _lefttabtype;
        params.viewtype = "mod";
        params.hidetab = ['score','addinfo'];
        params.leftmenuid = _leftmenuid;
        var url = "";
        if (_lefttabtype && "program" == _lefttabtype) { //项目支出
            url = "/pmkpi/evaluation/dept/proedit.page";
        }
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight, "部门评价项目确定-"+_lefttreename);
    }

    return cmp;
}