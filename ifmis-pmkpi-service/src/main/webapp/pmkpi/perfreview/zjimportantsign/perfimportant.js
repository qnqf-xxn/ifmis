if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.zjimportantsign){
    Ext.lt.pmkpi.zjimportantsign = {};
}
Ext.lt.pmkpi.zjimportantsign.perfimportant = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var _menuid = config.menuid,
        _workflow,
        _datasource,//数据源集合
        _depthidemenuid = config.depthidemenuid,//项目的隐藏菜单
        _programhidemenuid = config.programhidemenuid,//部门的隐藏菜单
        _tablecode = 'v_perf_project_info',
        _deptcoldatas = config.deptcoldatas,//部门列数据
        _depttabledata = config.depttabledata,//部门表数据
        _procoldatas = config.procoldatas,//项目列数据
        _protabledata = config.protabledata,//项目表数据
        _deptqfdatas = config.deptqfdatas,//部门查询区数据
        _proqfdatas = config.proqfdatas,//项目查询区数据
        _defquery,//列表查询条件
        _lefttabtype = "program",//左侧页签类型
        _lefttreename = "项目支出",//左侧评价对象树名称 默认项目支出
        _tabfilter,
        _tabcode = "waitsign",
        _name,
        _saveAgency,//左侧树选择单位
        scrWidth =document.body.clientWidth,
        scrHeight =document.body.clientHeight;

    var serviceid = service;
    var isfirst = true;
    /**
     * 左侧页签切换触发函数.
     */
    tabChange = function (obj) {
        _saveAgency = "treeroot";
        Ext.lt.pmkpi.isleaf = '0';
        _lefttabtype = obj["code"];
        var data;
        var key;
        var cols;
        if (_lefttabtype == "program") {
            _lefttreename = "项目支出";
            _defquery = _protabledata.defquery;
            _tablecode = _protabledata.tablecode;
            cols = _procoldatas;
            //cmp.setTableColum(_procoldatas);
            data = _proqfdatas;
            key = '/pmkpi/review/importantsign/program';
            _menuid = _programhidemenuid;
        }else if(_lefttabtype == "dept"){
            _lefttreename = "部门整体";
            _defquery = _depttabledata.defquery;
            _tablecode = _depttabledata.tablecode;
            cols = _deptcoldatas;
            //cmp.setTableColum(_deptcoldatas);
            data = _deptqfdatas;
            key = '/pmkpi/review/importantsign/dept';
            _menuid = _depthidemenuid;
        }
        var params = {};
        params.tablecode = _tablecode;

        params.cols = cols;
        try{
            _datasource = Ext.lt.RCP.asyncall(service , "getDataSource", params);
            common.setColMapper(cols);
        }catch (e) {}
        cmp.setTableColum(cols);
        common.setworkflow(_workflow);
        queryfrom(data,key);
        Ext.lt.pmkpi.querytree();
        tabpage.doActiveTab(0);
        cmp.query();
    }

    //查询
    cmp.query = function (obj){
        query();
    }
    function query(){
        if(!_saveAgency){
            _saveAgency = "treeroot";
            Ext.lt.pmkpi.isleaf = 0;
        }
        Ext.lt.ui.loadingShow();
        var params = {};
        params.menuid = _menuid;
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.tablecode = _tablecode;
        params.tabfilter = _tabfilter;
        params.saveAgency = _saveAgency;
        params.lefttabtype = _lefttabtype;
        params.isleaf = Ext.lt.pmkpi.isleaf+"";
        params.tabcode = _tabcode;
        params.menuid = _menuid;
        common.setColDatasource(_datasource, datatable);
        Ext.lt.RCP.call(serviceid , "getDatas", params, function(rs){
            datatable.setDatas(rs.data);
            Ext.lt.ui.loadingClose();
        },function(){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('查询失败！',function(){
            });
        });
    }
    Ext.lt.pmkpi.querytree = function (){
        var params = {};
        params.menuid = _menuid;
        params.tablecode = _tablecode;
        params.lefttabtype = _lefttabtype;
        var datalist = Ext.lt.RCP.asyncall(serviceid , "getTreeData", params);
        lefttree.setRecordset(datalist, 0);
    }
    $(function (){
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        common.initDatatable();
        isfirst = false;
        var params = {};
        params.ordernum = 0;
        params.code = _lefttabtype;
        params.name = _lefttreename;
        setTimeout(function(){
            tabChange(params);
        },100);
    })
    /**
     * 左侧树点击
     */
    Ext.lt.message.hook("left", "click",function(obj){
        var treeNode = obj.node.data;
        if(treeNode){
            _saveAgency = treeNode.code;
            Ext.lt.pmkpi.isleaf = treeNode.isleaf;
        } else {
            _saveAgency = "treeroot";
            Ext.lt.pmkpi.isleaf = '0';
        }
        setTimeout(function() {   //延时查询
            cmp.query();
        }, 100);
    });
    //页签方法,切换页签，更改tablecode
    cmp.clickTabpage = function(obj){
        common.changTooltoolbuttontStatus(0,obj.hidebtns);
        _tabfilter = obj.filter;
        var config = eval('(' + obj.config + ')');
        if(config){
            if(_lefttabtype=="program"){
                _tablecode = config.programtablecode;
            }else if(_lefttabtype=="dept"){
                _tablecode = config.depttablecode;
            }
        }
        _tabcode = obj.code;
        if (!isfirst) {
            cmp.query();
        }
    }
    function queryfrom(data, key) {
        var configqueryform = {
            id: "queryform",
            fastquery : true,
            datatable : 'datatable',
            drawmode :'div',
            key: key,
            label: "快速查询",
            labelwidth: "120",
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
    Ext.lt.message.hook("datatable", "beforesetcols",function(obj) {
        var uiconfig = obj.table.uiconfig;
        var config = obj.table.config;
        _tablecode = uiconfig.tablecode;
        var cols = obj.cols;
    });
    cmp.sign = function (){
        var data = datatable.getSelected();
        Ext.lt.ui.confirm('是否标记已选中项目？',{icon: "warn"},function(is){
            if(is){
                Ext.lt.ui.loadingShow();
                var params = {};
                params.deldatas = data;
                params.tablecode = _tablecode;
                params.lefttabtype = _lefttabtype;
                params.code = "sign";
                Ext.lt.RCP.call(service , "revisionsign", params, function(rs){
                    Ext.lt.ui.loadingClose();
                    if (rs.flg=="1") {
                        Ext.lt.ui.alert('标记成功！',function(){
                            cmp.query();
                        });
                    }else{
                        Ext.lt.ui.alert(rs.message);
                    }
                },function(rs){
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert('标记失败！'+rs.message,function(){
                    });
                });
            }
        })
    }



    cmp.cancelsign = function (){
        var data = datatable.getSelected();
        Ext.lt.ui.confirm('是否取消标记已选中项目？',{icon: "warn"},function(is){
            if(is){
                Ext.lt.ui.loadingShow();
                var params = {};
                params.deldatas = data;
                params.tablecode = _tablecode;
                params.lefttabtype = _lefttabtype;
                params.code = "cancelsign";
                Ext.lt.RCP.call(service , "revisionsign", params, function(rs){
                    Ext.lt.ui.loadingClose();
                    if (rs.flg=="1") {
                        Ext.lt.ui.alert('取消标记成功！',function(){
                            cmp.query();
                        });
                    }else{
                        Ext.lt.ui.alert(rs.message);
                    }
                },function(rs){
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert('取消标记失败！'+rs.message,function(){
                    });
                });
            }
        })
    }
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
        datatable.setCols(c);
        var h = $("#queryform .busquerypanel").height();
        var buttonH = $('.busnomalbtn_outline').height();
        var tableh = scrHeight - h- buttonH-20;
        datatable.resize(scrWidth,tableh);
        datatable.headsort(false);
        datatable.setAllowcustom(false);
        datatable.setAllowClock(false);
        var page = {};//datatable.getPage();
        page.columns = "*";
        datatable.setPage(page);
        datatable.setSelfdefconfig({config: "{}"});
        datatable.redraw();
    }
    Ext.lt.message.hook("queryform", "doquery",function(obj){
        cmp.query();
    });
    return cmp;
}


