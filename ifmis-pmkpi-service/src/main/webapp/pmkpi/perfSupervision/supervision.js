if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}

if(!Ext.lt.pmkpi.perfSupervision){
    Ext.lt.pmkpi.perfSupervision = {};
}
var height;
var width;
Ext.lt.pmkpi.perfSupervision.index = function(config, service) {
    var deptcmp = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};

    var _menuid = config.menuid,//菜单id
        _propayworkflow = config.propayworkflow,//转移支付工作流guid
        _prodetailworkflow = config.prodetailworkflow,//二级项目工作流guid
        _promainworkflow = config.promainworkflow,//一级项目工作流guid
        _tablecode,
        _workflow,//工作流guid
        _prolev = config.prolev,//项目级次
        _prodetailqfdatas = config.prodetailqfdatas,//一级项目查询区数据
        _prodetailcoldatas = config.prodetailcoldatas,//一级项目列数据
        _prodetailtabledata = config.prodetailtabledata,//一级项目表数据
        _promainqfdatas = config.promainlqfdatas,//二级项目查询区数据
        _promaincoldatas = config.promaincoldatas,//二级项目列数据
        _promaintabledata = config.promaintabledata,//二级项目表数据
        _propayqfdatas = config.propayqfdatas,//转移支付项目查询区数据
        _propaycoldatas = config.propaycoldatas,//转移支付项目列数据
        _propaytabledata = config.propaytabledata,//转移支付项目表数据
        _lefttreename = "二级项目",//左侧评价对象树名称 默认项目支出
        _lefttabtype = "prodetail",//左侧树页签guid 默认项目支出
        _defquery,//列表查询条件
        _tabfilter,//页签查询条件
        _tabcode,//页签编码
        _saveAgency,//左侧树选择单位
        scrWidth = document.body.clientWidth,
        scrHeight = document.body.clientHeight;
    var isfirst = true;
    var serviceid = service;
    height = Math.floor(document.documentElement.clientHeight * 0.9);
    width =  Math.floor(document.documentElement.clientWidth * 0.9);

    Ext.lt.pmkpi.query = function(){
        if(!_saveAgency){
            _saveAgency = "treeroot";
            Ext.lt.pmkpi.isleaf = 0;
        }
        if(_saveAgency.length <=3){
            Ext.lt.pmkpi.isleaf = 2;
        }
        Ext.lt.ui.loadingShow();
        var params = {};
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.tablecode = _tablecode;
        params.tablesql = _defquery;
        params.menuid = _menuid;
        params.tabcode = _tabcode;
        params.prolev = _prolev;
        params.saveAgency = _saveAgency;
        params.isleaf = Ext.lt.pmkpi.isleaf+"";
        params.tabfilter = _tabfilter;
        params.workflow = _workflow;
        params.protype = _lefttabtype;
        params.beanid = "pmkpi.perfSupervision.PerfSupervisionBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params,function(){
            Ext.lt.ui.loadingClose();
        });
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

    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var cols = obj.cols;
        if(!Ext.lt.isArray(cols))
            cols = [cols];
        for(var i=0; i<cols.length; i++){
            var col = cols[i];
            if(col["colcode"] == "options"){
                col.oneditstart = function (table, el, l ,c, d){
                    return true;
                }
            }
        }
    });
    cmp.saveIndex = function(obj) {
        Ext.lt.ui.confirm("是否补录当前单位未推送监审一上指标的项目", null, function(is) {
            if (is) {
                var config = {};
                config.taskguid = "A69147082E975D0733386A42C3E5F4B5";
                config = Ext.lt.RCP.asyncall(serviceid, "saveIndex", config);
                if (config.error) {
                    Ext.lt.ui.alert(config.error);
                } else {
                    Ext.lt.ui.alert('操作成功！', function() {
                        Ext.lt.pmkpi.query();
                    });
                }
            }
        })
    }

    cmp.saveIndexES = function(obj) {
        Ext.lt.ui.confirm("是否补录当前单位未推送监审二上指标的项目", null, function(is) {
            if (is) {
                var config = {};
                config.taskguid = "9EE3A842793449818960559B00660C1B";
                config = Ext.lt.RCP.asyncall(serviceid, "saveIndex", config);
                if (config.error) {
                    Ext.lt.ui.alert(config.error);
                } else {
                    Ext.lt.ui.alert('操作成功！', function() {
                        Ext.lt.pmkpi.query();
                    });
                }
            }
        })
    }

    cmp.save = function() {
        var selecteds = datatable.getRecordSet().toArray();
        if (datatable.getRecordSet().toArray().length > 0) {
// 			if (selecteds.size() <= 0) {
// 				selecteds = cmp.uidatatable.getRecordSet().toArray();
// 			}
            var data = selecteds;
            for ( var i = 0; i < data.length; i++) {
                var adjoption = data[i].adjoption;
                if(adjoption=="指标不够完整"){
                    data[i].adjoption = "1";
                    adjoption = "1";				}
                if(adjoption=="指标不够细化、量化"){
                    data[i].adjoption = "2";
                    adjoption = "2";
                }
                if(adjoption=="指标与项目的相关性不够"){
                    data[i].adjoption = "3";
                    adjoption = "3";
                }
                if(adjoption=="指标与指标值不匹配"){
                    data[i].adjoption = "4";
                    adjoption = "4";
                }
                if(adjoption=="建议拆分指标"){
                    data[i].adjoption = "5";
                    adjoption = "5";
                }
                if(adjoption=="一级指标类型错误"){
                    data[i].adjoption = "6";
                    adjoption = "6";
                }
                if(adjoption=="二级指标类型错误"){
                    data[i].adjoption = "7";
                    adjoption = "7";
                }
                if(adjoption=="建议增加明确效益指标"){
                    data[i].adjoption = "8";
                    adjoption = "8";
                }
                if(adjoption=="建议增加明确产出指标"){
                    data[i].adjoption = "9";
                    adjoption = "9";
                }
                if(adjoption=="建议增加满意度指标"){
                    data[i].adjoption = "10";
                    adjoption = "10";
                }
                if(adjoption=="其他"){
                    data[i].adjoption = "11";
                    adjoption = "11";
                }
                var options = data[i].options;
                if(adjoption == "11" && (options == null || options == "")){
                    Ext.lt.ui.alert('当调整意见为“其他”时，需在其他意见填写内容!');
                    return;
                }
            }
            var config = {};
            config.list = data;
            config.tablecode = "PERF_T_SUPERVISION";
            config = Ext.lt.RCP.asyncall(serviceid, "save", config);
            if (config.error) {
                Ext.lt.ui.alert(config.error);
            } else {
                Ext.lt.ui.alert('操作成功！', function() {
                    Ext.lt.pmkpi.query();
                });
            }
        } else {
            Ext.lt.ui.alert('页面无数据！');
            return;
        }
    }
    cmp.showProjView = function(){
        var size = datatable.getRecordSet().size();
        if (size > 0) {
            var selecteds = datatable.getSelected();
            if (selecteds.size() <= 0) {
                Ext.lt.ui.alert('请选择要查看的数据！', function() {});
                return;
            }else if (selecteds.length > 1) {
                Ext.lt.ui.alert("查看详情只能选择一条数据！", {timeout : 1}, function() {});
                return;
            }else{

                var url = "/pdm/prodetail/detailinfo.page";
                var params = {};
                params.guid = selecteds[0].mainguid;
                url = Ext.lt.pmkpi.genPageUrl(url, params);
                Ext.lt.ui.openModalWindow(url,width, height,"查看项目详情")
            }

        } else {
            Ext.lt.ui.alert('页面无数据！');
            return;
        }
    }
    cmp.update = function(){
        var size = datatable.getRecordSet().size();
        if (size > 0) {
            var selecteds = datatable.getSelected();
            if (selecteds.size() <= 0) {
                Ext.lt.ui.alert('请选择要修改的数据！', function() {});
                return;
            }else{
                var guids = [];
                for (var i = 0; i < selecteds.size(); i++) {
                    guids.push(selecteds[i].indexguid);
                }
                var url = "/pmkpi/supervision/multiUpdate.page";
                var params = {};
                params.guids = guids;
                url = Ext.lt.pmkpi.genPageUrl(url, params);
                Ext.lt.ui.openModalWindow(url,width, height,"批量修改监审意见")
            }

        } else {
            Ext.lt.ui.alert('页面无数据！');
            return;
        }
    }
    cmp.sendtoAudit = function(obj) {
        var size = datatable.getRecordSet().size();
        if (size > 0) {
            var selectedsAll = datatable.getRecordSet().toArray();
            var selecteds = datatable.getSelected().size();
            var data = [];
            if (selecteds <= 0) {
                Ext.lt.ui.alert("请选择要" + obj.name + "的数据！", function() {});
                return;
            } else {
                selecteds = datatable.getSelected();
            }
            for ( var i = 0; i < selecteds.length; i++) {
                var mainguid = null;
                if(i > 0){
                    mainguid = selecteds[i].mainguid;
                    var mainguid1 = selecteds[i-1].mainguid;
                    if(mainguid != mainguid1){
                        for ( var k = 0; k < selectedsAll.length; k++) {
                            var mainguid2 = selectedsAll[k].mainguid;
                            if(mainguid == mainguid2){
                                data.push(selectedsAll[k]);
                            }
                        }
                    }
                } else {
                    mainguid = selecteds[i].mainguid;
                    for ( var k = 0; k < selectedsAll.length; k++) {
                        var mainguid1 = selectedsAll[k].mainguid;
                        if(mainguid == mainguid1){
                            data.push(selectedsAll[k]);
                        }
                    }
                }
            }
            if(obj.code == "audit"){
                for ( var i = 0; i < data.length; i++) {
                    var adjoption = data[i].adjoption;
                    if(adjoption=="其他"){
                        adjoption = "11";
                    }
                    var options = data[i].options;
                    if(adjoption == "11" && (options == null || options == "")){
                        Ext.lt.ui.alert('当调整意见为“其他”时，需在其他意见填写内容!');
                        return;
                    }
                }
            }
            //var data = selecteds;

            if(data.length > selecteds.length){
                Ext.lt.ui.confirm("该项目存在未勾选的指标，是否全部" + obj.name + "？", null, function(is) {
                    if (is) {
                        //var data = uidatatable.getSelected();
                        for ( var i = 0; i < data.length; i++) {
                            var adjoption = data[i].adjoption;
                            if(adjoption=="指标不够完整"){
                                data[i].adjoption = "1";
                            }
                            if(adjoption=="指标不够细化、量化"){
                                data[i].adjoption = "2";
                            }
                            if(adjoption=="指标与项目的相关性不够"){
                                data[i].adjoption = "3";
                            }
                            if(adjoption=="指标与指标值不匹配"){
                                data[i].adjoption = "4";
                            }
                            if(adjoption=="建议拆分指标"){
                                data[i].adjoption = "5";
                            }
                            if(adjoption=="一级指标类型错误"){
                                data[i].adjoption = "6";
                            }
                            if(adjoption=="二级指标类型错误"){
                                data[i].adjoption = "7";
                            }
                            if(adjoption=="建议增加明确效益指标"){
                                data[i].adjoption = "8";
                            }
                            if(adjoption=="建议增加明确产出指标"){
                                data[i].adjoption = "9";
                            }
                            if(adjoption=="建议增加满意度指标"){
                                data[i].adjoption = "10";
                            }
                            if(adjoption=="其他"){
                                data[i].adjoption = "11";
                            }
                        }
                        var config = {};
                        config.list = data;
                        config.tablecode = "PERF_T_SUPERVISION";
                        config = Ext.lt.RCP.asyncall(serviceid, "save", config);
                        if (config.error) {
                            Ext.lt.ui.alert(config.error);
                        } else {
                            var config = {};
                            config.list = data;
                            config.tablecode = "PERF_T_SUPERVISION";
                            config.workflow = _workflow;
                            deptcmp.doAction(obj, config);
                            // config = Ext.lt.RCP.asyncall(serviceid, "sendtoAudit", config);
                            // if (config.error) {
                            //     Ext.lt.ui.alert(config.error);
                            // } else {
                            //     Ext.lt.ui.alert('操作成功！', function() {
                            //         cmp.query();
                            //     });
                            // }
                        }
                    }
                });
            } else if(data.length == selecteds.length){
                Ext.lt.ui.confirm("是否确定" + obj.name + "已选择的数据？", null, function(is) {
                    if (is) {
                        //var data = uidatatable.getSelected();
                        for ( var i = 0; i < data.length; i++) {
                            var adjoption = data[i].adjoption;
                            if(adjoption=="指标不够完整"){
                                data[i].adjoption = "1";			}
                            if(adjoption=="指标不够细化、量化"){
                                data[i].adjoption = "2";
                            }
                            if(adjoption=="指标与项目的相关性不够"){
                                data[i].adjoption = "3";
                            }
                            if(adjoption=="指标与指标值不匹配"){
                                data[i].adjoption = "4";
                            }
                            if(adjoption=="建议拆分指标"){
                                data[i].adjoption = "5";
                            }
                            if(adjoption=="一级指标类型错误"){
                                data[i].adjoption = "6";
                            }
                            if(adjoption=="二级指标类型错误"){
                                data[i].adjoption = "7";
                            }
                            if(adjoption=="建议增加明确效益指标"){
                                data[i].adjoption = "8";
                            }
                            if(adjoption=="建议增加明确产出指标"){
                                data[i].adjoption = "9";
                            }
                            if(adjoption=="建议增加满意度指标"){
                                data[i].adjoption = "10";
                            }
                            if(adjoption=="其他"){
                                data[i].adjoption = "11";
                            }
                        }
                        var config = {};
                        config.list = data;
                        config.tablecode = "PERF_T_SUPERVISION";
                        config = Ext.lt.RCP.asyncall(serviceid, "save", config);
                        if (config.error) {
                            Ext.lt.ui.alert(config.error);
                        } else {
                            var config = {};
                            config.list = data;
                            config.tablecode = "PERF_T_SUPERVISION";
                            config.workflow = _workflow;
                            deptcmp.doAction(obj, config);
                            // config = Ext.lt.RCP.asyncall(serviceid, "sendtoAudit", config);
                            // if (config.error) {
                            //     Ext.lt.ui.alert(config.error);
                            // } else {
                            //     Ext.lt.ui.alert('操作成功！', function() {
                            //         cmp.query();
                            //     });
                            // }
                        }
                    }
                });
            }
        } else {
            Ext.lt.ui.alert('页面无数据！');
            return;
        }
    }
    //导出
    cmp.exportProj = function(){
        if (datatable.getRecordset().size() != 0) {
            var data = datatable.getSelected();
            var cfg = {};
            if (_lefttabtype == "propay"){
                cfg.key = '/pmkpi/propay/supervision/index';
                _workflow = _propayworkflow;
            } else if (_lefttabtype == "prodetail") {
                cfg.key = '/pmkpi/prodetail/supervision/index';
            } else if (_lefttabtype == "promain") {
                cfg.key = '/pmkpi/promain/supervision/index';
            }
            cfg.bustable = datatable;
            if(data.size()==0){
                if(Ext.lt.ui.confirm("是否导出当前全部数据？")){
                    cfg.hassql =1;
                    cfg.beanid = "pmkpi.perfSupervision.PerfSupervisionBOTX";
                    if(typeof (queryform) != 'undefined'){
                        cfg.isHaveQueryForm=true;//是否有查询区
                        cfg.queryConfig = queryform.getQueryParam();//查询区条件
                    }
                    cfg.isHaveTabPage=true;
                    cfg.filter = " 1=1 ";
                    cfg.downtype = 'xls';
                    dataexport.excelexport(cfg);
                }else{
                    return ;
                }
            }else{
                cfg.downtype = 'xls';//下载  类型
                dataexport.excelexport(cfg);
            }

        } else {
            Ext.lt.ui.alert("页面无数据！",{timeout:1},function(){});
            return;
        }
    }

    //导入
    cmp.importProj = function(){
        var url = "/pmkpi/perfSupervision/resultFile.jsp";
        var params = {};
        params.menuid = _menuid;
        Ext.lt.ui.openModalWindow(url,width, height,"监审结果导入");
    }

    cmp.showwfinfo = function(){
        var data = datatable.getSelected();
        if(data.size()==1){
            var params = {};
            params.submenu = _menuid;
            params.pro_code = data[0].mainguid;
            deptcmp.proinfoview(datatable,params);
        } else if(data.size() > 1) {
            Ext.lt.ui.alert('每次只能查看一条数据！',function(){});
        } else {
            Ext.lt.ui.alert('请选择要查看的数据！',function(){});
        }
    }


    //送审情况
    cmp.queryaudit = function (){
        deptcmp.auditquery(datatable);
    }

    /**
     *工作流.
     */
    cmp.wfAudit = function (obj) {
        var datas = datatable.getSelected();
        if (datas.length <= 0) {
            Ext.lt.ui.alert("请选择要" + obj.name + "的数据！", function () {
            });
            return;
        }
        if (!deptcmp.checkwfstatus(datas)) return false;//先校验审核状态是否一致
        var params = {};
        params.datas = datas;
        params.tablecode = "PERF_T_SUPERVISION";
        params.workflow = _workflow;
        params.busguid = _lefttabtype + "_" + datas[0]["wfstatus"];
        deptcmp.doAction(obj, params);
    }

    //页签方法
    cmp.clickTabpage = function(obj){
        // changToolbuttonStatus(toolbutton, parseInt(obj.ordernum), obj.hidebtns);
        deptcmp.changTooltoolbuttontStatus(0,obj.hidebtns);
        _tabfilter = obj.filter;
        _tabcode = obj.code;
        if(!isfirst){
            Ext.lt.pmkpi.query();
        }
    }

    /**
     * 左侧页签切换触发函数.
     */
    tabChange = function (obj) {
        _saveAgency = "treeroot";
        Ext.lt.pmkpi.isleaf = '0';
        _lefttabtype = obj["code"];
        _lefttreename = obj["name"];
        var data;
        var key;
        if (_lefttabtype == "propay"){
            _defquery = _propaytabledata.defquery;
            _tablecode = _propaytabledata.tablecode;
            //cmp.setTableColum(_propaycoldatas);
            data = _propayqfdatas;
            key = '/pmkpi/propay/supervision/index';
            _workflow = _propayworkflow;
        } else if (_lefttabtype == "prodetail") {
            _defquery = _prodetailtabledata.defquery;
            _tablecode = _prodetailtabledata.tablecode;
            key = '/pmkpi/prodetail/supervision/index';
            //cmp.setTableColum(_prodetailcoldatas);
            data = _prodetailqfdatas;
            _workflow = _prodetailworkflow;
        } else if (_lefttabtype == "promain") {
            _defquery = _promaintabledata.defquery;
            _tablecode = _promaintabledata.tablecode;
            key = '/pmkpi/promain/supervision/index';
            //cmp.setTableColum(_promaincoldatas);
            data = _promainqfdatas;
            _workflow = _promainworkflow;
        }
        _prolev = _lefttabtype;
        deptcmp.setworkflow(_workflow);
        queryfrom(data,key);
        Ext.lt.pmkpi.querytree();
        Ext.lt.pmkpi.query();
    }

    Ext.lt.pmkpi.querytree = function (){
        var params = {};
        params.menuid = _menuid;
        params.tablecode = _tablecode;
        params.protype = _lefttabtype;
        var datalist = Ext.lt.RCP.asyncall(service , "getTreeData", params);
        lefttree.setRecordset(datalist, 0);
    }

    function queryfrom(data, key) {
        var configqueryform = {
            id: "queryform",
            fastquery : true,
            datatable : 'datatable',
            drawmode :'div',
            key: key,
            label: "快速查询",
            labelwidtreporttraceh: "120",
            appid: "pmkpi",
            config: null,
            serverid: key,
            amtmaxlength:18,
            columnsize: 5,
            data: data
        }
        queryform = new Ext.lt.bus.ui.querypanel(configqueryform);
        queryform.draw($(".busquerypanel_outline")[0]);
    }

    $(function (){
        isfirst = false;
        var params = {};
        params.ordernum = 0;
        params.code = _lefttabtype;
        params.name = _lefttreename;
        tabChange(params);
    })

    /**
     * 动态配置表格的列.
     *
     * @param data --
     */
    cmp.setTableColum = function(cols){
        var c = [];
        var tmainCol = datatable.getCols();
        c.push(tmainCol[0]);
        c.push(tmainCol[1]);
        for (var i=0; i<cols.length; i++) {
            c.push(cols[i]);
        }
        //Ext.lt.cache.removeData("dtcolumn_" + datatable.id);
        datatable.setCols(c);
        var h = $("#queryform .busquerypanel").height();
        var buttonH = $('.busnomalbtn_outline').height();
        var tableh = scrHeight - h- buttonH-20;
        //datatable.resize(scrWidth,tableh);
        datatable.headsort(false);
        datatable.setAllowcustom(false);
        datatable.setAllowClock(false);
        var page = {};//datatable.getPage();
        page.columns = "*";
        datatable.setPage(page);
        datatable.redraw();
        Ext.lt.message.send("datatable", 'beforesetcols', {
            table: datatable,
            cols: cols
        });
    }

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

    // Ai辅助审核
    cmp.AIaudit = function (btn) {
        btn.lefttabtype = _lefttabtype;
        deptcmp.AIaudit(btn);
    }

    return cmp;
}